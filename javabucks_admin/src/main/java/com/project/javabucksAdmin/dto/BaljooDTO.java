package com.project.javabucksAdmin.dto;

import java.util.List;
import java.util.stream.Collectors;

public class BaljooDTO {
	
	private int baljooNum; // 발주번호(시퀀스)
	private String bucksId; // 지점아이디
	private String baljooList; 
	private int baljooPrice; // 발주금액
	private String baljooDate; // 발주일시
	
	
	
	public String getBaljooList() {
		return baljooList;
	}
	public void setBaljooList(String baljooList) {
		this.baljooList = baljooList;
	}
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
	
	//조인값 추가
	private String bucksName;
	private int totalOrderAmount;
	private String baljooMonth;
	private String totaljooList;
	


	public String getBaljooMonth() {
		return baljooMonth;
	}
	public String getTotaljooList() {
		return totaljooList;
	}
	public void setTotaljooList(String totaljooList) {
		this.totaljooList = totaljooList;
	}
	public void setBaljooMonth(String baljooMonth) {
		this.baljooMonth = baljooMonth;
	}
	public int getTotalOrderAmount() {
		return totalOrderAmount;
	}
	public void setTotalOrderAmount(int totalOrderAmount) {
		this.totalOrderAmount = totalOrderAmount;
	}
	public String getBucksName() {
		return bucksName;
	}
	public void setBucksName(String bucksName) {
		this.bucksName = bucksName;
	}
	
	
	
	
	
}
