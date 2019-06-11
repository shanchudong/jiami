package com.neusoft.ssm.bean;

import java.io.Serializable;

/**
 * registrationlevel
 * @author 
 */
public class Registrationlevel implements Serializable {
    private Integer id;

    private String numbercode;

    private String numbername;

    private Integer isdefult;

    private String displayorder;

    private Double fee;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNumbercode() {
        return numbercode;
    }

    public void setNumbercode(String numbercode) {
        this.numbercode = numbercode;
    }

    public String getNumbername() {
        return numbername;
    }

    public void setNumbername(String numbername) {
        this.numbername = numbername;
    }

    public Integer getIsdefult() {
        return isdefult;
    }

    public void setIsdefult(Integer isdefult) {
        this.isdefult = isdefult;
    }

    public String getDisplayorder() {
        return displayorder;
    }

    public void setDisplayorder(String displayorder) {
        this.displayorder = displayorder;
    }

    public Double getFee() {
        return fee;
    }

    public void setFee(Double fee) {
        this.fee = fee;
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        Registrationlevel other = (Registrationlevel) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getNumbercode() == null ? other.getNumbercode() == null : this.getNumbercode().equals(other.getNumbercode()))
            && (this.getNumbername() == null ? other.getNumbername() == null : this.getNumbername().equals(other.getNumbername()))
            && (this.getIsdefult() == null ? other.getIsdefult() == null : this.getIsdefult().equals(other.getIsdefult()))
            && (this.getDisplayorder() == null ? other.getDisplayorder() == null : this.getDisplayorder().equals(other.getDisplayorder()))
            && (this.getFee() == null ? other.getFee() == null : this.getFee().equals(other.getFee()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getNumbercode() == null) ? 0 : getNumbercode().hashCode());
        result = prime * result + ((getNumbername() == null) ? 0 : getNumbername().hashCode());
        result = prime * result + ((getIsdefult() == null) ? 0 : getIsdefult().hashCode());
        result = prime * result + ((getDisplayorder() == null) ? 0 : getDisplayorder().hashCode());
        result = prime * result + ((getFee() == null) ? 0 : getFee().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", numbercode=").append(numbercode);
        sb.append(", numbername=").append(numbername);
        sb.append(", isdefult=").append(isdefult);
        sb.append(", displayorder=").append(displayorder);
        sb.append(", fee=").append(fee);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}