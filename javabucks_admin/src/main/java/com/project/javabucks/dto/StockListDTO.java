package com.project.javabucks.dto;

public class StockListDTO {

	private String stockListCode;
	private String cateCode;
	private String stockListName;
	private int stockListPrice;
	private int stockListCount;
	
	public String getStockListCode() {
		return stockListCode;
	}
	public void setStockListCode(String stockListCode) {
		this.stockListCode = stockListCode;
	}
	public String getCateCode() {
		return cateCode;
	}
	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}
	public String getStockListName() {
		return stockListName;
	}
	public void setStockListName(String stockListName) {
		this.stockListName = stockListName;
	}
	public int getStockListPrice() {
		return stockListPrice;
	}
	public void setStockListPrice(int stockListPrice) {
		this.stockListPrice = stockListPrice;
	}
	public int getStockListCount() {
		return stockListCount;
	}
	public void setStockListCount(int stockListCount) {
		this.stockListCount = stockListCount;
	}
}
