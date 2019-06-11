package com.neusoft.ssm.service;

import com.neusoft.ssm.bean.ScheduleRule;
import com.neusoft.ssm.bean.schedule;

import java.sql.Date;
import java.util.List;

public interface ScheduleRuleService {

    boolean add(Long doctor_id, String week_time, String register_level, String noon_level, Integer limit_num, Date operate_date);

    boolean update(Long id, Long doctor_id, String week_time, String register_level, String noon_level, Integer limit_num, Date operate_date);

    void deleteById(Long id);

    List<ScheduleRule> findAll();

    List<schedule> findByAll(String keyword);

    void alterAUTO();

}
