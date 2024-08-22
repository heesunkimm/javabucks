package com.project.javabucksStore.dto;

public class CardListDTO {

	private String cardListRegNum; // 카드등록번호
	private String cardListStatus; // 카드 사용상태
	private String cardListRegDate; // 카드등록일

	public String getCardListRegNum() {
		return cardListRegNum;
	}

	public void setCardListRegNum(String cardListRegNum) {
		this.cardListRegNum = cardListRegNum;
	}

	public String getCardListStatus() {
		return cardListStatus;
	}

	public void setCardListStatus(String cardListStatus) {
		this.cardListStatus = cardListStatus;
	}

	public String getCardListRegDate() {
		return cardListRegDate;
	}

	public void setCardListRegDate(String cardListRegDate) {
		this.cardListRegDate = cardListRegDate;
	}

}
