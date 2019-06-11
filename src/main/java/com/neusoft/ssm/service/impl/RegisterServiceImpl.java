package com.neusoft.ssm.service.impl;

import com.neusoft.ssm.bean.RegistrationInfo;
import com.neusoft.ssm.dao.RegisterMapper;
import com.neusoft.ssm.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class RegisterServiceImpl implements RegisterService {

    @Autowired
    RegisterMapper registerMapper;

    @Override
    public boolean add(String medical_record_no, String patient_name, String gender, Long age, Date birthday, String registration_category, String medical_category, String identity_card_no, String family_address, Date registration_date, Date see_doctor_date, Long department_id, Long doctor_id, String registration_source, String settle_accounts_category, String is_seen_doctor, String status, double expense) {
        return registerMapper.add(medical_record_no, patient_name, gender, age, birthday, registration_category, medical_category, identity_card_no, family_address, registration_date, see_doctor_date, department_id, doctor_id, registration_source, settle_accounts_category, is_seen_doctor, status, expense);
    }

    @Override
    public List<RegistrationInfo> findAll() {
        return registerMapper.findAll();
    }

    @Override
    public boolean backRegister(Long id) {
        return registerMapper.backRegister(id);
    }

    @Override
    public String findById(Long id) {
        return registerMapper.findById(id);
    }

    @Override
    @Transactional
    public void alterAUTO() {
        registerMapper.alterAUTO();
    }
}
