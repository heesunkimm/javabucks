package com.project.javabucksAdmin.dto;

public class CardDTO {

	private String cardRegNum;
	private String userId;
	private String cardName;
	private int cardPrice;

	

	public String getCardRegNum() {
		return cardRegNum;
	}

	public void setCardRegNum(String cardRegNum) {
		this.cardRegNum = cardRegNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public int getCardPrice() {
		return cardPrice;
	}

	public void setCardPrice(int cardPrice) {
		this.cardPrice = cardPrice;
	}

}
