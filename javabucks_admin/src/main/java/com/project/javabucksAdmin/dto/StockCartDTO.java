package com.project.javabucksAdmin.dto;

public class StockCartDTO {
	
	private int stockcartNum; // 장바구니 번호(seq)
	private String bucksId; // 지점 아이디
	private String stocklistCode; // 재고코드
	private int stockcartCount; // 장바구니 담은 수량
	private int sotckcartRegDate; // 장바구니 등록일
	
	public int getStockcartNum() {
		return stockcartNum;
	}
	public void setStockcartNum(int stockcartNum) {
		this.stockcartNum = stockcartNum;
	}
	public String getBucksId() {
		return bucksId;
	}
	public void setBucksId(String bucksId) {
		this.bucksId = bucksId;
	}
	public String getStocklistCode() {
		return stocklistCode;
	}
	public void setStocklistCode(String stocklistCode) {
		this.stocklistCode = stocklistCode;
	}
	public int getStockcartCount() {
		return stockcartCount;
	}
	public void setStockcartCount(int stockcartCount) {
		this.stockcartCount = stockcartCount;
	}
	public int getSotckcartRegDate() {
		return sotckcartRegDate;
	}
	public void setSotckcartRegDate(int sotckcartRegDate) {
		this.sotckcartRegDate = sotckcartRegDate;
	}
	
}
