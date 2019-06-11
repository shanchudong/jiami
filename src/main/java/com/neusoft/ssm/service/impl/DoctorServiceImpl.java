package com.neusoft.ssm.service.impl;

import com.neusoft.ssm.bean.Doctor;
import com.neusoft.ssm.dao.DoctorMapper;
import com.neusoft.ssm.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DoctorServiceImpl implements DoctorService {

    @Autowired
    DoctorMapper doctorMapper;

    @Override
    @Transactional
    public String findNameById(Long id) {
        return doctorMapper.findNameById(id);
    }

    @Override
    public List<Doctor> findAll() {
        return doctorMapper.findAll();
    }
}
