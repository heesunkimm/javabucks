package com.project.javabucks.dto;

public class BaljooDTO {
	
	private int baljooNum; // 발주번호(시퀀스)
	private String bucksId; // 지점아이디
	private String stockListCode; // 본사 재고 코드
	private int baljooCount; // 발주수량
	private int baljooPrice; // 발주금액
	private String baljooDate; // 발주일시
	
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
	public String getStockListCode() {
		return stockListCode;
	}
	public void setStockListCode(String stockListCode) {
		this.stockListCode = stockListCode;
	}
	public int getBaljooCount() {
		return baljooCount;
	}
	public void setBaljooCount(int baljooCount) {
		this.baljooCount = baljooCount;
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
	
	
}
