package com.project.javabucks.dto;

public class StoreMenuDTO {

	private int storemenuCode; // 지점메뉴코드 pk
	private String menuCode; // 본사메뉴코드
	private String bucksId; // 지점아이디
	private String storemenuStatus; // 지점메뉴상태
	private String storeEnable;
	private String menuStatus;

	public String getStoreEnable() {
		return storeEnable;
	}

	public void setStoreEnable(String storeEnable) {
		this.storeEnable = storeEnable;
	}

	public int getStoremenuCode() {
		return storemenuCode;
	}

	public void setStoremenuCode(int storemenuCode) {
		this.storemenuCode = storemenuCode;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getBucksId() {
		return bucksId;
	}

	public void setBucksId(String bucksId) {
		this.bucksId = bucksId;
	}

	public String getStoremenuStatus() {
		return storemenuStatus;
	}

	public void setStoremenuStatus(String storemenuStatus) {
		this.storemenuStatus = storemenuStatus;
	}

	public String getMenuStatus() {
		return menuStatus;
	}

	public void setMenuStatus(String menuStatus) {
		this.menuStatus = menuStatus;
	}	
}
