package com.project.javabucks.dto;

public class CouponListDTO {

	private int cpnListNum;
	private String cpnCode;
	private String userId;
	private String cpnListStatus;
	private String cpnListStartDate;
	private String cpnListEndDate;
	private String cpnListUseDate;

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

	// 채성진 작업-----------------------------------------------
	// Coupon과 JOIN한 컬럼
	private String cpnName; // 쿠폰명
	private String cpnDesc; // 쿠폰설명
	private int cpnPrice; // 쿠폰금액

	public int getCpnPrice() {
		return cpnPrice;
	}

	public void setCpnPrice(int cpnPrice) {
		this.cpnPrice = cpnPrice;
	}

	public String getCpnName() {
		return cpnName;
	}

	public void setCpnName(String cpnName) {
		this.cpnName = cpnName;
	}

	public String getCpnDesc() {
		return cpnDesc;
	}

	public void setCpnDesc(String cpnDesc) {
		this.cpnDesc = cpnDesc;
	}

}
