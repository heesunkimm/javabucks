package com.project.javabucksStore.dto;

public class StoreMenuDTO {

	private int storemenuCode; // 지점메뉴코드 pk
	private String menuCode; // 본사메뉴코드
	private String bucksId; // 지점아이디
	private String storemenuStatus; // 지점메뉴상태 - 메뉴주문가능 Y / 메뉴주문불가 N
	private String storeEnable; // 지점메뉴 추가 여부 - 삭제가능 N / 추가가능 Y

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
	public String getStoreEnable() {
		return storeEnable;
	}
	public void setStoreEnable(String storeEnable) {
		this.storeEnable = storeEnable;
	}


	// 조인된 테이블 컬럼 추가
	private String menuName;
	private String menuImages;
	private int menuPrice;
	private String menuDesc;
	private String menuEnable;
	private String menuoptCode;
	private String menuregDate;

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
}
