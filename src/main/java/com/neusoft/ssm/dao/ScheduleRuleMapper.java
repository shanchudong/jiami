package com.neusoft.ssm.dao;

import com.neusoft.ssm.bean.ScheduleRule;
import com.neusoft.ssm.bean.schedule;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;

public interface ScheduleRuleMapper {

    boolean add(@Param("doctor_id") Long doctor_id, @Param("week_time") String week_time, @Param("register_level") String register_level, @Param("noon_level") String noon_level, @Param("limit_num") Integer limit_num, @Param("operate_date") Date operate_date);

    boolean update(@Param("id") Long id, @Param("doctor_id") Long doctor_id, @Param("week_time") String week_time, @Param("register_level") String register_level, @Param("noon_level") String noon_level, @Param("limit_num") Integer limit_num, @Param("operate_date") Date operate_date);

    void deleteById(Long id);

    List<ScheduleRule> findAll();

    void alterAUTO();

    List<schedule> findByAll(@Param("keyword") String keyword);

}
