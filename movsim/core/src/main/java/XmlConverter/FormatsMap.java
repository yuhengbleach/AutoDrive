package XmlConverter;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by Zhou on 2016/10/21.
 */
@XmlRootElement
public class FormatsMap {
    List<Segment> segment;
    List<Connection> connection;
    List<Section> section;
    List<LaneMarker> laneMarker;
    List<Node> nd;

    public List<Segment> getSegment() {
        return segment;
    }

    @XmlElement
    public void setSegment(List<Segment> segment) {
        this.segment = segment;
    }

    public List<Connection> getConnection() {
        return connection;
    }

    @XmlElement
    public void setConnection(List<Connection> connection) {
        this.connection = connection;
    }

    public List<Section> getSection() {
        return section;
    }

    @XmlElement
    public void setSection(List<Section> section) {
        this.section = section;
    }

    public List<LaneMarker> getLaneMarker() {
        return laneMarker;
    }

    @XmlElement(name = "lanemarker")
    public void setLaneMarker(List<LaneMarker> laneMarker) {
        this.laneMarker = laneMarker;
    }

    public List<Node> getNd() {
        return nd;
    }

    @XmlElement
    public void setNd(List<Node> nd) {
        this.nd = nd;
    }
}
