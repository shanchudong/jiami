package com.neusoft.ssm.service.impl;

import com.neusoft.ssm.bean.ScheduleResult;
import com.neusoft.ssm.dao.ScheduleResultMapper;
import com.neusoft.ssm.service.ScheduleResultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class ScheduleResultServiceImpl implements ScheduleResultService {

    @Autowired
    ScheduleResultMapper scheduleResultMapper;

    @Override
    public boolean add(Date date_time, Long doctor_id, String register_level, String noon_level, Integer limit_num) {
        return scheduleResultMapper.add(date_time, doctor_id, register_level, noon_level, limit_num);
    }

    @Override
    public List<ScheduleResult> findAll() {
        return scheduleResultMapper.findAll();
    }

    @Override
    public void deleteByDate(Date date) {
        scheduleResultMapper.deleteByDate(date);
    }

    @Override
    @Transactional
    public void alterAUTO() {
        scheduleResultMapper.alterAUTO();
    }
}
