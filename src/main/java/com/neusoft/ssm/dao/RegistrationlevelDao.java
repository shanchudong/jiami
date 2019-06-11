package com.neusoft.ssm.dao;

import com.neusoft.ssm.bean.Registrationlevel;

import java.util.List;

public interface RegistrationlevelDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Registrationlevel record);

    int insertSelective(Registrationlevel record);

    Registrationlevel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Registrationlevel record);

    int updateByPrimaryKey(Registrationlevel record);

    List<Registrationlevel> findAll();
}