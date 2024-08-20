package com.project.javabucksStore.dto;

public class BaljooDTO {
	
	private int baljooNum; // 발주번호(시퀀스)
	private String bucksId; // 지점아이디
	private String baljooList; // 발주내역
	private int baljooPrice; // 발주금액
	private String baljooDate; // 발주일시
	private String baljooStatus; // 발주상태
	
	public int getBaljooNum() {
		return baljooNum;
	}
	public void setBaljooNum(int baljooNum) {
		this.baljooNum = baljooNum;
	}
	public String getBucksId() {
		return bucksId;
	}
	public void setBucksId(String bucksId) {
		this.bucksId = bucksId;
	}
	public String getBaljooList() {
		return baljooList;
	}
	public void setBaljooList(String baljooList) {
		this.baljooList = baljooList;
	}
	public int getBaljooPrice() {
		return baljooPrice;
	}
	public void setBaljooPrice(int baljooPrice) {
		this.baljooPrice = baljooPrice;
	}
	public String getBaljooDate() {
		return baljooDate;
	}
	public void setBaljooDate(String baljooDate) {
		this.baljooDate = baljooDate;
	}
	public String getBaljooStatus() {
		return baljooStatus;
	}
	public void setBaljooStatus(String baljooStatus) {
		this.baljooStatus = baljooStatus;
	}
	
	
}
