package com.neusoft.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.Feetype;
import com.neusoft.ssm.dto.ResultDTO;
import com.neusoft.ssm.service.FeetypeService;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("fee")
public class FeetypeController {
    @Autowired
    private FeetypeService feetypeService;

    @RequestMapping(value = "/index")
    public String index01(String name, Model model) {
        model.addAttribute("name", name);
        return "department/basic/Department_management/feetype";
    }

    @RequestMapping(value = "/all",method = RequestMethod.GET)
    @ResponseBody
    public ResultDTO<JSONArray> getAll(int page,int limit){
        ResultDTO<JSONArray> resultDTO = new ResultDTO();
        try {
            PageHelper.startPage(page, limit);
            List<Feetype> list = feetypeService.findAll();
            PageInfo<Feetype> pageInfo = new PageInfo<>(list);
            resultDTO.setStatus(0);
            resultDTO.setMessage("");
            resultDTO.setTotal((int)pageInfo.getTotal());
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
    public ResultDTO<Integer> makeInsert(Feetype feetype) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            int issuccess = feetypeService.doInsert(feetype);
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
    public ResultDTO<Integer> makeDelete(Integer[] ids) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            for (Integer id : ids) {
                feetypeService.delete(id);
            }
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(1);
        }catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<Integer> makeUpdate(Feetype record){
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
        int issucess = feetypeService.update(record);
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            //TODO:将更新改为用ID查找，改完的输入框的值作为新值传入
            resultDTO.setData(issucess);
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

}
