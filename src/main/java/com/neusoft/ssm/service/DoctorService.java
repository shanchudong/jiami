package com.neusoft.ssm.service;

import com.neusoft.ssm.bean.Doctor;

import java.util.List;

public interface DoctorService {

    String findNameById(Long id);

    List<Doctor> findAll();

}
