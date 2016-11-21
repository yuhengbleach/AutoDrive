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
 *       &lt;attribute name="mass" type="{}nonNegativeDouble" default="1500" />
 *       &lt;attribute name="cross_section_surface" type="{}nonNegativeDouble" default="2.2" />
 *       &lt;attribute name="cd_value" type="{}nonNegativeDouble" default="0.32" />
 *       &lt;attribute name="electric_power" type="{}nonNegativeDouble" default="2000" />
 *       &lt;attribute name="const_friction" type="{}nonNegativeDouble" default="0.0145" />
 *       &lt;attribute name="v_friction" type="{}nonNegativeDouble" default="0" />
 *       &lt;attribute name="fuel_density" type="{}nonNegativeDouble" default="760" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "")
@XmlRootElement(name = "VehicleData")
public class VehicleData
    implements Serializable
{

    private final static long serialVersionUID = 1L;
    @XmlAttribute(name = "mass")
    protected Double mass;
    @XmlAttribute(name = "cross_section_surface")
    protected Double crossSectionSurface;
    @XmlAttribute(name = "cd_value")
    protected Double cdValue;
    @XmlAttribute(name = "electric_power")
    protected Double electricPower;
    @XmlAttribute(name = "const_friction")
    protected Double constFriction;
    @XmlAttribute(name = "v_friction")
    protected Double vFriction;
    @XmlAttribute(name = "fuel_density")
    protected Double fuelDensity;

    /**
     * Gets the value of the mass property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getMass() {
        if (mass == null) {
            return  1500.0D;
        } else {
            return mass;
        }
    }

    /**
     * Sets the value of the mass property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setMass(double value) {
        this.mass = value;
    }

    public boolean isSetMass() {
        return (this.mass!= null);
    }

    public void unsetMass() {
        this.mass = null;
    }

    /**
     * Gets the value of the crossSectionSurface property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getCrossSectionSurface() {
        if (crossSectionSurface == null) {
            return  2.2D;
        } else {
            return crossSectionSurface;
        }
    }

    /**
     * Sets the value of the crossSectionSurface property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setCrossSectionSurface(double value) {
        this.crossSectionSurface = value;
    }

    public boolean isSetCrossSectionSurface() {
        return (this.crossSectionSurface!= null);
    }

    public void unsetCrossSectionSurface() {
        this.crossSectionSurface = null;
    }

    /**
     * Gets the value of the cdValue property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getCdValue() {
        if (cdValue == null) {
            return  0.32D;
        } else {
            return cdValue;
        }
    }

    /**
     * Sets the value of the cdValue property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setCdValue(double value) {
        this.cdValue = value;
    }

    public boolean isSetCdValue() {
        return (this.cdValue!= null);
    }

    public void unsetCdValue() {
        this.cdValue = null;
    }

    /**
     * Gets the value of the electricPower property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getElectricPower() {
        if (electricPower == null) {
            return  2000.0D;
        } else {
            return electricPower;
        }
    }

    /**
     * Sets the value of the electricPower property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setElectricPower(double value) {
        this.electricPower = value;
    }

    public boolean isSetElectricPower() {
        return (this.electricPower!= null);
    }

    public void unsetElectricPower() {
        this.electricPower = null;
    }

    /**
     * Gets the value of the constFriction property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getConstFriction() {
        if (constFriction == null) {
            return  0.0145D;
        } else {
            return constFriction;
        }
    }

    /**
     * Sets the value of the constFriction property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setConstFriction(double value) {
        this.constFriction = value;
    }

    public boolean isSetConstFriction() {
        return (this.constFriction!= null);
    }

    public void unsetConstFriction() {
        this.constFriction = null;
    }

    /**
     * Gets the value of the vFriction property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getVFriction() {
        if (vFriction == null) {
            return  0.0D;
        } else {
            return vFriction;
        }
    }

    /**
     * Sets the value of the vFriction property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setVFriction(double value) {
        this.vFriction = value;
    }

    public boolean isSetVFriction() {
        return (this.vFriction!= null);
    }

    public void unsetVFriction() {
        this.vFriction = null;
    }

    /**
     * Gets the value of the fuelDensity property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public double getFuelDensity() {
        if (fuelDensity == null) {
            return  760.0D;
        } else {
            return fuelDensity;
        }
    }

    /**
     * Sets the value of the fuelDensity property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setFuelDensity(double value) {
        this.fuelDensity = value;
    }

    public boolean isSetFuelDensity() {
        return (this.fuelDensity!= null);
    }

    public void unsetFuelDensity() {
        this.fuelDensity = null;
    }

}