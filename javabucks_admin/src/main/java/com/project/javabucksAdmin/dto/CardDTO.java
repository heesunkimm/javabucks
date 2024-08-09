package com.project.javabucksAdmin.dto;

public class CardDTO {

	private int cardRegNum;
	private String userId;
	private String cardName;
	private int cardPrice;

	public int getCardRegNum() {
		return cardRegNum;
	}

	public void setCardRegNum(int cardRegNum) {
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
