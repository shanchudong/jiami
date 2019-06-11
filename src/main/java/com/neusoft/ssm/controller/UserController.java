package com.neusoft.ssm.controller;

import com.neusoft.ssm.bean.User;
import com.neusoft.ssm.service.IUserService;
import com.neusoft.ssm.util.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("login")
public class UserController {

    @Autowired
    private IUserService userService;

    //跳转登录
    @RequestMapping("/login")
    public String toLogin() {
        return "login/login";
    }

    /*验证登录
     *
     * 使用 @ResponseBody 在ajax异步获取数据时使用。返回0/1
     *
     */
    @RequestMapping(value = "/login_check", method = RequestMethod.POST)
    @ResponseBody
    public int login(String login_name, String password, HttpServletRequest request, HttpSession session) {
        String passwordByMd5 = MD5.MD5(password);
        String lgName = request.getParameter("login_name");
        String lgCate = request.getParameter("category");
        request.getSession().setAttribute("lgName", lgName);
        request.getSession().setAttribute("lgCate", lgCate);
        int count = userService.login(login_name, passwordByMd5);
        int message = 0;
        String category = userService.selectCategory(login_name);

        if (count == 1 && category.equals("01")) {
            message = 1;
        }
        else if(count == 1 && category.equals("02")) {
            message = 2;
        }
        else if(count == 1 && category.equals("03")) {
            message = 3;
        }
        else if(count == 1 && category.equals("04")) {
            message = 4;
        }
        else if(count == 1 && category.equals("05")) {
            message = 5;
        }
        else if(count == 1 && category.equals("06")) {
            message = 6;
        }
        else {
            message = 0;
        }
        int data = message;
        request.getSession().setAttribute("data", data);
        return message;
    }

    //身份验证跳转
    @RequestMapping(value = "/index01")
    public String index01() { return "department/department"; }

    @RequestMapping(value = "/index02")
    public String index02() { return  "login/index02"; }

    @RequestMapping(value = "/index03")
    public String index03() { return  "login/index03"; }

    @RequestMapping(value = "/index04")
    public String index04() { return  "login/index04"; }

    @RequestMapping(value = "/index05")
    public String index05() { return  "login/index05"; }

    @RequestMapping(value = "/index06")
    public String index06() { return  "login/index06"; }

    //实现注册
    @RequestMapping(value = "/implAdd", method = RequestMethod.POST)
    @ResponseBody
    public int add(String login_name, String password, String category, String question, String answer) {
        String passwordByMd5 = MD5.MD5(password);
        String answerByMd5 = MD5.MD5(answer);
        int findUserByLgName = userService.findUserByLgName(login_name);
        int message;
        if (login_name.length() == 0 || password.length() == 0) {
            message = -1;
            //System.out.println("用户信息输入信息有误");
        } else if (findUserByLgName == 0) {
            userService.register(login_name, passwordByMd5, category, question, answerByMd5);
            message = 1;
            //System.out.println("可以注册");
        } else {
            //System.out.println("用户存在");
            message = 0;
        }
        return message;
    }

    //返回主页跳转
    @RequestMapping(value = "/return")
    public String returnIndex() { return "login/login"; }

    //注销
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("lgName");
        session.removeAttribute("data");
        session.invalidate();
        return "login/login";
    }

    //重置密码
    @RequestMapping("/verify")
    @ResponseBody
    public int verify(String login_name, String password, String answer, HttpServletRequest request, HttpSession session) {
        User user = userService.findUserById(login_name);
        String re_answer = user.getAnswer();
        String answer1 = MD5.MD5(answer);
        int message = 0;
        if(re_answer.equals(answer1) == true) {
            String passwordByMd5 = MD5.MD5(password);
            User newUser = new User();
            newUser.setLogin_name(login_name);
            newUser.setPassword(passwordByMd5);
            boolean i = userService.updateUser(newUser);
            if(i == true)
                message = 1;
            else
                message = 0;
        }
        else
            message = 0;
        return message;
    }

    //提取密保问题
    @RequestMapping("/getQue/{login_name}")
    @ResponseBody
    public User getQue(@PathVariable String login_name) {
        User user =  userService.findUserById(login_name);
        return user;
    }
}
