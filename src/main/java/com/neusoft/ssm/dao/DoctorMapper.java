package com.neusoft.ssm.dao;

import com.neusoft.ssm.bean.Doctor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DoctorMapper {

    String findNameById(@Param("id") Long id);

    List<Doctor> findAll();

}
