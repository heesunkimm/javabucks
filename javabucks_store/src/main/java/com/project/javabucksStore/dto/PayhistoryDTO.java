package com.project.javabucksStore.dto;

import java.sql.Date;

public class PayhistoryDTO {

	private int payhistoryNum;
	private String userId;
	private String cardRegNum;
	private String bucksId;
	private String orderCode;
	private int cpnListNum;
	private String payhistoryDate;
	private int payhistoryPrice;
	private String payhistoryPayType;
	private String payhistoryPayWay;
	
	
	

	public int getCpnListNum() {
		return cpnListNum;
	}

	public void setCpnListNum(int cpnListNum) {
		this.cpnListNum = cpnListNum;
	}

	public int getPayhistoryNum() {
		return payhistoryNum;
	}

	public void setPayhistoryNum(int payhistoryNum) {
		this.payhistoryNum = payhistoryNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCardRegNum() {
		return cardRegNum;
	}

	public void setCardRegNum(String cardRegNum) {
		this.cardRegNum = cardRegNum;
	}

	public String getBucksId() {
		return bucksId;
	}

	public void setBucksId(String bucksId) {
		this.bucksId = bucksId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	
	public String getPayhistoryDate() {
		return payhistoryDate;
	}

	public void setPayhistoryDate(String payhistoryDate) {
		this.payhistoryDate = payhistoryDate;
	}

	public int getPayhistoryPrice() {
		return payhistoryPrice;
	}

	public void setPayhistoryPrice(int payhistoryPrice) {
		this.payhistoryPrice = payhistoryPrice;
	}

	public String getPayhistoryPayType() {
		return payhistoryPayType;
	}

	public void setPayhistoryPayType(String payhistoryPayType) {
		this.payhistoryPayType = payhistoryPayType;
	}

	public String getPayhistoryPayWay() {
		return payhistoryPayWay;
	}

	public void setPayhistoryPayWay(String payhistoryPayWay) {
		this.payhistoryPayWay = payhistoryPayWay;
	}
	
	//조인값
	private String orderList;
	private int totalSales;
	private String month;
	private String menuName;
	private int menuPrice;
	private String extractedOrderCode;
	private int totalItemPrice;
	
	

	

	

	

	public int getTotalItemPrice() {
		return totalItemPrice;
	}

	public void setTotalItemPrice(int totalItemPrice) {
		this.totalItemPrice = totalItemPrice;
	}

	public int getMenuPrice() {
		return menuPrice;
	}

	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}

	public String getExtractedOrderCode() {
		return extractedOrderCode;
	}

	public void setExtractedOrderCode(String extractedOrderCode) {
		this.extractedOrderCode = extractedOrderCode;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public int getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(int totalSales) {
		this.totalSales = totalSales;
	}

	public String getOrderList() {
		return orderList;
	}

	public void setOrderList(String orderList) {
		this.orderList = orderList;
	}

}

