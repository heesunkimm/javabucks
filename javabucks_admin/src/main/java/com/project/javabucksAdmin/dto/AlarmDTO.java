package com.project.javabucksAdmin.dto;

public class AlarmDTO {

	private int alarm_num;
	private String userId;
	private String alarmCate;
	private String alarmCont;
	private String alarmRegDate;

	public int getAlarm_num() {
		return alarm_num;
	}

	public void setAlarm_num(int alarm_num) {
		this.alarm_num = alarm_num;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAlarmCate() {
		return alarmCate;
	}

	public void setAlarmCate(String alarmCate) {
		this.alarmCate = alarmCate;
	}

	public String getAlarmCont() {
		return alarmCont;
	}

	public void setAlarmCont(String alarmCont) {
		this.alarmCont = alarmCont;
	}

	public String getAlarmRegDate() {
		return alarmRegDate;
	}

	public void setAlarmRegDate(String alarmRegDate) {
		this.alarmRegDate = alarmRegDate;
	}

}
