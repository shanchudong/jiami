package com.neusoft.ssm.bean;

public class Department {
    private Integer id;

    private String deptcode;

    private String deptname;

    private String deptcategoryid;

    private String depttype;

    public Department(Integer id, String deptcode, String deptname, String deptcategoryid, String depttype) {
        this.id = id;
        this.deptcode = deptcode;
        this.deptname = deptname;
        this.deptcategoryid = deptcategoryid;
        this.depttype = depttype;
    }

    public Department() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeptcode() {
        return deptcode;
    }

    public void setDeptcode(String deptcode) {
        this.deptcode = deptcode == null ? null : deptcode.trim();
    }

    public String getDeptname() {
        return deptname;
    }

    public void setDeptname(String deptname) {
        this.deptname = deptname == null ? null : deptname.trim();
    }

    public String getDeptcategoryid() {
        return deptcategoryid;
    }

    public void setDeptcategoryid(String deptcategoryid) {
        this.deptcategoryid = deptcategoryid == null ? null : deptcategoryid.trim();
    }

    public String getDepttype() {
        return depttype;
    }

    public void setDepttype(String depttype) {
        this.depttype = depttype == null ? null : depttype.trim();
    }
}