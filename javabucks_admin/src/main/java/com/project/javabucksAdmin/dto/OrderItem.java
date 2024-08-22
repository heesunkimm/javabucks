package com.project.javabucksAdmin.dto;

//월별 매출관리 결제내역item 저장
public class OrderItem {
	
	private String menuCode;
    private String optionId;
    private int quantity;

    public OrderItem(String menuCode, String optionId, int quantity) {
        this.menuCode = menuCode;
        this.optionId = optionId;
        this.quantity = quantity;
    }

    // Getter 메서드들
    public String getMenuCode() {
        return menuCode;
    }

    public String getOptionId() {
        return optionId;
    }

    public int getQuantity() {
        return quantity;
    }
}
