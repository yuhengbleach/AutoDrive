package XmlConverter;

import java.lang.annotation.Target;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by Zhou on 2016/10/21.
 */
@XmlRootElement
public class Section {
    private int id;
    private int from;
    private int to;

    public Section() {
    }

    public Section(int id, int from, int to) {
        this.id = id;
        this.from = from;
        this.to = to;
        enter = new Enter();
        exit = new ArrayList<>();
        mem = new ArrayList<>();
        trafficLight = new ArrayList<>();
    }

    @XmlRootElement
    public static class Enter {
        private int left;
        private int right;

        public int getLeft() {
            return left;
        }

        @XmlAttribute
        public void setLeft(int left) {
            this.left = left;
        }

        public int getRight() {
            return right;
        }

        @XmlAttribute
        public void setRight(int right) {
            this.right = right;
        }
    }

    private Enter enter;

    @XmlRootElement
    public static class Exit {
        private int role;
        private int left;
        private int right;

        public int getRole() {
            return role;
        }

        @XmlAttribute
        public void setRole(int role) {
            this.role = role;
        }

        public int getLeft() {
            return left;
        }

        @XmlAttribute
        public void setLeft(int left) {
            this.left = left;
        }

        public int getRight() {
            return right;
        }

        @XmlAttribute
        public void setRight(int right){
            this.right = right;
        }
    }

    private List<Exit> exit;

    @XmlRootElement
    public static class Mem {
        private int ref;
        private char role;

        public int getRef() {
            return ref;
        }

        @XmlAttribute
        public void setRef(int ref) {
            this.ref = ref;
        }

        public char getRole() {
            return role;
        }

        @XmlAttribute
        public void setRole(char role) {
            this.role = role;
        }
    }

    private List<Mem> mem;

    @XmlRootElement
    public static class TrafficLight {
        private double lat;
        private double lon;
        private double h;

        public double getLat() {
            return lat;
        }

        @XmlAttribute
        public void setLat(double lat) {
            this.lat = lat;
        }

        public double getLon() {
            return lon;
        }

        @XmlAttribute
        public void setLon(double lon) {
            this.lon = lon;
        }

        public double getH() {
            return h;
        }

        @XmlAttribute
        public void setH(double h) {
            this.h = h;
        }
    }

    private List<TrafficLight> trafficLight;

    public int getId() {
        return id;
    }

    @XmlAttribute
    public void setId(int id) {
        this.id = id;
    }

    public int getFrom() {
        return from;
    }

    @XmlAttribute
    public void setFrom(int from) {
        this.from = from;
    }

    public int getTo() {
        return to;
    }

    @XmlAttribute
    public void setTo(int to) {
        this.to = to;
    }

    public Enter getEnter() {
        return enter;
    }

    @XmlElement
    public void setEnter(Enter enter) {
        this.enter = enter;
    }

    public List<Exit> getExit() {
        return exit;
    }

    @XmlElement
    public void setExit(List<Exit> exit) {
        this.exit = exit;
    }

    public List<Mem> getMem() {
        return mem;
    }

    @XmlElement
    public void setMem(List<Mem> mem) {
        this.mem = mem;
    }

    public List<TrafficLight> getTrafficLight() {
        return trafficLight;
    }

    @XmlElement
    public void setTrafficLight(List<TrafficLight> trafficLight) {
        this.trafficLight = trafficLight;
    }
}
