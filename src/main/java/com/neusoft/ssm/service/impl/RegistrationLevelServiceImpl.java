package com.neusoft.ssm.service.impl;

import com.neusoft.ssm.bean.Registrationlevel;
import com.neusoft.ssm.dao.RegistrationlevelDao;
import com.neusoft.ssm.service.RegistrationLevelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class RegistrationLevelServiceImpl implements RegistrationLevelService{
    @Autowired
    RegistrationlevelDao registrationlevelDao;
    @Override
    public List<Registrationlevel> findAll() {
        return registrationlevelDao.findAll();
    }

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return registrationlevelDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insertSelective(Registrationlevel record) {
        return registrationlevelDao.insertSelective(record);
    }

    @Override
    public int updateByPrimaryKeySelective(Registrationlevel record) {
        return registrationlevelDao.updateByPrimaryKeySelective(record);
    }
}
