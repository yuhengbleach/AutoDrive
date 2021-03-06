//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.5-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.11.03 at 09:23:49 PM PDT 
//


package org.movsim.scenario.initial.autogen;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="RoadInitialConditions" type="{}RoadInitialConditionsType" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "roadInitialConditions"
})
@XmlRootElement(name = "MovsimInitialConditions")
public class MovsimInitialConditions
    implements Serializable
{

    private final static long serialVersionUID = 1L;
    @XmlElement(name = "RoadInitialConditions")
    protected List<RoadInitialConditionsType> roadInitialConditions;

    /**
     * Gets the value of the roadInitialConditions property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the roadInitialConditions property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRoadInitialConditions().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link RoadInitialConditionsType }
     * 
     * 
     */
    public List<RoadInitialConditionsType> getRoadInitialConditions() {
        if (roadInitialConditions == null) {
            roadInitialConditions = new ArrayList<RoadInitialConditionsType>();
        }
        return this.roadInitialConditions;
    }

    public boolean isSetRoadInitialConditions() {
        return ((this.roadInitialConditions!= null)&&(!this.roadInitialConditions.isEmpty()));
    }

    public void unsetRoadInitialConditions() {
        this.roadInitialConditions = null;
    }

}
