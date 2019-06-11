package com.neusoft.ssm.service;

import com.neusoft.ssm.bean.RegistrationInfo;

import java.util.Date;
import java.util.List;

public interface RegisterService {

    boolean add(String medical_record_no, String patient_name, String gender, Long age, Date birthday, String registration_category, String medical_category, String identity_card_no, String family_address, Date registration_date, Date see_doctor_date, Long department_id, Long doctor_id, String registration_source, String settle_accounts_category, String is_seen_doctor, String status, double expense);

    List<RegistrationInfo> findAll();

    boolean backRegister(Long id);

    String findById(Long id);

    void alterAUTO();
}
