package com.project.javabucksAdmin.dto;

public class BaljooOrder {
	private String stockListCode;
	private int quantity;
	private String stockListName;
	
	public BaljooOrder(String stockListCode, int quantity) {
		this.stockListCode = stockListCode;
		this.quantity = quantity;
	}

	public String getStockListCode() {
		return stockListCode;
	}

	public void setStockListCode(String stockListCode) {
		this.stockListCode = stockListCode;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getStockListName() {
		return stockListName;
	}

	public void setStockListName(String stockListName) {
		this.stockListName = stockListName;
	}
	
	
	
}
