package com.neusoft.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.User;
import com.neusoft.ssm.bean.UserDemo;
import com.neusoft.ssm.dto.ResultDTO;
import com.neusoft.ssm.service.DepartmentService;
import com.neusoft.ssm.service.IUserService;
import com.neusoft.ssm.util.MD5;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("user")
public class UserManage {

    @Autowired
    private IUserService iUserService;

    @Autowired
    private DepartmentService departmentService;


    @RequestMapping(value = "/index")
    public String index01(String id,String name, Model model) {
        model.addAttribute("name", name);
        model.addAttribute("id", id);
        model.addAttribute("departments", departmentService.findAll());
        if (id.equals("02")||id.equals("03"))
            return "user_manage/Outpatient_Department";
        else
            return "user_manage/Register";
    }

    @RequestMapping(value = "/addUI")
    public String index02(Model model,String id,String name) {
        model.addAttribute("departments", departmentService.findAll());
        model.addAttribute("id", id);
        model.addAttribute("name", name);
        return "user_manage/Outpatient_Department/add_Outpatient_Department";
    }

    @RequestMapping(value = "/editUI")
    public String index03(Model model) {
        model.addAttribute("departments", departmentService.findAll());
        return "user_manage/Outpatient_Department/edit_Outpatient_Department";
    }

    @RequestMapping(value = "/addUI1")
    public String index04(Model model,String id,String name) {
        model.addAttribute("departments", departmentService.findAll());
        model.addAttribute("id", id);
        model.addAttribute("name", name);
        return "user_manage/Register/add_Register";
    }

    @RequestMapping(value = "/editUI1")
    public String index05() {
        return "user_manage/Register/edit_Register";
    }

    @RequestMapping(value = "/findall",method = RequestMethod.GET)
    @ResponseBody
    public ResultDTO<JSONArray> listall(int page, int limit, String id, String login_name,String real_name) {
        ResultDTO<JSONArray> resultDTO = new ResultDTO();
        List<User> list = null;
        List<UserDemo> list1 =  new ArrayList<>();
        try {
            PageHelper.startPage(page, limit);
            if (login_name==null&&real_name==null) {
                list = iUserService.findByUserType(id);
            } else {
                list = iUserService.getSearchUser(login_name,real_name,id);
            }
             for(User user : list){
                 UserDemo userDemo = new UserDemo();
                 userDemo.setReal_name(user.getReal_name());
                 userDemo.setLogin_name(user.getLogin_name());
                 userDemo.setPassword(user.getPassword());
                 userDemo.setDeptid(departmentService.getNameById(user.getDeptid()));
                 if(user.getCategory().equals("01"))
                     userDemo.setCategory("挂号收费员");
                 else if(user.getCategory().equals("02")) {
                     userDemo.setCategory("门诊医生");
                     if(user.getLevel().equals("01"))
                         userDemo.setLevel("主任医师");
                     else if(user.getLevel().equals("02"))
                         userDemo.setLevel("副主任医师");
                     else if(user.getLevel().equals("03"))
                         userDemo.setLevel("主治医师");
                     else
                         userDemo.setLevel("住院医师");

                     if(user.getIfwork().equals("01"))
                         userDemo.setIfwork("是");
                     else
                         userDemo.setIfwork("否");
                 }
                 else if(user.getCategory().equals("03")) {
                     userDemo.setCategory("医技医生");
                     if(user.getLevel().equals("01"))
                         userDemo.setLevel("主任医师");
                     else if(user.getLevel().equals("02"))
                         userDemo.setLevel("副主任医师");
                     else if(user.getLevel().equals("03"))
                         userDemo.setLevel("主治医师");
                     else
                         userDemo.setLevel("住院医师");
                         userDemo.setIfwork("否");
                 }
                 else if(user.getCategory().equals("04"))
                     userDemo.setCategory("药房操作员");
                 else if(user.getCategory().equals("05"))
                     userDemo.setCategory("财务管理员");
                 else if(user.getCategory().equals("06"))
                     userDemo.setCategory("医院管理员");
                 else
                     userDemo.setCategory("其他");

                 list1.add(userDemo);

             }


            PageInfo<User> pageInfo = new PageInfo<>(list);
            resultDTO.setStatus(0);
            resultDTO.setMessage("");
            resultDTO.setTotal((int)pageInfo.getTotal());
            // TODO: 2019/5/30 将list转为JSON格式传至前端
            resultDTO.setData(JSONArray.fromObject(list1));
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<Integer> add(User user) {
        user.setPassword(MD5.MD5(user.getPassword()));
        ResultDTO<Integer> resultDTO = new ResultDTO();
            try {
            int issuccess = iUserService.insertSelective(user);
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(issuccess);
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<Integer> deleteById(String[] names) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            for(String name:names){
                iUserService.deleteUserByName(name);
            }
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(1);
            return resultDTO;
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }


}
