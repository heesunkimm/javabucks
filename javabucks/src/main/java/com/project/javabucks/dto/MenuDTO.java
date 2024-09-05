package com.project.javabucks.dto;

public class MenuDTO {

	private String menuCode;
	private String menuName;
	private String menuImages;
	private int menuPrice;
	private String menuDesc;
	private String menuEnable;
	private String menuoptCode;
	private String menuregDate;
	
	public String getMenuCode() {
		return menuCode;
	}
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuImages() {
		return menuImages;
	}
	public void setMenuImages(String menuImages) {
		this.menuImages = menuImages;
	}
	public int getMenuPrice() {
		return menuPrice;
	}
	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}
	public String getMenuDesc() {
		return menuDesc;
	}
	public void setMenuDesc(String menuDesc) {
		this.menuDesc = menuDesc;
	}
	public String getMenuEnable() {
		return menuEnable;
	}
	public void setMenuEnable(String menuEnable) {
		this.menuEnable = menuEnable;
	}
	public String getMenuoptCode() {
		return menuoptCode;
	}
	public void setMenuoptCode(String menuoptCode) {
		this.menuoptCode = menuoptCode;
	}
	public String getMenuregDate() {
		return menuregDate;
	}
	public void setMenuregDate(String menuregDate) {
		this.menuregDate = menuregDate;
	}
	
	// [채성진] join용 데이터 변수 설정
	
	private String storemenuStatus;
	private String menuStatus;
	private String bucksId;
	private String storeEnable;
	
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
	
	public String getBucksId() {
		return bucksId;
	}

	public void setBucksId(String bucksId) {
		this.bucksId = bucksId;
	}
	
	public String getStoreEnable() {
		return storeEnable;
	}
	
	public void setStoreEnable(String storeEnable) {
		this.storeEnable = storeEnable;
	}
	
	
}

