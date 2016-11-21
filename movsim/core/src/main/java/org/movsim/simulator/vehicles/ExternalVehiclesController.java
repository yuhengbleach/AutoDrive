package org.movsim.simulator.vehicles;

import java.awt.*;
import java.util.*;
import java.util.List;
import java.util.Map.Entry;

import Ros.*;
import com.google.common.primitives.Shorts;
import com.google.common.util.concurrent.ListenableFuture;
import org.apache.commons.logging.Log;
import org.apache.thrift.TException;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.movsim.autogen.AccelerationModelType;
import org.movsim.roadmappings.PosTheta;
import org.movsim.roadmappings.RoadMapping;
import org.movsim.scenario.vehicle.autogen.ExternalVehicleType;
import org.movsim.scenario.vehicle.autogen.MovsimExternalVehicleControl;
import org.movsim.scenario.vehicle.autogen.SpeedDataType;
import org.movsim.scenario.vehicle.autogen.VehicleUserDataType;
import org.movsim.simulator.roadnetwork.LaneSegment;
import org.movsim.simulator.roadnetwork.RoadNetwork;
import org.movsim.simulator.roadnetwork.RoadSegment;
import org.movsim.simulator.vehicles.longitudinalmodel.acceleration.LongitudinalModelFactory;
import org.movsim.simulator.vehicles.longitudinalmodel.acceleration.ModelParameters;
import org.movsim.utilities.LinearInterpolatedFunction;
import org.movsim.utilities.TimeUtilities;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.base.Preconditions;

public class ExternalVehiclesController {

    private static final Logger LOG = LoggerFactory.getLogger(ExternalVehiclesController.class);

    /** time-sorted map of external vehicle input data */
    private final SortedMap<Double, List<ExternalVehicleType>> externalVehicleInputsToAdd = new TreeMap<>();

    /** time-sorted map of vehicles to remove */
    private final SortedMap<Double, List<Vehicle>> externalVehiclesToRemove = new TreeMap<>();

    private final Map<Vehicle, LinearInterpolatedFunction> controlledVehicles = new HashMap<>();

    private Vehicle selfVehicles;

    private String timeFormat;

    private RosService.Client client;

    private List<Pose> poseList;

    public ExternalVehiclesController() {
        try {
            TTransport transport;
            transport = new TSocket("localhost", 23333);
            transport.open();
            TProtocol protocol = new  TBinaryProtocol(transport);
            client = new RosService.Client(protocol);
        } catch (TException x) {
            x.printStackTrace();
        }
    }

    public void setInput(MovsimExternalVehicleControl input) {
        Preconditions.checkNotNull(input);
        this.timeFormat = input.getTimeFormat();
        createExternalVehicleData(input);
    }

    /**
     * sets the speeds of externally controlled vehicles in whole road network
     */
    public void setSpeeds(double simulationTime) {
        for (Entry<Vehicle, LinearInterpolatedFunction> entry : controlledVehicles.entrySet()) {
            double currentSpeed = entry.getValue().value(simulationTime);
            Vehicle vehicle = entry.getKey();
            vehicle.setSpeed(currentSpeed);
        }
    }

    public void changeLane(double x, double y) {
        double newTheta = Math.atan2(y - selfVehicles.getOldY(), x - selfVehicles.getOldX());
        double angleDiff = Math.cos(selfVehicles.getTheta()) * Math.sin(newTheta)
                - Math.cos(newTheta) * Math.sin(selfVehicles.getTheta());
        if (angleDiff > 1e-3) {

        } else if (angleDiff < -1e-3) {

        }
    }

