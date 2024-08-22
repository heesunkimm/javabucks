package com.project.javabucks.dto;

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
	private String bucksName;

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

	public int getCpnListNum() {
		return cpnListNum;
	}

	public void setCpnListNum(int cpnListNum) {
		this.cpnListNum = cpnListNum;
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
	
	// [채성진] join용 변수 설정
	public String getBucksName() {
		return bucksName;
	}

	public void setBucksName(String bucksName) {
		this.bucksName = bucksName;
	}
	
}
