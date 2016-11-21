package XmlConverter;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by Zhou on 2016/10/21.
 */
@XmlRootElement
public class Segment {
    private int id;

    public static class Sec {
        private int ref;
        int getRef() {
            return ref;
        }

        @XmlAttribute
        void setRef(int ref) {
            this.ref = ref;
        }
    }

    private List<Sec> sec;

    public int getId() {
        return id;
    }

    @XmlAttribute
    public void setId(int id) {
        this.id = id;
    }

    public List<Sec> getSec() {
        return sec;
    }

    @XmlElement
    public void setSec(List<Sec> sec) {
        this.sec = sec;
    }

}