    private DynamicObstacle createDynamicObstacle(Vehicle vehicle) {
        DynamicObstacle dynamicObstacle = new DynamicObstacle();
        if (vehicle != null) {
            dynamicObstacle.setAcceleration(vehicle.getAcc());
            dynamicObstacle.setCenter_x(vehicle.getPositionX());
            dynamicObstacle.setCenter_y(vehicle.getPositionY());
            dynamicObstacle.setCenter_z(0);
            dynamicObstacle.setId(vehicle.getId());
            dynamicObstacle.setVelocity(vehicle.getSpeed());
            dynamicObstacle.setHeading(vehicle.getSelfTheta());
            dynamicObstacle.setLength(vehicle.getEffectiveLength());
            dynamicObstacle.setWidth(2);
            dynamicObstacle.setHeight(2);
            dynamicObstacle.setOmega(vehicle.getOmega());
        }
        return dynamicObstacle;
    }

    private Pose createPose(double simulationTime) {
        Pose pose = new Pose();
        pose.setTimestamp((long) simulationTime);
        pose.setX(selfVehicles.getPositionX());
        pose.setY(selfVehicles.getPositionY());
        pose.setTheta(selfVehicles.getSelfTheta());
        pose.setAcceleration(selfVehicles.getAcc());
        pose.setVelocity(selfVehicles.getSpeed());

        return pose;
    }

    private GridMap createGridMap(RoadNetwork roadNetwork) {
        GridMap gridMap = new GridMap();
        gridMap.setCenter_x((int) selfVehicles.getPositionX());
        gridMap.setCenter_y((int) selfVehicles.getPositionY());
        gridMap.setLength(150);
        gridMap.setWidth(100);

        List<Short> grid = Arrays.asList(new Short[1500000]);
        for (int i = 0; i < 1500000; ++i) {
            grid.set(i, (short) 0);
        }

        List<RoadSegment> roadRange = new ArrayList<>();
        if (selfVehicles.getRoadSegment().sourceRoadSegment(selfVehicles.lane()) != null)
            roadRange.add(selfVehicles.getRoadSegment().sourceRoadSegment(selfVehicles.lane()));
        roadRange.add(selfVehicles.getRoadSegment());
        if (selfVehicles.getRoadSegment().sinkRoadSegment(selfVehicles.lane()) != null)
            roadRange.add(selfVehicles.getRoadSegment().sinkRoadSegment(selfVehicles.lane()));

        for (RoadSegment roadSegment : roadNetwork) {
            for (LaneSegment laneSegment : roadSegment.getLaneSegments()) {
                for (Vehicle vehicle : laneSegment) {
                    if (!vehicle.isOurs()) {
                        RoadMapping.PolygonFloat polygon = vehicle.getRoadSegment().roadMapping().mapFloat(vehicle);

                        double x[] = new double[4];
                        double y[] = new double[4];
                        double theta = selfVehicles.getRotateTheta();

                        for (int i = 0; i < 4; ++i) {
                            double oldX = polygon.getXPoint(i) - selfVehicles.getPositionX();
                            double oldY = polygon.getYPoint(i) - selfVehicles.getPositionY();

                            x[i] = oldX * Math.cos(theta) + oldY * Math.sin(theta);
                            y[i] = -oldX * Math.sin(theta) + oldY * Math.cos(theta);
                        }

                        int minX, minY, maxX, maxY;
                        minX = maxX = (int) (x[0] * 10);
                        minY = maxY = (int) (y[0] * 10);
                        for (int i = 1; i < 4; ++i) {
                            minX = Math.min(minX, (int) (x[i] * 10));
                            maxX = Math.max(maxX, (int) (x[i] * 10));
                            minY = Math.min(minY, (int) (y[i] * 10));
                            maxY = Math.max(maxY, (int) (y[i] * 10));
                        }

                        for (int posX = minX; posX <= maxX; ++posX) {
                            for (int posY = minY; posY <= maxY; ++posY) {
                                if (posX <= 100 && posX >= -50 && posY >= -50 && posY <= 50) {
                                    grid.set((1000 - posX) * 1000 + (500 - posY), (short) 1);
                                }
                            }
                        }
                    }
                }
            }
        }

//        for (int i = 0; i < 1500000; ++i) {
//            System.out.print(grid.get(i));
//            if (i % 1000 == 0)
//                System.out.println("");
//        }

        gridMap.setGrid_map(grid);
        return gridMap;
    }

