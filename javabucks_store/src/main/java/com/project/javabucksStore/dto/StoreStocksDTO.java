package com.project.javabucksStore.dto;

public class StoreStocksDTO {

	private int stocksNum; // 지점별 재고번호
	private String bucksId; // 지점아이디
	private String stockListCode; // 재고코드
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
	public String getStockListCode() {
		return stockListCode;
	}
	public void setStockListCode(String stockListCode) {
		this.stockListCode = stockListCode;
	}
	public int getStocksCount() {
		return stocksCount;
	}
	public void setStocksCount(int stocksCount) {
		this.stocksCount = stocksCount;
	}
	
	// StockList와 JOIN한 컬럼
	private String stockCateCode;
	private String stockListName;
	private String stockListImage;
	private int stockListPrice;
	private String stockListStatus;

	public String getStockCateCode() {
		return stockCateCode;
	}
	public void setStockCateCode(String stockCateCode) {
		this.stockCateCode = stockCateCode;
	}
	public String getStockListName() {
		return stockListName;
	}
	public void setStockListName(String stockListName) {
		this.stockListName = stockListName;
	}
	public String getStockListImage() {
		return stockListImage;
	}
	public void setStockListImage(String stockListImage) {
		this.stockListImage = stockListImage;
	}
	public int getStockListPrice() {
		return stockListPrice;
	}
	public void setStockListPrice(int stockListPrice) {
		this.stockListPrice = stockListPrice;
	}
	public String getStockListStatus() {
		return stockListStatus;
	}
	public void setStockListStatus(String stockListStatus) {
		this.stockListStatus = stockListStatus;
	}
	
	
	
}
