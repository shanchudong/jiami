package com.neusoft.ssm.dao;

import com.neusoft.ssm.bean.Feetype;

import java.util.List;
public interface FeetypeDao {
    int deleteByPrimaryKey(int id);

    int insert(Feetype record);

    int insertSelective(Feetype record);

    Feetype selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Feetype record);

    int updateByPrimaryKey(Feetype record);

    List<Feetype> selectAll();
}