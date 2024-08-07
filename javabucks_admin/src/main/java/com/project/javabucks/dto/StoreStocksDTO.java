package com.project.javabucks.dto;

public class StoreStocksDTO {

	private int stocksNum; // 지점별 재고번호
	private String bucksId; // 지점아이디
	private String stocklistCode; // 재고코드
	private int stocksCount; // 지점별 재고수량

	public int getStocksNum() {
		return stocksNum;
	}
	public void setStocksNum(int stocksNum) {
		this.stocksNum = stocksNum;
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
	public int getStocksCount() {
		return stocksCount;
	}
	public void setStocksCount(int stocksCount) {
		this.stocksCount = stocksCount;
	}
	
}
