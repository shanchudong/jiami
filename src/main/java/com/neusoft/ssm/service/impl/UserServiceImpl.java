package com.neusoft.ssm.service.impl;


import com.neusoft.ssm.bean.User;
import com.neusoft.ssm.dao.UserMapper;
import com.neusoft.ssm.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public int login(String login_name, String password) {
        if (userMapper.login(login_name, password) != null) {
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    public boolean register(String login_name, String password, String category, String question, String answer) {
        return userMapper.register(login_name, password, category, question, answer);
    }

    @Override
    public String selectCategory(String login_name) {
        return userMapper.selectCategory(login_name);
    }

//	@Override
//	public List<User> UserList(Page page) { return  userMapper.UserList(page); }


    @Override
    public boolean deleteUserById(int id) {
        return userMapper.deleteUserById(id);
    }

    @Override
    public int deleteUserByName(String name) {
        return userMapper.deleteUserByName(name);
    }

    @Override
    public User findUserById(String login_name) {
        User user = userMapper.findUserById(login_name);
        return user;
    }

    @Override
    public int findUserByLgName(String login_name) {
        return userMapper.findUserByLgName(login_name);
    }

    @Override
    public boolean updateUser(User user) {
        return userMapper.updateUser(user);
    }

    @Override
    public List<User> selectByList() {
        return this.userMapper.selectByList();
    }

    @Override
    public List<User> findByUserType(String id) {
        return userMapper.findByUserType(id);
    }

    @Override
    public int insertSelective(User record) {
        return userMapper.insertSelective(record);
    }

    @Override
    public List<User> getSearchUser(String login_name, String real_name,String id) {
        return userMapper.getSearchUser(login_name,real_name,id);
    }

}

