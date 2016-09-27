package com.tellhow.common.unti;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

/**
 * 
 * 日期处理工具类
 * 
 * @author jinaghy整理
 * @Date Apr 10, 2011 5:11:14 PM
 * @version
 */
public class DateUtil {
	// 列举每月的天数
	private static final int[] dayArray = new int[] { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	/**
	 * 默认时间格式化参数
	 */
	public static String defaultDateFormat = "yyyy-MM-dd";
	
	/**
	 * 默认时间格式化参数 带时分秒
	 */
	public static String defaultTimeFormat = "yyyy-MM-dd HH:mm:ss";
	
	
	/**
	 * 获取当前周周一的时间
	 */
	private static int weeks = 0;    
	// 获得当前日期与本周一相差的天数  
	private final static int getMondayPlus() {  
	    Calendar cd = Calendar.getInstance();  
	    // 获得今天是一周的第几天，星期日是第一天，星期二是第二天......  
	    int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);  
	    if (dayOfWeek == 1) {  
	        return -6;  
	    } else {  
	        return 2 - dayOfWeek;  
	    }  
	}  
	// 获得本周星期一的日期  
	public final static String getCurrentMonday() {  
	    weeks = 0;  
	    int mondayPlus = DateUtil.getMondayPlus();  
	    GregorianCalendar currentDate = new GregorianCalendar();  
	    currentDate.add(Calendar.DATE, mondayPlus);  
	    Date monday = currentDate.getTime();  
	    DateFormat df = DateFormat.getDateInstance();  
	    String preMonday = df.format(monday);  
	    return preMonday;  
	} 
	
