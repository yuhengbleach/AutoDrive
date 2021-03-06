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
 *         &lt;element ref="{}Columns"/>
 *         &lt;element ref="{}Conversions"/>
 *       &lt;/sequence>
 *       &lt;attribute name="separator" type="{http://www.w3.org/2001/XMLSchema}string" default="," />
 *       &lt;attribute name="inputfile" use="required" type="{http://www.w3.org/2001/XMLSchema}string" />
 *       &lt;attribute name="outputfile" type="{http://www.w3.org/2001/XMLSchema}string" />
 *       &lt;attribute name="model" use="required" type="{http://www.w3.org/2001/XMLSchema}string" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "columns",
    "conversions"
})
@XmlRootElement(name = "BatchData")
public class BatchData
    implements Serializable
{

    private final static long serialVersionUID = 1L;
    @XmlElement(name = "Columns", required = true)
    protected Columns columns;
    @XmlElement(name = "Conversions", required = true)
    protected Conversions conversions;
    @XmlAttribute(name = "separator")
    protected String separator;
    @XmlAttribute(name = "inputfile", required = true)
    protected String inputfile;
    @XmlAttribute(name = "outputfile")
    protected String outputfile;
    @XmlAttribute(name = "model", required = true)
    protected String model;

    /**
     * Gets the value of the columns property.
     * 
     * @return
     *     possible object is
     *     {@link Columns }
     *     
     */
    public Columns getColumns() {
        return columns;
    }

    /**
     * Sets the value of the columns property.
     * 
     * @param value
     *     allowed object is
     *     {@link Columns }
     *     
     */
    public void setColumns(Columns value) {
        this.columns = value;
    }

    public boolean isSetColumns() {
        return (this.columns!= null);
    }

    /**
     * Gets the value of the conversions property.
     * 
     * @return
     *     possible object is
     *     {@link Conversions }
     *     
     */
    public Conversions getConversions() {
        return conversions;
    }

    /**
     * Sets the value of the conversions property.
     * 
     * @param value
     *     allowed object is
     *     {@link Conversions }
     *     
     */
    public void setConversions(Conversions value) {
        this.conversions = value;
    }

    public boolean isSetConversions() {
        return (this.conversions!= null);
    }

    /**
     * Gets the value of the separator property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSeparator() {
        if (separator == null) {
            return ",";
        } else {
            return separator;
        }
    }

    /**
     * Sets the value of the separator property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSeparator(String value) {
        this.separator = value;
    }

    public boolean isSetSeparator() {
        return (this.separator!= null);
    }

    /**
     * Gets the value of the inputfile property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInputfile() {
        return inputfile;
    }

    /**
     * Sets the value of the inputfile property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInputfile(String value) {
        this.inputfile = value;
    }

    public boolean isSetInputfile() {
        return (this.inputfile!= null);
    }

    /**
     * Gets the value of the outputfile property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOutputfile() {
        return outputfile;
    }

    /**
     * Sets the value of the outputfile property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOutputfile(String value) {
        this.outputfile = value;
    }

    public boolean isSetOutputfile() {
        return (this.outputfile!= null);
    }

    /**
     * Gets the value of the model property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getModel() {
        return model;
    }

    /**
     * Sets the value of the model property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setModel(String value) {
        this.model = value;
    }

    public boolean isSetModel() {
        return (this.model!= null);
    }

}
