package com.project.javabucksStore.dto;

public class StockListCateDTO {
	
	private String stockCateCode; // 재고 카테고리 코드
	private String stockCateName; // 재고 카테고리 이름
	
	public String getStockCateCode() {
		return stockCateCode;
	}
	public void setStockCateCode(String stockCateCode) {
		this.stockCateCode = stockCateCode;
	}
	public String getStockCateName() {
		return stockCateName;
	}
	public void setStockCateName(String stockCateName) {
		this.stockCateName = stockCateName;
	}
}