    private boolean checkInRange(WayPoint pos) {
        double theta = selfVehicles.getRotateTheta();
        double oldX = pos.getX() - selfVehicles.getPositionX();
        double oldY = pos.getY() - selfVehicles.getPositionY();

        double x = oldX * Math.cos(theta) + oldY * Math.sin(theta);
        double y = -oldX * Math.sin(theta) + oldY * Math.cos(theta);

        if (x <= 100 && x >= -50 && y <= 50 && y >= -50) {
            return true;
        } else {
            return false;
        }
    }

    private List<SectionList> createSectionList(RoadNetwork roadNetwork) {
        List<SectionList> sectionLists = new ArrayList<>();

        List<RoadSegment> roadRange = new ArrayList<>();
        if (selfVehicles.getRoadSegment().sourceRoadSegment(selfVehicles.lane()) != null)
            roadRange.add(selfVehicles.getRoadSegment().sourceRoadSegment(selfVehicles.lane()));
        roadRange.add(selfVehicles.getRoadSegment());
        if (selfVehicles.getRoadSegment().sinkRoadSegment(selfVehicles.lane()) != null)
            roadRange.add(selfVehicles.getRoadSegment().sinkRoadSegment(selfVehicles.lane()));

        System.out.println("Creating Section Lists...");

        for (RoadSegment roadSegment : roadRange) {
            SectionList sectionList = new SectionList();
            sectionList.setSection_type((short) 1);
            sectionList.setLane_marker_list(new ArrayList<LaneMarker>());
            int maxRightLane = -roadSegment.roadMapping().getLaneGeometries().getRight().getLaneCount();
            int maxLeftLane = roadSegment.roadMapping().getLaneGeometries().getLeft().getLaneCount();
            for (int lane = maxRightLane + 1; lane <= maxLeftLane; ++lane) {
                LaneMarker laneMarkerLeft = new LaneMarker();
                LaneMarker laneMarkerRight = new LaneMarker();
                laneMarkerLeft.setPaint_type((short) 0);
                laneMarkerRight.setPaint_type((short) 0);
                if (lane == 0) {
                    laneMarkerLeft.setPaint_type((short) 1);
                }
                if (lane == 1) {
                    laneMarkerRight.setPaint_type((short) 1);
                }
                if (lane == maxRightLane + 1) {
                    laneMarkerRight.setPaint_type((short) 1);
                }
                if (lane == maxLeftLane) {
                    laneMarkerLeft.setPaint_type((short) 1);
                }
                laneMarkerLeft.setWaypoints(new ArrayList<WayPoint>());
                laneMarkerRight.setWaypoints(new ArrayList<WayPoint>());

                final double offsetLeft = lane * roadSegment.roadMapping().getLaneGeometries().getLaneWidth();
                final double offsetRight = (lane - 1) * roadSegment.roadMapping().getLaneGeometries().getLaneWidth();
                for (int i = 0; i <= roadSegment.roadLength(); i ++) {
                    PosTheta posThetaLeft = roadSegment.roadMapping().map(i, offsetLeft);
                    PosTheta posThetaRight = roadSegment.roadMapping().map(i, offsetRight);
                    WayPoint left = new WayPoint();
                    left.setX(posThetaLeft.getScreenX());
                    left.setY(posThetaLeft.getScreenY());
                    WayPoint right = new WayPoint();
                    right.setX(posThetaRight.getScreenX());
                    right.setY(posThetaRight.getScreenY());
                    if (checkInRange(left)) {
                        laneMarkerLeft.getWaypoints().add(left);
                        //System.out.print("(" + left.getX() + " " + left.getY() + ") ");
                    }
                    if (checkInRange(right)) {
                        laneMarkerRight.getWaypoints().add(right);
                    }
                }
                //System.out.println("");
                if (laneMarkerLeft.getWaypoints().size() > 0) {
                    sectionList.getLane_marker_list().add(laneMarkerLeft);
                }
                if (laneMarkerRight.getWaypoints().size() > 0) {
                    sectionList.getLane_marker_list().add(laneMarkerRight);
                }
            }
            if (sectionList.getLane_marker_list().size() > 0) {
                sectionLists.add(sectionList);
            }
        }




//        for (int lane = maxRightLane + 1; lane < maxLeftLane; lane++) {
//            SectionList sectionList = new SectionList();
//            sectionList.setSection_type((short) 1);
//            sectionList.setLane_marker_list(new ArrayList<LaneMarker>());
//
//            LaneMarker laneMarkerLeft = new LaneMarker();
//            LaneMarker laneMarkerRight = new LaneMarker();
//            laneMarkerLeft.setPaint_type((short) 0);
//            laneMarkerRight.setPaint_type((short) 0);
//            if (lane == 0) {
//                laneMarkerLeft.setPaint_type((short) 1);
//            }
//            if (lane == 1) {
//                laneMarkerRight.setPaint_type((short) 1);
//            }
//            laneMarkerLeft.setWaypoints(new ArrayList<WayPoint>());
//            laneMarkerRight.setWaypoints(new ArrayList<WayPoint>());
//
//            for (RoadSegment roadSegment : roadRange) {
//                final double offsetLeft = lane * roadSegment.roadMapping().getLaneGeometries().getLaneWidth();
//                final double offsetRight = (lane - 1) * roadSegment.roadMapping().getLaneGeometries().getLaneWidth();
//                for (int i = 0; i < roadSegment.roadLength(); i ++) {
//                    PosTheta posThetaLeft = roadSegment.roadMapping().map(i, offsetLeft);
//                    PosTheta posThetaRight = roadSegment.roadMapping().map(i, offsetRight);
//                    WayPoint left = new WayPoint();
//                    left.setX(posThetaLeft.getScreenX());
//                    left.setY(posThetaLeft.getScreenY());
//                    WayPoint right = new WayPoint();
//                    right.setX(posThetaRight.getScreenX());
//                    right.setY(posThetaRight.getScreenY());
//                    if (checkInRange(left)) {
//                        laneMarkerLeft.getWaypoints().add(left);
//                    }
//                    if (checkInRange(right)) {
//                        laneMarkerRight.getWaypoints().add(right);
//                    }
//                }
//            }
//            sectionList.getLane_marker_list().add(laneMarkerLeft);
//            sectionList.getLane_marker_list().add(laneMarkerRight);
//            sectionLists.add(sectionList);
//        }
        return sectionLists;
    }

