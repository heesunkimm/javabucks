package com.project.javabucks.dto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CartDTO {

	private int cartNum;
	private String userId;
	private String bucksId;
	private String menuCode;
	private int cartCnt;
	private int optId;
	private String cartRegDate;
	private String cartType;
	private String menuname;
	private String menuimages;
	private int menuprice;
	

	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
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

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public int getcartCnt() {
		return cartCnt;
	}

	public void setcartCnt(int cartCnt) {
		this.cartCnt = cartCnt;
	}

	public int getOptId() {
		return optId;
	}

	public void setOptId(int optId) {
		this.optId = optId;
	}

	public String getCartRegDate() {
		return cartRegDate;
	}

	public void setCartRegDate(String cartRegDate) {
		this.cartRegDate = cartRegDate;
	}

	public String getCartType() {
		return cartType;
	}

	public void setCartType(String cartType) {
		this.cartType = cartType;
	}

	
	// [채성진] join용 변수설정
	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	public String getMenuimages() {
		return menuimages;
	}

	public void setMenuimages(String menuimages) {
		this.menuimages = menuimages;
	}

	public int getMenuprice() {
		return menuprice;
	}

	public void setMenuprice(int menuprice) {
		this.menuprice = menuprice;
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
	private int eachPrice;
	private int totPrice;
	private String cardRegNum;
	private int cardPrice;
	
	
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

	public int getEachPrice() {
		return eachPrice;
	}

	public void setEachPrice(int eachPrice) {
		this.eachPrice = eachPrice;
	}

	public int getTotPrice() {
		return totPrice;
	}

	public void setTotPrice(int totPrice) {
		this.totPrice = totPrice;
	}

	public String getCardRegNum() {
		return cardRegNum;
	}

	public void setCardRegNum(String cardRegNum) {
		this.cardRegNum = cardRegNum;
	}

	public int getCardPrice() {
		return cardPrice;
	}

	public void setCardPrice(int cardPrice) {
		this.cardPrice = cardPrice;
	}

}
