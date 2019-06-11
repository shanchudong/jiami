package com.neusoft.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.Doctor;
import com.neusoft.ssm.bean.RegistrationInfo;
import com.neusoft.ssm.dto.ResultDTO;
import com.neusoft.ssm.service.DepartmentService;
import com.neusoft.ssm.service.DoctorService;
import com.neusoft.ssm.service.RegisterService;
import com.neusoft.ssm.util.DBTool;
import com.neusoft.ssm.util.DateTool;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("register")
public class RegisterController {

    @Autowired
    RegisterService registerService;

    @Autowired
    DoctorService doctorService;

    @Autowired
    DepartmentService departmentService;

    int serialNumber = 0;

    //挂号添加
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public int add(String medical_record_no, String patient_name, String gender, Long age, Date birthday, String registration_category, String medical_category, String identity_card_no, String family_address, Date registration_date, Date see_doctor_date, Long department_id, Long doctor_id, String registration_source, String settle_accounts_category, String is_seen_doctor, String status, double expense) {
        int message = 1;
        try{
            registerService.alterAUTO();
            boolean flag = registerService.add(medical_record_no, patient_name, gender, age, birthday, registration_category, medical_category, identity_card_no, family_address, registration_date, see_doctor_date, department_id, doctor_id, registration_source, settle_accounts_category, is_seen_doctor, status, expense);
            if(flag == false)
                message = 0;
        }catch (Exception e){
            e.printStackTrace();
        }
        return message;
    }

    //提取挂号列表
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public ResultDTO<JSONArray> listall(int page, int limit) {
        ResultDTO<JSONArray> resultDTO = new ResultDTO();
        List<RegistrationInfo> list = null;

        try {
            PageHelper.startPage(page, limit);
            list = registerService.findAll();
            for(RegistrationInfo r : list) {
                r.setDepartment_name(departmentService.findNameById(r.getDoctor_id()));
                r.setDoctor_name(doctorService.findNameById(r.getDoctor_id()));
                r.setDate(DateTool.getDateToString(r.getRegistration_date()));
                r.setBirthday_date(DateTool.getDateToString(r.getBirthday()));
                r.setGender(DBTool.dbToGender(r.getGender()));
                r.setSettle_accounts_category(DBTool.dbToSettle(r.getSettle_accounts_category()));
                r.setRegistration_category(DBTool.dbToRegister(r.getRegistration_category()));
                r.setIs_seen_doctor(DBTool.dbToSeen(r.getIs_seen_doctor()));
                r.setStatus(DBTool.dbToStatus(r.getStatus()));
                r.setSee_doctor_date(new Date());
            }

            PageInfo<RegistrationInfo> pageInfo = new PageInfo<>(list);
            resultDTO.setStatus(0);
            resultDTO.setMessage("");
            resultDTO.setTotal((int)pageInfo.getTotal());
            resultDTO.setData(JSONArray.fromObject(list)); //将list转为JSON格式传至前端
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return  resultDTO;
    }

    //退号
    @RequestMapping(value = "/back", method = RequestMethod.POST)
    @ResponseBody
    public int back(Long id) {
        int message = 1;
        try{
            String str = registerService.findById(id);
            if(str.equals("02"))
                message = 2;
            else {
                boolean flag = registerService.backRegister(id);
                if(flag == false)
                    message = 0;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return message;
    }

    //生成病历号
    @RequestMapping(value = "/getmedicalrecordno", method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<String> getNo() {
        ResultDTO<String> result = new ResultDTO();
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
            String strSerialNumber = format.format(new Date());
            strSerialNumber += String.format("%05d", ++serialNumber);
            result.setStatus(0);
            result.setMessage("操作成功！");
            result.setData(strSerialNumber);
        } catch (Exception e) {
            e.printStackTrace();
            result.setStatus(1);
            result.setMessage("操作失败！");
        }
        return result;
    }

    //获取医生列表
    @RequestMapping(value = "/doctorlist", method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<List<Doctor>> getDoctor() {
        ResultDTO<List<Doctor>> resultDTO = new ResultDTO();
        try {
            List<Doctor> list = doctorService.findAll();
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(list);
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

    //获取科室列表
    @RequestMapping(value = "/departmentlist", method = RequestMethod.POST)
    @ResponseBody
    public ResultDTO<List<Department>> getDepartment() {
        ResultDTO<List<Department>> resultDTO = new ResultDTO();
        try {
            List<Department> list = departmentService.findAll();
            resultDTO.setStatus(0);
            resultDTO.setMessage("操作成功！");
            resultDTO.setData(list);
        } catch (Exception e) {
            e.printStackTrace();
            resultDTO.setStatus(1);
            resultDTO.setMessage("操作失败！");
        }
        return resultDTO;
    }

}
