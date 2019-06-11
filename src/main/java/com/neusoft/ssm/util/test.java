package com.neusoft.ssm.util;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class test {

    public static void main(String args[]) throws ParseException {
        String str = "2019-06-30";
        Date beginDate = new Date();
        Date endDate = DateTool.getStringToDate(str);

//        List<String> list = DateTool.getEveryday(beginDate, endDate);
//        for(String date : list)
//            System.out.println(date + " " + DateTool.dayToWeek(date));
//
//        System.out.println(" ");
//
//        List<Date> dateList = DateTool.getEveryDate(list);
//        for(Date date : dateList)
//            System.out.println(DateTool.getDateToString(date) + " " + DateTool.dayToWeek(DateTool.getDateToString(date)));

//        List<testList> list = circleList(beginDate, endDate);
//        for(testList l : list) {
//            System.out.println(l.getTime());
//            System.out.println(l.getName());
//            System.out.println();
//        }
//        System.out.println(list.size());

        String s = null;
        String a = ttt(s);
        String ss = aaa(s);
        System.out.println(ss);

    }

    public static List<testList> circleList(Date beginDate, Date endDate) throws ParseException {
        List<testList> rule = new ArrayList<testList>();
        List<testList> result = new ArrayList<testList>();
        List<String> d = DateTool.getEveryday(beginDate, endDate);

        testList t1 = new testList();
        t1.setTime("星期一");
        t1.setName("1");
        rule.add(t1);

        testList t2 = new testList();
        t2.setTime("星期二");
        t2.setName("2");
        rule.add(t2);

        testList t3 = new testList();
        t3.setTime("星期三");
        t3.setName("3");
        rule.add(t3);

        testList t4 = new testList();
        t4.setTime("星期四");
        t4.setName("4");
        rule.add(t4);

        testList t5 = new testList();
        t5.setTime("星期五");
        t5.setName("5");
        rule.add(t5);

        testList t6 = new testList();
        t6.setTime("星期六");
        t6.setName("6");
        rule.add(t6);

        testList t7 = new testList();
        t7.setTime("星期日");
        t7.setName("7");
        rule.add(t7);

        testList t8 = new testList();
        t8.setTime("星期二");
        t8.setName("8");
        rule.add(t8);

        int a = 0;
        boolean flag = true;

        while(flag) {
            String week = DateTool.dayToWeek(d.get(a));
            for(int i = 0; i < rule.size(); i++) {
                if(rule.get(i).getTime().equals(week)) {
                    result.add(rule.get(i));
                }
            }
            if(a == d.size() - 1)
                flag = false;
            a++;
        }

        return result;
    }

    public static String ttt(String str) {
        str = "123";
        aaa(str);
        return str;
    }

    public static String aaa(String str) {
        return str;
    }

}