    public Fusionmap createFusionmap(RoadNetwork roadNetwork, double simulationTime) {
        if (selfVehicles == null)
            return null;
        Fusionmap fusionmap = new Fusionmap();
        fusionmap.setTimestamp((long) simulationTime);
        List<DynamicObstacle> dynamicObstacleList = new ArrayList<>();

        List<RoadSegment> roadRange = new ArrayList<>();
        if (selfVehicles.getRoadSegment().sourceRoadSegment(selfVehicles.lane()) != null)
            roadRange.add(selfVehicles.getRoadSegment().sourceRoadSegment(selfVehicles.lane()));
        roadRange.add(selfVehicles.getRoadSegment());
        if (selfVehicles.getRoadSegment().sinkRoadSegment(selfVehicles.lane()) != null)
            roadRange.add(selfVehicles.getRoadSegment().sinkRoadSegment(selfVehicles.lane()));

        for (RoadSegment roadSegment : roadNetwork) {
            LOG.info(roadSegment.userId());
            for (LaneSegment laneSegment : roadSegment.getLaneSegments()) {
                for (Vehicle vehicle : laneSegment) {
                    if (!vehicle.isOurs()) {
                        double oldX = vehicle.getPositionX() - selfVehicles.getPositionX();
                        double oldY = vehicle.getPositionY() - selfVehicles.getPositionY();

                        double theta = selfVehicles.getRotateTheta();
                        double x = oldX * Math.cos(theta) + oldY * Math.sin(theta);
                        double y = -oldX * Math.sin(theta) + oldY * Math.cos(theta);

                        vehicle.setColorObject(Color.GREEN);

                        if (x <= 100 && x >= -50 && y <= 50 && y >= -50) {
                            vehicle.setColorObject(Color.PINK);
                            LOG.debug("Reset color of vehicle of " + vehicle.getId());

                            dynamicObstacleList.add(createDynamicObstacle(vehicle));
                        }
                    }
                }
            }
        }
        fusionmap.setObstacle_map(createGridMap(roadNetwork));
        fusionmap.setDynamic_object_list(dynamicObstacleList);
        fusionmap.setSection_list(createSectionList(roadNetwork));
        fusionmap.setPose(createPose(simulationTime));

        LOG.info("Fusion map created...");
        return fusionmap;
    }

