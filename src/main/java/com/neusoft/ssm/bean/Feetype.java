package com.neusoft.ssm.bean;

import java.io.Serializable;

/**
 * feetype
 * @author 
 */
public class Feetype implements Serializable {
    /**
     * 结算类别的ID
     */
    private Integer id;

    /**
     * 结算类别名称
     */
    private String feetypeName;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFeetypeName() {
        return feetypeName;
    }

    public void setFeetypeName(String feetypeName) {
        this.feetypeName = feetypeName;
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
        Feetype other = (Feetype) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getFeetypeName() == null ? other.getFeetypeName() == null : this.getFeetypeName().equals(other.getFeetypeName()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getFeetypeName() == null) ? 0 : getFeetypeName().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", feetypeName=").append(feetypeName);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}