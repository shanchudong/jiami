package com.neusoft.ssm.util;

public class DBTool {

    //数据库转换星期
    public static String dbToWeek(String date) {
        if(date.equals("01"))
            return "星期一";
        else if(date.equals("02"))
            return "星期二";
        else if(date.equals("03"))
            return "星期三";
        else if(date.equals("04"))
            return "星期四";
        else if(date.equals("05"))
            return "星期五";
        else if(date.equals("06"))
            return "星期六";
        else if(date.equals("07"))
            return "星期日";
        else
            return "error";
    }

    //数据库转换号别
    public static String dbToRegister(String register) {
        if(register.equals("01"))
            return "普通";
        else if(register.equals("02"))
            return "专家";
        else if(register.equals("03"))
            return "急诊";
        else
            return "error";
    }

    //数据库转换午别
    public static String dbToNoon(String noon) {
        if(noon.equals("01"))
            return "全天";
        else if(noon.equals("02"))
            return "上午";
        else if(noon.equals("03"))
            return "下午";
        else if(noon.equals("04"))
            return "晚上";
        else
            return "error";
    }

    //数据库转换性别
    public static String dbToGender(String gender) {
        if(gender.equals("1"))
            return "男";
        else if(gender.equals("2"))
            return "女";
        else
            return "error";
    }

    //数据库转换医疗类别
    public static String dbToMedicalCategory(String category) {
        if(category.equals("01"))
            return "自付";
        else if(category.equals("02"))
            return "城镇职工";
        else if(category.equals("03"))
            return "城镇居民";
        else if(category.equals("04"))
            return "新农合";
        else
            return "error";
    }

    //数据库转换挂号来源
    public static String dbToRegisterSource(String source) {
        if(source.equals("01"))
            return "医院挂号";
        else if(source.equals("02"))
            return "预约挂号";
        else
            return "error";
    }

    //数据库转换挂号状态
    public static String dbToStatus(String status) {
        if(status.equals("01"))
            return "正常";
        else if(status.equals("02"))
            return "已退号";
        else if(status.equals("03"))
            return "无效";
        else
            return "error";
    }

    //数据库转换结算类别
    public static String dbToSettle(String settle) {
        if(settle.equals("01"))
            return "自费";
        else if(settle.equals("02"))
            return "医保";
        else
            return "error";
    }

    //数据库转换是否就诊
    public static String dbToSeen(String seen) {
        if(seen.equals("01"))
            return "否";
        else if(seen.equals("02"))
            return "是";
        else
            return "error";
    }

}
