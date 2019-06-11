package com.neusoft.ssm.dao;

import com.neusoft.ssm.bean.ScheduleResult;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ScheduleResultMapper {

    boolean add(@Param("date_time") Date date_time, @Param("doctor_id") Long doctor_id, @Param("register_level") String register_level, @Param("noon_level") String noon_level, @Param("limit_num") Integer limit_num);

    List<ScheduleResult> findAll();

    void deleteByDate(@Param("date_time") Date date);

    void alterAUTO();

}
