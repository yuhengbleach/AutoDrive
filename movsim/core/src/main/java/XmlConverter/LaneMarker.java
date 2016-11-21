package XmlConverter;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by Zhou on 2016/10/21.
 */
@XmlRootElement
public class LaneMarker {
    private int id;
    private String action;
    private boolean visible;

    @XmlRootElement
    public static class ndref {
        private int ref;
        int getRef() {
            return ref;
        }

        @XmlAttribute
        void setRef(int ref) {
            this.ref = ref;
        }
    }

    private List<ndref> nd;

    public LaneMarker() {

    }

    public LaneMarker(int id, String action, boolean visible) {
        this.id = id;
        this.action = action;
        this.visible = visible;
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

    public List<ndref> getNd() {
        return nd;
    }

    @XmlElement
    public void setNd(List<ndref> nd) {
        this.nd = nd;
    }

}
