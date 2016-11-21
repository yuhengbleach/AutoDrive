package XmlConverter;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by Zhou on 2016/10/21.
 */
@XmlRootElement
public class Connection {
    private int id;

    @XmlRootElement
    public static class Center {
        private double lat;
        private double lon;

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
    }

    Center center;

    @XmlRootElement
    public static class ExitPair {
        private int from;
        private int to;
        private int type;

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

        public int getType() {
            return type;
        }

        @XmlAttribute
        public void setType(int type) {
            this.type = type;
        }
    }

    List<ExitPair> exitPair;

    public int getId() {
        return id;
    }

    @XmlAttribute
    public void setId(int id) {
        this.id = id;
    }

    public Center getCenter() {
        return center;
    }

    @XmlElement
    public void setCenter(Center center) {
        this.center = center;
    }

    public List<ExitPair> getExitPair() {
        return exitPair;
    }

    @XmlElement(name = "exit_pair")
    public void setExitPair(List<ExitPair> exitPair) {
        this.exitPair = exitPair;
    }
}
