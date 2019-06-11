package com.neusoft.ssm.util;

/**
 *  日期处理工具类
 */

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateTool {

    private static transient int gregorianCutoverYear = 1582;

    // 闰年中每月天数
    private static final int[] DAYS_P_MONTH_LY= {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    //非闰年中每月天数
    private static final int[] DAYS_P_MONTH_CY= {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    //代表数组里的年、月、日
    private static final int Y = 0, M = 1, D = 2;

    //将日期对象分割为代表年月日的整型数组
    public static int[] splitDate(Date date) {
        String str = getDateToString(date);
        str = str.replace("-", "");
        int[] a = {0, 0, 0};
        a[Y] = Integer.parseInt(str.substring(0, 4));
        a[M] = Integer.parseInt(str.substring(4, 6));
        a[D] = Integer.parseInt(str.substring(6, 8));
        return a;
    }

    //检查传入的年份是否为闰年
    public static boolean isLeapYear(int year) {
        return year >= gregorianCutoverYear ? ((year%4 == 0) && ((year%100 != 0) || (year%400 == 0))) : (year%4 == 0);
    }

    //日期加1天
    private static int[] addOneDay(int year, int month, int day) {
        if(isLeapYear(year)) {
            day++;
            if(day > DAYS_P_MONTH_LY[month - 1]) {
                month++;
                if(month > 12) {
                    year++;
                    month = 1;
                }
                day = 1;
            }
        }
        else {
            day++;
            if(day > DAYS_P_MONTH_CY[month - 1]) {
                month++;
                if(month > 12) {
                    year++;
                    month = 1;
                }
                day = 1;
            }
        }
        int[] a = {year, month, day};
        return a;
    }

    //将不足两位的日期或月份补足两位
    public static String formatMonthDay(int decimal) {
        DecimalFormat df = new DecimalFormat("00");
        return df.format(decimal);
    }

    //将不足四位的年份补足四位
    public static String formatYear(int decimal) {
        DecimalFormat df = new DecimalFormat("0000");
        return df.format(decimal);
    }

    //计算两个日期之间相隔的天数
    public static long countDay(Date beginDate, Date endDate) {
        long day = 0;
        day=(endDate.getTime() - beginDate.getTime()) / (24*60*60*1000);
        return day;
    }

    //以循环的方式计算日期
    public static List<String> getEveryday(Date beginDate ,Date endDate) {
        long day = countDay(beginDate, endDate);
        int[] a = splitDate(beginDate);
        List<String> list = new ArrayList<String>();
        String str = getDateToString(beginDate);
        list.add(str);

        for(int i = 0; i < day; i++) {
            a = addOneDay(a[Y], a[M], a[D]);
            list.add(formatYear(a[Y]) + "-" + formatMonthDay(a[M]) + "-" + formatMonthDay(a[D]));
        }
        return list;
    }

    //将String日期列表转换为Date列表
    public static List<Date> getEveryDate(List<String> list) throws ParseException {
        List<Date> dateList = new ArrayList<Date>();
        for(int i = 0; i < list.size(); i++) {
            Date date = getStringToDate(list.get(i));
            dateList.add(date);
        }
        return dateList;
    }

    //将日期转换为星期
    public static String dayToWeek(String date) throws ParseException {
        Date d = getStringToDate(date);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(d);

        switch (calendar.get(Calendar.DAY_OF_WEEK)) {
            case Calendar.MONDAY:
                return "星期一";
            case Calendar.TUESDAY:
                return "星期二";
            case Calendar.WEDNESDAY:
                return "星期三";
            case Calendar.THURSDAY:
                return "星期四";
            case Calendar.FRIDAY:
                return "星期五";
            case Calendar.SATURDAY:
                return "星期六";
            case Calendar.SUNDAY:
                return "星期日";
            default:
                return "";
        }
    }

    //String转换为Date
    public static Date getStringToDate(String date) throws ParseException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date d = df.parse(date);
        return d;
    }

    //Date转换为String
    public static String getDateToString(Date date) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String str = df.format(date);
        return str;
    }

    //sql.Date转换为String
    public static String SqlToString(java.sql.Date date) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String str = df.format(date);
        return str;
    }
}
