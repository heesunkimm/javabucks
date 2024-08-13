package com.project.javabucksStore.dto;

//메뉴오더 담을 클래스
	public class MenuOrder {
	    private String menuCode;
	    private String optionId;
	    private int quantity;
	    private String menuName;
	    
	    // 생성자
	    public MenuOrder(String menuCode, String optionId, int quantity) {
	        this.menuCode = menuCode;
	        this.optionId = optionId;
	        this.quantity = quantity;
	    }
	    
		public String getMenuCode() {
			return menuCode;
		}
		public void setMenuCode(String menuCode) {
			this.menuCode = menuCode;
		}
		public String getOptionId() {
			return optionId;
		}
		public void setOptionId(String optionId) {
			this.optionId = optionId;
		}
		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		public String getMenuName() {
			return menuName;
		}
		public void setMenuName(String menuName) {
			this.menuName = menuName;
		}	
	    
	}