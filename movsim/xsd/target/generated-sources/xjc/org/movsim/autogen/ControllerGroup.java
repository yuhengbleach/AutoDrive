//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.5-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.11.03 at 09:23:48 PM PDT 
//


package org.movsim.autogen;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
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
 *         &lt;element ref="{}Phase" maxOccurs="unbounded"/>
 *       &lt;/sequence>
 *       &lt;attribute name="id" use="required" type="{http://www.w3.org/2001/XMLSchema}string" />
 *       &lt;attribute name="range" type="{}positiveDouble" default="100" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "phase"
})
@XmlRootElement(name = "ControllerGroup")
public class ControllerGroup
    implements Serializable
{

    private final static long serialVersionUID = 1L;
    @XmlElement(name = "Phase", required = true)
    protected List<Phase> phase;
    @XmlAttribute(name = "id", required = true)
    protected String id;
    @XmlAttribute(name = "range")
    protected Double range;

    /**
     * Gets the value of the phase property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the phase property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPhase().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Phase }
     * 
     * 
     */
    public List<Phase> getPhase() {
        if (phase == null) {
            phase = new ArrayList<Phase>();
        }
        return this.phase;
    }

    public boolean isSetPhase() {
        return ((this.phase!= null)&&(!this.phase.isEmpty()));
    }

    public void unsetPhase() {
        this.phase = null;
    }

    /**
     * Gets the value of the id property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getId() {
        return id;
    }

    /**
     * Sets the value of the id property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setId(String value) {
        this.id = value;
    }

    public boolean isSetId() {
        return (this.id!= null);
    }

    /**
     * Gets the value of the range property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getRange() {
        if (range == null) {
            return  100.0D;
        } else {
            return range;
        }
    }

    /**
     * Sets the value of the range property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setRange(double value) {
        this.range = value;
    }

    public boolean isSetRange() {
        return (this.range!= null);
    }

    public void unsetRange() {
        this.range = null;
    }

}
