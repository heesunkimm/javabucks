package com.project.javabucks.dto;

public class AlarmDTO {

	private int alarmNum;
	private String userId;
	private String alarmIsRead;
	private String alarmCate;
	private String alarmCont;
	private String alarmRegDate;

	public int getAlarNum() {
		return alarmNum;
	}

	public void setAlarm_num(int alarmNum) {
		this.alarmNum = alarmNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAlarmIsRead() {
		return alarmIsRead;
	}

	public void setAlarmIsRead(String alarmIsRead) {
		this.alarmIsRead = alarmIsRead;
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
