package com.neusoft.ssm.dao;

import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

	//	<!--登录-->
	User login(@Param("login_name") String login_name, @Param("password") String password);

	//<!--注册-->
	boolean register(@Param("login_name") String login_name, @Param("password") String password, @Param("category") String category, @Param("question") String question, @Param("answer") String answer);

	String selectCategory(@Param("login_name") String login_name);

	//	<!--显示数据、分页-->
//	List<User> UserList(Page page);
//	int total();

	//	删除数据
	boolean deleteUserById(int id);

	//编辑数据
	boolean updateUser(User user);

	//查找学生
	User findUserById(String login_name);

	//	验证学生登录名是否存在
	int findUserByLgName(String login_name);

	List<User> selectByList();

	List<User> findByUserType(String id);

	int insertSelective(User record);

    int deleteUserByName(String name);

    List<User> getSearchUser(String login_name, String real_name,String id);
}