    private Localize createLocalize(double simulationTime) {
        Localize localize = new Localize();
        localize.setTimestamp((long) simulationTime);
        localize.setPose_x(selfVehicles.getPositionX());
        localize.setPose_y(selfVehicles.getPositionY());
        localize.setAcc_x(selfVehicles.getAcc() * Math.cos(selfVehicles.getSelfTheta()));
        localize.setAcc_y(selfVehicles.getAcc() * Math.sin(selfVehicles.getSelfTheta()));
        localize.setVel_x(selfVehicles.getSpeed() * Math.cos(selfVehicles.getSelfTheta()));
        localize.setVel_y(selfVehicles.getSpeed() * Math.sin(selfVehicles.getSelfTheta()));
        localize.setHeading(selfVehicles.getSelfTheta());
        return localize;
    }

    private Dest createDest(double simulationTime) {
        Dest dest = new Dest();
        dest.setTimestamp((long) simulationTime);
        dest.setX(0.0);
        dest.setY(-295.0);

        return dest;
    }

    private TrafficLightDetect createTrafficLightDetect(double simulationTime) {
        TrafficLightDetect trafficLightDetect = new TrafficLightDetect();
        trafficLightDetect.setTimestamp((long) simulationTime);

        return trafficLightDetect;
    }

    public Trajectory getTrajectoryFromPlanning(RoadNetwork roadNetwork, double simulationTime) throws Exception {
        if (selfVehicles == null) {
            return null;
        }

        LOG.info("Start to publish road data...");
        Fusionmap fusionmap = createFusionmap(roadNetwork, simulationTime);
        client.publishFusionMap(fusionmap);
        LOG.info("Fusion map published...");
        client.publishLocalize(createLocalize(simulationTime));
        client.publishTrafficLightDetect(createTrafficLightDetect(simulationTime));
        client.publishDest(createDest(simulationTime));
        LOG.info("All the data have been published...");
        LOG.info("Try to get the trajectory...");
        return client.getTrajectory();
        //return null;
    }

    public void publishData(RoadNetwork roadNetwork, double simulationTime) throws Exception {
        if (selfVehicles == null) {
            return;
        }



    }

    public void updateSelfVehicleByTrajectory(Trajectory trajectory, double simulationTime, double dt) {
        if (trajectory != null) {
            poseList = trajectory.getPoses();
        }

        if (poseList == null) {
            return;
        }

        double currentTime = simulationTime;

        for (Pose pose : poseList) {
            if (pose.getTimestamp() < simulationTime)
                continue;
            if (pose.getTimestamp() - simulationTime > dt)
                break;
            selfVehicles.updatePositionAndSpeed(pose.getTimestamp() - currentTime);
            selfVehicles.setSpeed(pose.getVelocity());
            selfVehicles.setExternalAcceleration(pose.getAcceleration());
            selfVehicles.setSelfTheta(pose.getTheta());
            currentTime = pose.getTimestamp();

            double oldX = pose.getX() - selfVehicles.getPositionX();
            double oldY = pose.getY() - selfVehicles.getPositionY();
            double theta = selfVehicles.getRotateTheta();
            double y = -oldX * Math.sin(theta) + oldY * Math.cos(theta);
            selfVehicles.setTargetLane(selfVehicles.lane() - (int) (y / 10 + 0.5));
        }
    }

