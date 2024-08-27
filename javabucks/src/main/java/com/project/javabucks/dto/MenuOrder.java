package com.project.javabucks.dto;

public class MenuOrder {
    private String menuCode; // BESWHAMC
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
	
	
	// 옵션
	
	private String cupType;
	private int cupPrice;
	private String shotType;
	private int shotCount;
	private int shotPrice;
	private String syrupType;
	private int syrupCount;
	private int syrupPrice;
	private String iceType;
	private int icePrice;
	private String whipType;
	private int whipPrice;
	private String milkType;
	private int milkPrice;
	public String getCupType() {
		return cupType;
	}
	public void setCupType(String cupType) {
		this.cupType = cupType;
	}
	public int getCupPrice() {
		return cupPrice;
	}
	public void setCupPrice(int cupPrice) {
		this.cupPrice = cupPrice;
	}
	public String getShotType() {
		return shotType;
	}
	public void setShotType(String shotType) {
		this.shotType = shotType;
	}
	public int getShotCount() {
		return shotCount;
	}
	public void setShotCount(int shotCount) {
		this.shotCount = shotCount;
	}
	public int getShotPrice() {
		return shotPrice;
	}
	public void setShotPrice(int shotPrice) {
		this.shotPrice = shotPrice;
	}
	public String getSyrupType() {
		return syrupType;
	}
	public void setSyrupType(String syrupType) {
		this.syrupType = syrupType;
	}
	public int getSyrupCount() {
		return syrupCount;
	}
	public void setSyrupCount(int syrupCount) {
		this.syrupCount = syrupCount;
	}
	public int getSyrupPrice() {
		return syrupPrice;
	}
	public void setSyrupPrice(int syrupPrice) {
		this.syrupPrice = syrupPrice;
	}
	public String getIceType() {
		return iceType;
	}
	public void setIceType(String iceType) {
		this.iceType = iceType;
	}
	public int getIcePrice() {
		return icePrice;
	}
	public void setIcePrice(int icePrice) {
		this.icePrice = icePrice;
	}
	public String getWhipType() {
		return whipType;
	}
	public void setWhipType(String whipType) {
		this.whipType = whipType;
	}
	public int getWhipPrice() {
		return whipPrice;
	}
	public void setWhipPrice(int whipPrice) {
		this.whipPrice = whipPrice;
	}
	public String getMilkType() {
		return milkType;
	}
	public void setMilkType(String milkType) {
		this.milkType = milkType;
	}
	public int getMilkPrice() {
		return milkPrice;
	}
	public void setMilkPrice(int milkPrice) {
		this.milkPrice = milkPrice;
	}
 
}
