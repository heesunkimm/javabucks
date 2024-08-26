package com.project.javabucksAdmin.dto;

public class CouponListDTO {

	private int cpnListNum;
	private String cpnListCode;
	private String userId;
	private String cpnListStatus; // 쿠폰상태
	private String cpnListStartDate;
	private String cpnListEndDate;
	private String cpnListUseDate;
	
	
	public int getCpnListNum() {
		return cpnListNum;
	}
	public void setCpnListNum(int cpnListNum) {
		this.cpnListNum = cpnListNum;
	}
	public String getCpnListCode() {
		return cpnListCode;
	}
	public void setCpnListCode(String cpnListCode) {
		this.cpnListCode = cpnListCode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCpnListStatus() {
		return cpnListStatus;
	}
	public void setCpnListStatus(String cpnListStatus) {
		this.cpnListStatus = cpnListStatus;
	}
	public String getCpnListStartDate() {
		return cpnListStartDate;
	}
	public void setCpnListStartDate(String cpnListStartDate) {
		this.cpnListStartDate = cpnListStartDate;
	}
	public String getCpnListEndDate() {
		return cpnListEndDate;
	}
	public void setCpnListEndDate(String cpnListEndDate) {
		this.cpnListEndDate = cpnListEndDate;
	}
	public String getCpnListUseDate() {
		return cpnListUseDate;
	}
	public void setCpnListUseDate(String cpnListUseDate) {
		this.cpnListUseDate = cpnListUseDate;
	}

	
}