    public void addSelfVehiclesAtBeginning(RoadNetwork roadNetwork) {
        if (selfVehicles != null)
            return;
        RoadSegment roadSegment = roadNetwork.findById(1);
        Vehicle vehicle = createVehicle(roadSegment);
        Preconditions.checkNotNull(roadSegment,
                "cannot find roadSegment with id=" + 1 + " for external vehicle");
        roadSegment.addVehicle(vehicle);
        selfVehicles = vehicle;
    }

    /**
     * adds and removes externally controlled vehicles as configured in the simulation input.
     *
     * @param simulationTime
     * @param roadNetwork
     */
    public void addAndRemoveVehicles(double simulationTime, RoadNetwork roadNetwork) {
        addVehiclesToRoadNetwork(simulationTime, roadNetwork);
        removeVehiclesFromRoadNetwork(simulationTime, roadNetwork);
    }

    private void createExternalVehicleData(MovsimExternalVehicleControl input) {
        for (ExternalVehicleType externalVehicleData : input.getExternalVehicle()) {
            Preconditions.checkArgument(!externalVehicleData.getSpeedData().isEmpty(),
                    "external vehicle needs at least one (time, speed) data entry");
            // no check if (time, speed) input data is sorted in time
            String entryTime = externalVehicleData.getSpeedData().get(0).getTime();
            double entryTimestamp = TimeUtilities.convertToSeconds(entryTime, timeFormat);
            addVehicleInput(entryTimestamp, externalVehicleData);
        }
    }

    private void addVehiclesToRoadNetwork(double simulationTime, RoadNetwork roadNetwork) {
        while (!externalVehicleInputsToAdd.isEmpty() && externalVehicleInputsToAdd.firstKey() <= simulationTime) {
            Double firstKey = externalVehicleInputsToAdd.firstKey();
            List<ExternalVehicleType> externalVehicles = externalVehicleInputsToAdd.remove(firstKey);
            addVehiclesToRoadSegments(externalVehicles, roadNetwork);
            LOG.debug("added {} external vehicles to roadNetwork, removed entries for time={}", externalVehicles.size(),
                    firstKey);
        }
    }

    private void removeVehiclesFromRoadNetwork(double simulationTime, RoadNetwork roadNetwork) {
        while (!externalVehiclesToRemove.isEmpty() && simulationTime >= externalVehiclesToRemove.firstKey()) {
            Double firstKey = externalVehiclesToRemove.firstKey();
            List<Vehicle> externalVehicles = externalVehiclesToRemove.remove(firstKey);
            removeVehiclesFromRoadSegments(externalVehicles, roadNetwork);
        }
    }

    private void removeVehiclesFromRoadSegments(List<Vehicle> externalVehicles, RoadNetwork roadNetwork) {
        for (Vehicle vehicle : externalVehicles) {
            int roadSegmentId = vehicle.roadSegmentId();
            RoadSegment roadSegment = roadNetwork.findById(roadSegmentId);
            LaneSegment laneSegment = roadSegment.laneSegment(vehicle.lane());
            laneSegment.removeVehicle(vehicle);
            LOG.info("removed externally controlled vehicle={} from roadSegment={}", vehicle, roadSegment);
        }
    }

    private boolean addVehicleInput(double timestamp, ExternalVehicleType externalVehicleInput) {
        List<ExternalVehicleType> externalVehicles = externalVehicleInputsToAdd.get(timestamp);
        if (externalVehicles == null) {
            externalVehicles = new ArrayList<ExternalVehicleType>();
            externalVehicleInputsToAdd.put(timestamp, externalVehicles);
        }
        return externalVehicles.add(externalVehicleInput);
    }

