package com.project.javabucksStore.dto;

public class MenuDTO {

	private String menuCode;
	private String menuName;
	private String menuImages;
	private int menuPrice;
	private String menuDesc;
	private String menuEnable;
	private String menuoptCode;
	private String menuregDate;
	private String menuStatus;
	
	
	
	public String getMenuStatus() {
		return menuStatus;
	}
	public void setMenuStatus(String menuStatus) {
		this.menuStatus = menuStatus;
	}
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
	
	//조인값
	 private int orderCount;

	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	 
}
