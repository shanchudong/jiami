package com.neusoft.ssm.service;

import com.neusoft.ssm.bean.ScheduleResult;

import java.util.Date;
import java.util.List;

public interface ScheduleResultService {

    boolean add(Date date_time, Long doctor_id, String register_level, String noon_level, Integer limit_num);

    List<ScheduleResult> findAll();

    void deleteByDate(Date date);

    void alterAUTO();
}
