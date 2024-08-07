package com.project.javabucks.dto;

public class CouponDTO {
	
	private String cpnCode; // 쿠폰코드
	private String cpnName; // 쿠폰명
	private int cpnPrice; // 쿠폰금액
	private String cpnDesc; // 쿠폰설명
	
	public String getCpnCode() {
		return cpnCode;
	}
	public void setCpnCode(String cpnCode) {
		this.cpnCode = cpnCode;
	}
	public String getCpnName() {
		return cpnName;
	}
	public void setCpnName(String cpnName) {
		this.cpnName = cpnName;
	}
	public int getCpnPrice() {
		return cpnPrice;
	}
	public void setCpnPrice(int cpnPrice) {
		this.cpnPrice = cpnPrice;
	}
	public String getCpnDesc() {
		return cpnDesc;
	}
	public void setCpnDesc(String cpnDesc) {
		this.cpnDesc = cpnDesc;
	}
	
}
