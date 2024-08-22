package com.project.javabucksAdmin.dto;

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
	
	//조인 추가 
	private String branchName;   // 지점 이름
    private int totalSales;      // 지점별 합산된 결제 금액
    private String payhistoryYearMonth;   // 결제 날짜 (YYYY-MM 형식)
    private String orderList;  
    private String bucksOwner;  
    private String category;  //일별 카테고리 
    
    
    
    
    
    
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getOrderList() {
		return orderList;
	}

	public void setOrderList(String orderList) {
		this.orderList = orderList;
	}

	public String getBucksOwner() {
		return bucksOwner;
	}

	public void setBucksOwner(String bucksOwner) {
		this.bucksOwner = bucksOwner;
	}

	public String getPayhistoryYearMonth() {
		return payhistoryYearMonth;
	}

	public void setPayhistoryYearMonth(String payhistoryYearMonth) {
		this.payhistoryYearMonth = payhistoryYearMonth;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public int getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(int totalSales) {
		this.totalSales = totalSales;
	}
    
	
	@Override
	public String toString() {
	    return "PayhistoryDTO{" +
	            "payhistoryNum=" + payhistoryNum +
	            ", userId='" + userId + '\'' +
	            ", cardRegNum='" + cardRegNum + '\'' +
	            ", bucksId='" + bucksId + '\'' +
	            ", orderCode='" + orderCode + '\'' +
	            ", cpnListNum=" + cpnListNum +
	            ", payhistoryDate='" + payhistoryDate + '\'' +
	            ", payhistoryPrice=" + payhistoryPrice +
	            ", payhistoryPayType='" + payhistoryPayType + '\'' +
	            ", payhistoryPayWay='" + payhistoryPayWay + '\'' +
	            ", branchName='" + branchName + '\'' +
	            ", totalSales=" + totalSales +
	            ", payhistoryYearMonth='" + payhistoryYearMonth + '\'' +
	            ", orderList='" + orderList + '\'' +
	            ", bucksOwner='" + bucksOwner + '\'' +
	            ", category='" + category + '\'' +
	            '}';
	}
    
}