    private boolean addVehicleToRemoveMap(double timestamp, Vehicle vehicle) {
        List<Vehicle> vehiclesToRemove = externalVehiclesToRemove.get(timestamp);
        if (vehiclesToRemove == null) {
            vehiclesToRemove = new ArrayList<Vehicle>();
            externalVehiclesToRemove.put(timestamp, vehiclesToRemove);
        }
        return vehiclesToRemove.add(vehicle);
    }

    private void addVehiclesToRoadSegments(List<ExternalVehicleType> vehicleInputs, RoadNetwork roadNetwork) {
        for (ExternalVehicleType vehicleInput : vehicleInputs) {
            Vehicle vehicle = createVehicle(vehicleInput);
            String roadId = vehicleInput.getRoadId();
            RoadSegment roadSegment = roadNetwork.findByUserId(roadId);
            Preconditions.checkNotNull(roadSegment,
                    "cannot find roadSegment with id=" + roadId + " for external vehicle");
            roadSegment.addVehicle(vehicle);
            LinearInterpolatedFunction speedProfile = createSpeedProfile(vehicleInput.getSpeedData());
            controlledVehicles.put(vehicle, speedProfile);
            LOG.info("added externally controlled vehicle={} to roadSegment={}", vehicle, roadSegment);

            // and add vehicle to removal container
            int size = vehicleInput.getSpeedData().size();
            String exitTime = vehicleInput.getSpeedData().get(size - 1).getTime();
            double exitTimestamp = TimeUtilities.convertToSeconds(exitTime, timeFormat);
            addVehicleToRemoveMap(exitTimestamp, vehicle);
            LOG.info("external vehicle={} will be removed at timestamp={}", vehicle, exitTimestamp);
        }
    }

    private LinearInterpolatedFunction createSpeedProfile(List<SpeedDataType> speedData) {
        int size = speedData.size();
        double[] times = new double[size];
        double[] speeds = new double[size];
        for (int i = 0; i < size; i++) {
            SpeedDataType dataPoint = speedData.get(i);
            times[i] = TimeUtilities.convertToSeconds(dataPoint.getTime(), timeFormat);
            speeds[i] = dataPoint.getSpeed();
        }

        return new LinearInterpolatedFunction(times, speeds);
    }

    private Vehicle createVehicle(RoadSegment roadSegment) {
        double initialSpeed = 0;
        double position = Math.random() *  300;
        int laneNum = (int) (Math.random() * roadSegment.getLaneSegments().length) + 1;
        Vehicle vehicle = new Vehicle(position, initialSpeed, laneNum, 10, 6);
        vehicle.setType(Vehicle.Type.EXTERNAL_CONTROL);
        AccelerationModelType accType = new AccelerationModelType();
        accType.setModelParameterIDM(ModelParameters.getDefaultModelParameterIDM());
        vehicle.setLongitudinalModel(
                LongitudinalModelFactory.create(
                        10,
                        accType,
                        0));
        vehicle.setIsOurs(true);
        vehicle.setColorObject(Color.BLACK);

        LOG.info("Create self vehicle here!");
        LOG.info("position: " + position + " lane: " + laneNum);
        return vehicle;
    }

    private Vehicle createVehicle(ExternalVehicleType data) {
        double initialSpeed = data.getSpeedData().get(0).getSpeed();
        Vehicle vehicle = new Vehicle(data.getPosition(), initialSpeed, data.getLane(), data.getLength(),
                data.getWidth());
        vehicle.setType(Vehicle.Type.EXTERNAL_CONTROL);
        for (VehicleUserDataType userData : data.getVehicleUserData()) {
            vehicle.getUserData().put(userData.getKey(), userData.getValue());
        }
        return vehicle;
    }

}
