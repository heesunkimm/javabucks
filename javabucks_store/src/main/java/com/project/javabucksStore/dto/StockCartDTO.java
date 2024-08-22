package com.project.javabucksStore.dto;

public class StockCartDTO {
	
	private int stockCartNum; // 장바구니 번호(seq)
	private String bucksId; // 지점 아이디
	private String stockListCode; // 재고코드
	private int stockCartCount; // 장바구니 담은 수량
	private String stockCartRegDate; // 장바구니 등록일
	private String stockCartStatus; // 장바구니 상태 (주문대기, 주문완료)
		
	public int getStockCartNum() {
		return stockCartNum;
	}
	public void setStockCartNum(int stockCartNum) {
		this.stockCartNum = stockCartNum;
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
	public int getStockCartCount() {
		return stockCartCount;
	}
	public void setStockCartCount(int stockCartCount) {
		this.stockCartCount = stockCartCount;
	}
	public String getStockCartRegDate() {
		return stockCartRegDate;
	}
	public void setStockCartRegDate(String stockCartRegDate) {
		this.stockCartRegDate = stockCartRegDate;
	}	
	public String getStockCartStatus() {
		return stockCartStatus;
	}
	public void setStockCartStatus(String stockCartStatus) {
		this.stockCartStatus = stockCartStatus;
	}


	// join 용
	private String stockCateCode; // 재고 카테고리 코드
	private String stockListName; // 재고명
	private int stockListPrice; // 재고 가격
	private String stockListImage; // 재고 이미지
	private String stockListStatus;
	private int totCount;
	private String lastRegDate;

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
	public int getStockListPrice() {
		return stockListPrice;
	}
	public void setStockListPrice(int stockListPrice) {
		this.stockListPrice = stockListPrice;
	}
	public String getStockListImage() {
		return stockListImage;
	}
	public void setStockListImage(String stockListImage) {
		this.stockListImage = stockListImage;
	}
	public int getTotCount() {
		return totCount;
	}
	public void setTotCount(int totCount) {
		this.totCount = totCount;
	}
	public String getLastRegDate() {
		return lastRegDate;
	}
	public void setLastRegDate(String lastRegDate) {
		this.lastRegDate = lastRegDate;
	}
	public String getStockListStatus() {
		return stockListStatus;
	}
	public void setStockListStatus(String stockListStatus) {
		this.stockListStatus = stockListStatus;
	}
	
	
}
