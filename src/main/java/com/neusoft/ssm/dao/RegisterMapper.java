package com.neusoft.ssm.dao;

import com.neusoft.ssm.bean.RegistrationInfo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface RegisterMapper {

    boolean add(@Param("medical_record_no") String medical_record_no, @Param("patient_name") String patient_name, @Param("gender") String gender, @Param("age") Long age, @Param("birthday") Date birthday, @Param("registration_category") String registration_category, @Param("medical_category") String medical_category, @Param("identity_card_no") String identity_card_no, @Param("family_address") String family_address, @Param("registration_date") Date registration_date, @Param("see_doctor_date") Date see_doctor_date, @Param("department_id") Long department_id, @Param("doctor_id") Long doctor_id, @Param("registration_source") String registration_source, @Param("settle_accounts_category") String settle_accounts_category, @Param("is_seen_doctor") String is_seen_doctor, @Param("status") String status, @Param("expense") double expense);

    List<RegistrationInfo> findAll();

    boolean backRegister(@Param("id") Long id);

    String findById(@Param("id") Long id);

    void alterAUTO();

}
