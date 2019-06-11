package com.neusoft.ssm.service;


import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.Registrationlevel;

import java.util.List;

public interface RegistrationLevelService {
    ////    public int uploadUserXls(MultipartFile file) throws IOException;
//    Map<String,String> findDistinctID();
//    List<Department> findByDeptcgID(String id);
//    List<Department> findAll();
//    Department findById(Integer id);
//    int deleteByPrimaryKey(Integer id);
//    int insertSelective(Department record);
//    int updateByPrimaryKeySelective(Department record);
//    List<Department> getSearchDept(String keyword,String CgID);
    List<Registrationlevel> findAll();
    int deleteByPrimaryKey(Integer id);
    int insertSelective(Registrationlevel record);
    int updateByPrimaryKeySelective(Registrationlevel record);
}

