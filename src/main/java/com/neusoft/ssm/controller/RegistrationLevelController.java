package com.neusoft.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.ssm.bean.Registrationlevel;
import com.neusoft.ssm.dto.ResultDTO;
import com.neusoft.ssm.service.RegistrationLevelService;
import net.sf.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("registrationLevel")
public class RegistrationLevelController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    //todo:registrationService
     RegistrationLevelService registrationLevelService;

    @RequestMapping(value = "/index")
    public String index01(String name,String id, Model model) {
        model.addAttribute("name", name);
//        model.addAttribute("id", id);

            return "department/basic/Department_management/lv";

    }


    @RequestMapping(value = "/findall",method = RequestMethod.GET)
    @ResponseBody
    public ResultDTO<JSONArray> listall() {
        ResultDTO<JSONArray> resultDTO = new ResultDTO();
        List<Registrationlevel> list = null;
        try {
//            PageHelper.startPage(page, limit);
                list = registrationLevelService.findAll();
//            PageInfo<Registrationlevel> pageInfo = new PageInfo<>(list);
            resultDTO.setStatus(0);
            resultDTO.setMessage("");
            resultDTO.setTotal(list.size());
            // TODO: 2019/5/30 将list转为JSON格式传至前端
            resultDTO.setData(JSONArray.fromObject(list));
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<Integer> add(Registrationlevel registrationlevel) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            int issuccess = registrationLevelService.insertSelective(registrationlevel);
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
    public ResultDTO<Integer> deleteById(Integer[] ids) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            for(Integer id:ids){
                registrationLevelService.deleteByPrimaryKey(id);
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



    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<Integer> updateByPrimaryKeySelective(Registrationlevel registrationlevel) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            int issucess = registrationLevelService.updateByPrimaryKeySelective(registrationlevel);
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(issucess);
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }



}
