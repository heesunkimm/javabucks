package com.project.javabucks.dto;

import java.util.List;

public class OrderDTO {   
   private String orderCode; // 주문코드
   private String userId; // 주문자
   private String bucksId; // 지점
   private String orderList; // 주문내역 (JSON)
   private int menuPrice; // 메뉴 가격
   private int optPrice; // 옵션 총가격
   private int orderPrice; // 주문 총가격
   private String orderDate; // 주문일시
   private String orderType; // 주문유형
   private String orderStatus; // 주문상태
   
   
   public String getOrderCode() {
      return orderCode;
   }
   public void setOrderCode(String orderCode) {
      this.orderCode = orderCode;
   }
   public String getUserId() {
      return userId;
   }
   public void setUserId(String userId) {
      this.userId = userId;
   }
   public String getBucksId() {
      return bucksId;
   }
   public void setBucksId(String bucksId) {
      this.bucksId = bucksId;
   }
   public String getOrderList() {
      return orderList;
   }
   public void setOrderList(String orderList) {
      this.orderList = orderList;
   }
   public int getMenuPrice() {
      return menuPrice;
   }
   public void setMenuPrice(int menuPrice) {
      this.menuPrice = menuPrice;
   }
   public int getOptPrice() {
      return optPrice;
   }
   public void setOptPrice(int optPrice) {
      this.optPrice = optPrice;
   }
   public int getOrderPrice() {
      return orderPrice;
   }
   public void setOrderPrice(int orderPrice) {
      this.orderPrice = orderPrice;
   }
   public String getOrderDate() {
      return orderDate;
   }
   public void setOrderDate(String orderDate) {
      this.orderDate = orderDate;
   }
   public String getOrderType() {
      return orderType;
   }
   public void setOrderType(String orderType) {
      this.orderType = orderType;
   }
   public String getOrderStatus() {
      return orderStatus;
   }
   public void setOrderStatus(String orderStatus) {
      this.orderStatus = orderStatus;
   }
   
   // 메뉴 화면출력용 변수
   private List<MenuOrder> orderListbyMenuOrder;

   public List<MenuOrder> getOrderListbyMenuOrder() {
		return orderListbyMenuOrder;
   }
   
   public void setOrderListbyMenuOrder(List<MenuOrder> orderListbyMenuOrder) {
		this.orderListbyMenuOrder = orderListbyMenuOrder;
   }
   
    // 조인용 변수
    private String bucksName;

	public String getBucksName() {
		return bucksName;
	}
	public void setBucksName(String bucksName) {
		this.bucksName = bucksName;
	}
   
   
}
