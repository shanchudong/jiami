package com.neusoft.ssm.bean;


import java.sql.Date;

public class ScheduleRule {

  private long id;
  private Long doctor_id;
  private String week_time;
  private String register_level;
  private String noon_level;
  private Integer limit_num;
  private Date operate_date;
  private String doctor_name;
  private String department_name;
  private java.util.Date date;

  public ScheduleRule(Long doctor_id, String week_time, String register_level, String noon_level, Integer limit_num, Date operate_date) {
    this.doctor_id = doctor_id;
    this.week_time = week_time;
    this.register_level = register_level;
    this.noon_level = noon_level;
    this.limit_num = limit_num;
    this.operate_date = operate_date;
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public Long getDoctor_id() {
    return doctor_id;
  }

  public void setDoctor_id(Long doctor_id) {
    this.doctor_id = doctor_id;
  }


  public String getWeek_time() {
    return week_time;
  }

  public void setWeek_time(String week_time) {
    this.week_time = week_time;
  }


  public String getRegister_level() {
    return register_level;
  }

  public void setRegister_level(String register_level) {
    this.register_level = register_level;
  }


  public String getNoon_level() {
    return noon_level;
  }

  public void setNoon_level(String noon_level) {
    this.noon_level = noon_level;
  }


  public Integer getLimit_num() {
    return limit_num;
  }

  public void setLimit_num(Integer limit_num) {
    this.limit_num = limit_num;
  }


  public Date getOperate_date() {
    return operate_date;
  }

  public void setOperate_date(Date operate_date) {
    this.operate_date = operate_date;
  }

  public String getDoctor_name() {
    return doctor_name;
  }

  public void setDoctor_name(String doctor_name) {
    this.doctor_name = doctor_name;
  }

  public String getDepartment_name() {
    return department_name;
  }

  public void setDepartment_name(String department_name) {
    this.department_name = department_name;
  }

  public java.util.Date getDate() {
    return date;
  }

  public void setDate(java.util.Date date) {
    this.date = date;
  }

}
