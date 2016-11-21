//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.5-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.11.03 at 09:23:48 PM PDT 
//


package org.movsim.autogen;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
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
 *       &lt;attribute name="safe_deceleration" type="{}nonNegativeDouble" default="4.0" />
 *       &lt;attribute name="minimum_gap" type="{}nonNegativeDouble" default="2.0" />
 *       &lt;attribute name="threshold_acceleration" type="{http://www.w3.org/2001/XMLSchema}double" default="0.2" />
 *       &lt;attribute name="right_bias_acceleration" type="{http://www.w3.org/2001/XMLSchema}double" default="0.25" />
 *       &lt;attribute name="politeness" type="{http://www.w3.org/2001/XMLSchema}double" default="0.1" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "")
@XmlRootElement(name = "ModelParameterMOBIL")
public class ModelParameterMOBIL
    implements Serializable
{

    private final static long serialVersionUID = 1L;
    @XmlAttribute(name = "safe_deceleration")
    protected Double safeDeceleration;
    @XmlAttribute(name = "minimum_gap")
    protected Double minimumGap;
    @XmlAttribute(name = "threshold_acceleration")
    protected Double thresholdAcceleration;
    @XmlAttribute(name = "right_bias_acceleration")
    protected Double rightBiasAcceleration;
    @XmlAttribute(name = "politeness")
    protected Double politeness;

    /**
     * Gets the value of the safeDeceleration property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getSafeDeceleration() {
        if (safeDeceleration == null) {
            return  4.0D;
        } else {
            return safeDeceleration;
        }
    }

    /**
     * Sets the value of the safeDeceleration property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setSafeDeceleration(double value) {
        this.safeDeceleration = value;
    }

    public boolean isSetSafeDeceleration() {
        return (this.safeDeceleration!= null);
    }

    public void unsetSafeDeceleration() {
        this.safeDeceleration = null;
    }

    /**
     * Gets the value of the minimumGap property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getMinimumGap() {
        if (minimumGap == null) {
            return  2.0D;
        } else {
            return minimumGap;
        }
    }

    /**
     * Sets the value of the minimumGap property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setMinimumGap(double value) {
        this.minimumGap = value;
    }

    public boolean isSetMinimumGap() {
        return (this.minimumGap!= null);
    }

    public void unsetMinimumGap() {
        this.minimumGap = null;
    }

    /**
     * Gets the value of the thresholdAcceleration property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getThresholdAcceleration() {
        if (thresholdAcceleration == null) {
            return  0.2D;
        } else {
            return thresholdAcceleration;
        }
    }

    /**
     * Sets the value of the thresholdAcceleration property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setThresholdAcceleration(double value) {
        this.thresholdAcceleration = value;
    }

    public boolean isSetThresholdAcceleration() {
        return (this.thresholdAcceleration!= null);
    }

    public void unsetThresholdAcceleration() {
        this.thresholdAcceleration = null;
    }

    /**
     * Gets the value of the rightBiasAcceleration property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getRightBiasAcceleration() {
        if (rightBiasAcceleration == null) {
            return  0.25D;
        } else {
            return rightBiasAcceleration;
        }
    }

    /**
     * Sets the value of the rightBiasAcceleration property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setRightBiasAcceleration(double value) {
        this.rightBiasAcceleration = value;
    }

    public boolean isSetRightBiasAcceleration() {
        return (this.rightBiasAcceleration!= null);
    }

    public void unsetRightBiasAcceleration() {
        this.rightBiasAcceleration = null;
    }

    /**
     * Gets the value of the politeness property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getPoliteness() {
        if (politeness == null) {
            return  0.1D;
        } else {
            return politeness;
        }
    }

    /**
     * Sets the value of the politeness property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setPoliteness(double value) {
        this.politeness = value;
    }

    public boolean isSetPoliteness() {
        return (this.politeness!= null);
    }

    public void unsetPoliteness() {
        this.politeness = null;
    }

}