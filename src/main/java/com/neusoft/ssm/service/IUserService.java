package com.neusoft.ssm.service;

import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.User;


import java.util.List;

public interface IUserService {

    int login(String login_name, String password);

    boolean register(String login_name, String password, String category, String question, String answer);

    String selectCategory(String login_name);

    boolean deleteUserById(int id);

    int deleteUserByName(String name);

    boolean updateUser(User user);

    User findUserById(String login_name);

    int findUserByLgName(String login_name);

    List<User> selectByList();

    List<User> findByUserType(String id);

    int insertSelective(User record);

    List<User> getSearchUser(String login_name, String real_name,String id);
}
