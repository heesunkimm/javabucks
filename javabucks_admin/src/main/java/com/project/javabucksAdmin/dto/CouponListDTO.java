package com.project.javabucksAdmin.dto;

public class CouponListDTO {

	private int cpnListNum;
	private String cpnCode;
	private String userId;
	private String cpnListStatus; // 쿠폰상태: 발급완료, 사용완료, 기간만료
	private String cpnListStartDate; // 발급일
	private String cpnListEndDate; // 만료일
	private String cpnListUseDate; // 사용날짜
	
	public int getCpnListNum() {
		return cpnListNum;
	}
	public void setCpnListNum(int cpnListNum) {
		this.cpnListNum = cpnListNum;
	}
	public String getCpnCode() {
		return cpnCode;
	}
	public void setCpnCode(String cpnCode) {
		this.cpnCode = cpnCode;
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
	
	// 조인된 컬럼 추가
	private String cpnName;

	public String getCpnName() {
		return cpnName;
	}
	public void setCpnName(String cpnName) {
		this.cpnName = cpnName;
	}
}
