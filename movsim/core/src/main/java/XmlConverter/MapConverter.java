package XmlConverter;

import org.movsim.roadmappings.PosTheta;
import org.movsim.simulator.roadnetwork.RoadNetwork;
import org.movsim.simulator.roadnetwork.RoadSegment;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;


/**
 * Created by Zhou on 2016/10/24.
 */
public class MapConverter {
    private FormatsMap formatsMap;

    private void getAllNode(RoadNetwork roadNetwork) {
        List<Node> nd = new ArrayList<>();
        List<LaneMarker> lanes = new ArrayList<>();
        List<Section> sections = new ArrayList<>();
        int ndcnt = 0, lncnt = 0, sctcnt = 0;
        for (RoadSegment roadSegment : roadNetwork) {
            System.out.println(roadSegment.id());
            int maxRightLane = -roadSegment.roadMapping().getLaneGeometries().getRight().getLaneCount();
            int maxLeftLane = roadSegment.roadMapping().getLaneGeometries().getLeft().getLaneCount();

            Section rightSection = new Section(++sctcnt, 0, 1);
            Section leftSection = new Section(++sctcnt, 1, 0);
            for (int lane = maxRightLane; lane <= maxLeftLane; ++lane) {
                final double offset = lane * roadSegment.roadMapping().getLaneGeometries().getLaneWidth();
                LaneMarker nowLane = new LaneMarker(++lncnt, "modify", true);
                nowLane.setNd(new ArrayList<LaneMarker.ndref>());
                for (int i = 0; i <= roadSegment.roadLength() * 5; i ++) {
                    PosTheta posTheta = roadSegment.roadMapping().map(i / 5.0, offset);
                    Node node = new Node(++ndcnt, "modify", true, posTheta.getScreenX(), posTheta.getScreenY());
                    nd.add(node);
                    LaneMarker.ndref ndr = new LaneMarker.ndref();
                    ndr.setRef(ndcnt);
                    nowLane.getNd().add(ndr);
                }
                lanes.add(nowLane);
                if (lane <= 0) {
                    Section.Mem mem = new Section.Mem();
                    mem.setRef(lncnt);
                    rightSection.getMem().add(mem);
                    //TODO: Find another way to get enter.
                    if (rightSection.getEnter().getRight() == 0)
                        rightSection.getEnter().setRight(nowLane.getNd().get(nowLane.getNd().size() - 1).getRef());
                    rightSection.getEnter().setLeft(nowLane.getNd().get(nowLane.getNd().size() - 1).getRef());
                }
                if (lane >= 0) {
                    Section.Mem mem = new Section.Mem();
                    mem.setRef(lncnt);
                    leftSection.getMem().add(mem);
                    //TODO: Find another way to get enter.
                    if (leftSection.getEnter().getRight() == 0)
                        leftSection.getEnter().setRight(nowLane.getNd().get(0).getRef());
                    leftSection.getEnter().setLeft(nowLane.getNd().get(0).getRef());
                }
            }
            if (maxLeftLane > 0) {
                sections.add(leftSection);
            }
            if (maxRightLane < 0) {
                sections.add(rightSection);
            }
            //TODO: Fix the problem about bi-direction road appear twice.
            break;
        }
        formatsMap.setNd(nd);
        formatsMap.setLaneMarker(lanes);
        formatsMap.setSection(sections);
    }

    public void convertMap(RoadNetwork roadNetwork) {
        formatsMap = new FormatsMap();
        getAllNode(roadNetwork);
    }

    public String mapToString(RoadNetwork roadNetwork) throws Exception {
        convertMap(roadNetwork);
        JAXBContext jaxbContext = JAXBContext.newInstance(FormatsMap.class);
        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        StringWriter sw = new StringWriter();
        jaxbMarshaller.marshal(formatsMap, sw);
        String xmlString = sw.toString();
        System.out.println(xmlString);
        return xmlString;
    }
}
