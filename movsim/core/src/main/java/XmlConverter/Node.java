package XmlConverter;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by Zhou on 2016/10/21.
 */
@XmlRootElement
public class Node {
    int id;
    String action;
    boolean visible;
    double lat;
    double lon;

    public Node() {

    }

    public Node(int id, String action, boolean visible, double lat, double lon) {
        this.id = id;
        this.action = action;
        this.visible = visible;
        this.lat = lat;
        this.lon = lon;
    }

    public int getId() {
        return id;
    }

    @XmlAttribute
    public void setId(int id) {
        this.id = id;
    }

    public String getAction() {
        return action;
    }

    @XmlAttribute
    public void setAction(String action) {
        this.action = action;
    }

    public boolean getVisible() {
        return visible;
    }

    @XmlAttribute
    public void setVisible(boolean visible) {
        this.visible = visible;
    }

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
