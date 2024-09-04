package com.project.javabucks.dto;

public class MymenuDTO {

	private int mymenuNum;
	private String userId;
	private String menuCode;
	
	public int getMymenuNum() {
		return mymenuNum;
	}

	public void setMymenuNum(int mymenuNum) {
		this.mymenuNum = mymenuNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
	
	// [채성진] join용 변수 설정
	private String bucksId;

	public String getBucksId() {
		return bucksId;
	}

	public void setBucksId(String bucksId) {
		this.bucksId = bucksId;
	}
	
}
