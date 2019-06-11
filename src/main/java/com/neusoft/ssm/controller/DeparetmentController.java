package com.neusoft.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.dto.ResultDTO;
import com.neusoft.ssm.service.DepartmentService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
@RequestMapping("department")
public class DeparetmentController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "/index")
    public String index01(String name,String id, Model model) {
        model.addAttribute("name", name);
        model.addAttribute("id", id);
        return "department/basic/Department_management/nei";
    }

    @RequestMapping(value = "/uploadUI")
    public String index02() { return "department/basic/Department_management/upload"; }

    @RequestMapping(value = "/uploadHandel", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject index03(@RequestParam("file")MultipartFile file,HttpServletRequest servletRequest) throws IOException {
        JSONObject res = new JSONObject();
        JSONObject resUrl = new JSONObject();

            int uploadCount = departmentService.uploadUserXls(file);
            System.out.println("upload lines: " + uploadCount);
        res.put("code", 0);
        res.put("msg", "");
        res.put("data", resUrl);
        //str = "{\"code\": 0,\"msg\": \"上传成功\",\"data\": {\"src\":\""+path+fileName + "\"}}";
        System.out.println("res里面的值：");
        System.out.println(res.toString());
        return res;
    }

    @RequestMapping(value = "/findall",method = RequestMethod.GET)
    @ResponseBody
    public ResultDTO<JSONArray> listall(int page,int limit,String id,String deptid) {
        ResultDTO<JSONArray> resultDTO = new ResultDTO();
        List<Department> list = null;
        try {
            PageHelper.startPage(page, limit);
            if (deptid==null) {
                list = departmentService.findByDeptcgID(id);
            } else {
                list = departmentService.getSearchDept(deptid,id);
            }

            PageInfo<Department> pageInfo = new PageInfo<>(list);
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
    public ResultDTO<Integer> add(Department department) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            int issuccess = departmentService.insertSelective(department);
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

    @RequestMapping(value = "/CgName",method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<Map<String,String>> showID(){

        ResultDTO<Map<String,String>> resultDTO = new ResultDTO<>();
        try {
            Map<String,String> names = departmentService.findDistinctID();
            resultDTO.setTotal(names.size());
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(names);
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

    public ResultDTO<Department> listById(Integer id) {
        ResultDTO<Department> resultDTO = new ResultDTO();
        try {
            Department department = departmentService.findById(id);
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(department);
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
                departmentService.deleteByPrimaryKey(id);
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
    public ResultDTO<Integer> updateByPrimaryKeySelective(Department department) {
        ResultDTO<Integer> resultDTO = new ResultDTO();
        try {
            int issucess = departmentService.updateByPrimaryKeySelective(department);
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
