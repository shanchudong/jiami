package com.neusoft.ssm.dao;


import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.DepartmentExample;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface DepartmentMapper {
    long countByExample(DepartmentExample example);

    int deleteByExample(DepartmentExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Department record);
    @MapKey("ConstantName")
    Map<String,Map<String,String>> selectDistinctID();
    //    Map<String,String> selectDistinctID();
    int insertSelective(Department record);

    List<Department> selectByExample(DepartmentExample example);

    List<Department> findAll();

    Department selectByPrimaryKey(Integer id);

    List<Department> selectByDeptcgID(String id);

    int updateByExampleSelective(@Param("record") Department record, @Param("example") DepartmentExample example);

    int updateByExample(@Param("record") Department record, @Param("example") DepartmentExample example);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);

    public int uploadDepartmentInfo(List<Department> departmentList);

    List<Department> searchDept(String keyword,String CgID);

    String getNameById(Integer id);

    String findNameById(@Param("id") Long id);
}