	/**
	 * 日期加一个月。
	 * 
	 * @param pattern
	 *            构造DateFormat的格式化串等.如果参数为空，默认格式化参数是"yyyy-MM-dd"
	 * @return 提交日期的下一个月的今天
	 * @throws ParseException 
	 */
	public final static String addonemonth(String selectstatetime) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(selectstatetime);
		  Calendar calender = Calendar.getInstance();
          calender.setTime(date);
          calender.add(Calendar.MONTH, 1);
          String enddate = sdf.format(calender.getTime());
		return enddate;
	}

	/**
	 * 格式化当前时间并以字符串形式。
	 * 
	 * @param pattern
	 *            构造DateFormat的格式化串等.如果参数为空，默认格式化参数是"yyyy-MM-dd"
	 * @return 当前时间的字符串形式
	 */
	public final static String formatCurrentTime(String pattern) {
		return transferDateToString(new Date(), pattern);
	}

	/**
	 * 采用默认格式，格式化指定的日期，并以字符串形式返回。
	 * 
	 * @param formatDate
	 *            要格式化为字符串类型的日期。
	 * @return 格式化后的字符串类型的日期。采用默认格式化参数"yyyy-MM-dd"
	 */
	public final static String transferDateToString(Date formatDate) {
		return transferDateToString(formatDate, null);
	}

	/**
	 * 按指定格式，格式化指定的日期，并以字符串形式返回。
	 * 
	 * @param formatDate
	 *            要格式化为字符串类型的日期。
	 * @param pattern
	 *            构造DateFormat的格式化串，如果参数为空，默认格式化参数是"yyyy-MM-dd"
	 * @return 格式化后的字符串类型的日期。
	 */
	public final static String transferDateToString(Date formatDate, String pattern) {
		if (formatDate == null) {
			throw new IllegalArgumentException("日期对象参数不能为空");
		}
		pattern = isEmpty(pattern) ? defaultDateFormat : pattern;
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);

		return formatter.format(formatDate);
	}

	/**
	 * 采用默认格式，将日期格式字符串转换成java.util.Date对象。
	 * 
	 * @param strDate
	 *            日期格式字符串
	 * @return 转换后的java.util.Date对象。日期字符串的格式是默认格式"yyyy-MM-dd"。
	 */
	public final static Date transferStringToDate(String strDate) {
		return transferStringToDate(strDate, null);
	}

	/**
	 * 将日期格式字符串转换成java.util.Date对象。
	 * 
	 * @param strDate
	 *            日期格式字符串
	 * @param pattern
	 *            构造DateFormat的格式化串，如果参数为空，默认格式化参数是"yyyy-MM-dd"
	 * @return 转换后的java.util.Date对象。如果指定的日期格式字符串不能被解析,返回 null
	 */
	public final static Date transferStringToDate(String strDate, String pattern) {
		if (strDate == null) {
			throw new IllegalArgumentException("日期格式字符串不能为空");
		}
		pattern = isEmpty(pattern) ? defaultDateFormat : pattern;
		SimpleDateFormat formatter1 = new SimpleDateFormat(pattern);
		try {
			return formatter1.parse(strDate);
		} catch (Exception e) {
			throw new RuntimeException("日期字符串格式错误", e);
		}
	}

	public final static String formatDate(String value) {
		SimpleDateFormat md = new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		try {
			d = md.parse(value);
		} catch (ParseException e) {
			md.applyPattern("yyyy/MM/dd");
			try {
				d = md.parse(value);
			} catch (ParseException e1) {
				e1.printStackTrace();
				throw new RuntimeException("日期字符串格式错误", e1);
			}
		}
		md.applyPattern("yyyy-MM-dd");
		value = md.format(d);
		return value;
	}

	/**
	 * 
	 * 获得当前年
	 * 
	 * @return 获得当前年，比如现在是2011年4月10日，那么返回2011。
	 */
	public static int getCurrentYear() {
		return getTimeField(Calendar.getInstance().getTime(), Calendar.YEAR);
	}

	/**
	 * 
	 * 获得当前月
	 * 
	 * @return 获得当前月，比如现在是2011年4月10日，那么返回4。
	 */
	public static int getCurrentMonth() {
		return getTimeField(Calendar.getInstance().getTime(), Calendar.MONTH);
	}

	/**
	 *返回当前时间是当月的第几天
	 * 
	 * @return
	 */
	public static int getCurrentDay() {
		return getTimeField(Calendar.getInstance().getTime(), Calendar.DAY_OF_MONTH);
	}

	/**
	 * 返回指定时间对象的指定字段值
	 * 
	 * @param date
	 *            时间对象
	 * @param field
	 *            日历字段值：比如Calendar.YEAR、Calendar.MONTH等
	 * @return
	 */
	public static int getTimeField(Date date, int field) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return getTimeField(cal, field);
	}

	/**
	 * 返回指定时间对象的指定字段值
	 * 
	 * @param cal
	 *            日历对象
	 * @param field
	 *            日历字段值：比如Calendar.YEAR、Calendar.MONTH等
	 * @return
	 */
	public static int getTimeField(Calendar cal, int field) {
		int fieldValue = cal.get(field);
		fieldValue = field == Calendar.MONTH ? (fieldValue + 1) : fieldValue;
		return fieldValue;
	}

	/**
	 * 
	 *返回当前年指定月有多少天
	 * 
	 * @param month
	 *            月份，从1开始，即1表示1月，2表示2月
	 * @return 当前年指定月的总天数
	 */
	public static int getLastDayOfMonth(int month) {
		if (month < 1 || month > 12) {
			return -1;
		}
		int retn = 0;
		if (month == 2 && isLeapYear()) {
			retn = 29;
		} else {
			retn = dayArray[month - 1];
		}
		return retn;
	}

	/**
	 *返回指定年的指定月有多少天
	 * 
	 * @param year
	 *            年份
	 * @param month
	 *            月份，从1开始，即1表示1月，2表示2月
	 * @return
	 */
	public static int getLastDayOfMonth(int year, int month) {
		if (month < 1 || month > 12) {
			return -1;
		}
		int retn = 0;
		if (month == 2 && isLeapYear(year)) {
			retn = 29;
		} else {
			retn = dayArray[month - 1];
		}
		return retn;
	}

	/**
	 * 
	 * 根据指定的日期对象，判断此日期表示月份有多少天
	 * 
	 * @param date
	 *            日期对象
	 * @return
	 */
	public static int getLastDayOfMonth(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return getLastDayOfMonth(cal);
	}

	/**
	 * 根据指定的日历对象，判断此日历表示月份有多少天
	 * 
	 * @param cal
	 * @return
	 */
	public static int getLastDayOfMonth(Calendar cal) {
		int year = getTimeField(cal, Calendar.YEAR);
		int month = getTimeField(cal, Calendar.MONTH);

		if (month < 1 || month > 12) {
			return -1;
		}
		int retn = 0;
		if (month == 2 && isLeapYear(year)) {
			retn = 29;
		} else {
			retn = dayArray[month - 1];
		}
		return retn;
	}

	/**
	 * 判断当前年是否是闰年
	 * 
	 * @return 是闰年返回true，否则返回false
	 */
	public static boolean isLeapYear() {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		return isLeapYear(year);
	}

	/**
	 * 
	 *判断指定的年是否是闰年
	 * 
	 * @param year
	 * @return 是闰年返回true，否则返回false
	 */
	public static boolean isLeapYear(int year) {
		if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 从当前年月日往前倒推指定年。比如，现在是2011-05-18，倒推5年，就是2006-05-18。
	 * 如果当前是闰年2月29日，倒推后的年是平年2月，没有29日，则取28日。
	 * 
	 * @param curDate
	 * @param backYearNum
	 * @return
	 */
	public static Date backYears(Date curDate, int backYearNum){
		Calendar cal = Calendar.getInstance();
		cal.setTime(curDate);
		int curYearNum = cal.get(Calendar.YEAR);
		int curDayofmonth = cal.get(Calendar.DAY_OF_MONTH );
		
		//当前年是闰年是2月29日，但到推后的年不是闰年。
		if( isLeapYear(curYearNum) && cal.get(Calendar.MONTH ) == Calendar.FEBRUARY
				&& curDayofmonth == 29 && !isLeapYear(curYearNum - backYearNum)){
			cal.set(Calendar.DAY_OF_MONTH, 28);
		}
		cal.set(Calendar.YEAR,  curYearNum - backYearNum);
		return new Date(cal.getTimeInMillis());
	}

	/**
	 * 从给定日期开始前进/后推指定天。
	 * 
	 * @param curDate 参照时间点。
	 * @param addDaysNum 要前进/后推的天数。 正数表示往后推，负数表示前推
	 * @return
	 */
	public static Date addDays(Date curDate, int addDaysNum){
		long curDateMills = curDate.getTime();
		long addDaysMills = addDaysNum * 24 * 3600 * 1000;
		return new Date(curDateMills + addDaysMills);
	}
	
	/**
	 * 从给定日期开始前进/后推指定天。
	 * 
	 * @param curDate 参照时间点。
	 * @param addDaysNum 要前进/后推的天数。 正数表示往后推，负数表示前推
	 * @return
	 */
	public static String addStringDays(String curDate, int addDaysNum){
		Date curdate=DateUtil.transferStringToDate(curDate);
		Date adddate=DateUtil.addDays(curdate, addDaysNum);
		String addenddate=DateUtil.transferDateToString(adddate);
		return addenddate;
	}
	/*
	 * 判断字符串是否为空
	 * 
	 * @param value
	 * 
	 * @return 如果是空返回true，否则返回false
	 */
	private static boolean isEmpty(String value) {
		return value == null || value.trim().equals("");
	}
	
	/**
	 * 以下的方法为查询一个月中包含的改年中第多少周
	 * @param args
	 */
	public static List<String> getWeeks(int year, int month) {
		List<String> list = new ArrayList<String>();
		int weeknum = 0;//月周数记数器
		int week = 0;//月周数
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR,year);
		calendar.set(Calendar.MONTH,month-1);
		int day = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);//取月天数
		for (int i = 1; i <= day; i++) {
			calendar.set(Calendar.DATE, i);
			if (calendar.get(Calendar.DAY_OF_WEEK)==Calendar.MONDAY) {//判断月有几个星期一
				if(weeknum==0){
					//取月第一个星期一是第几周
					week = calendar.get(Calendar.WEEK_OF_YEAR);
				}
				list.add((week+weeknum)+"");//将取得的周数存入容器
				weeknum++;
			}
		}
		return list;
	}


	public static void main(String[] args) {
		Date date = transferStringToDate("2008-2-29");
		//Calendar cal = Calendar.getInstance();
		//System.out.println(cal.get(Calendar.MONTH));
		/*cal.setTimeInMillis(date.getTime());
		int mon = cal.get(Calendar.MONTH);
		System.out.println("month:"+mon);
		System.out.println("day:"+cal.get(Calendar.DAY_OF_MONTH ));*/
//		Date backDate = backYears(date, 1);
//		System.out.println(getWeeks(2012,1));
//		System.out.println(getWeeks(2012,2));
//		System.out.println(getWeeks(2012,3));
//		System.out.println(getWeeks(2012,4));
//		System.out.println(getWeeks(2012,5));
//		System.out.println(getWeeks(2012,6));
//		System.out.println(getWeeks(2012,7));
//		System.out.println(getWeeks(2012,8));
//		System.out.println(getWeeks(2012,9));
//		System.out.println(getWeeks(2012,10));
//		System.out.println(getWeeks(2012,11));
//		System.out.println(getWeeks(2012,12));
		
		
		List<String> weeks=DateUtil.getWeeks(2012, 9);
		 String sql = "select t.* from OA_BOSSSCHEDULE t where t.state=2 ";
    	 for( String mon:weeks){
    		 sql+="( t.arrangementtime like '%"+ mon+ "%'" +" or ";
    	 }
    	 sql = sql.substring(0, sql.lastIndexOf("or"));
    	 System.out.println(sql+")");
	}
	
	
}
