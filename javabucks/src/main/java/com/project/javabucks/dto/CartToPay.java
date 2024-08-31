package com.project.javabucks.dto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CartToPay {
	
	private String bucksId;
	private int optId;
	private CartDTO cartDTO;
    private BucksDTO bucksDTO;
    private OrderOptDTO orderOptDTO;
    private MenuOptCupDTO cupDTO;
    private MenuOptIceDTO iceDTO;
    private MenuOptShotDTO shotDTO;
    private MenuOptWhipDTO whipDTO;
    private MenuOptSyrupDTO syrupDTO;
    private MenuOptMilkDTO milkDTO;
    private MenuDTO menuDTO;
    private int optPrice;
    private int cartCnt;
      
	public String getBucksId() {
		return bucksId;
	}

	public void setBucksId(String bucksId) {
		this.bucksId = bucksId;
	}
	
	public int getOptId() {
		return optId;
	}

	public void setOptId(int optId) {
		this.optId = optId;
	}

	public CartDTO getCartDTO() {
		return cartDTO;
	}
	
	public void setCartDTO(CartDTO cartDTO) {
		this.cartDTO = cartDTO;
	}
	
	public BucksDTO getBucksDTO() {
		return bucksDTO;
	}
	
	public void setBucksDTO(BucksDTO bucksDTO) {
		this.bucksDTO = bucksDTO;
	}
	
	public OrderOptDTO getOrderOptDTO() {
		return orderOptDTO;
	}
	
	public void setOrderOptDTO(OrderOptDTO orderOptDTO) {
		this.orderOptDTO = orderOptDTO;
	}
	
	public MenuOptCupDTO getCupDTO() {
		return cupDTO;
	}
	
	public void setCupDTO(MenuOptCupDTO cupDTO) {
		this.cupDTO = cupDTO;
	}
	
	public MenuOptIceDTO getIceDTO() {
		return iceDTO;
	}
	
	public void setIceDTO(MenuOptIceDTO iceDTO) {
		this.iceDTO = iceDTO;
	}
	
	public MenuOptShotDTO getShotDTO() {
		return shotDTO;
	}
	
	public void setShotDTO(MenuOptShotDTO shotDTO) {
		this.shotDTO = shotDTO;
	}
	
	public MenuOptWhipDTO getWhipDTO() {
		return whipDTO;
	}
	
	public void setWhipDTO(MenuOptWhipDTO whipDTO) {
		this.whipDTO = whipDTO;
	}
	
	public MenuOptSyrupDTO getSyrupDTO() {
		return syrupDTO;
	}
	
	public void setSyrupDTO(MenuOptSyrupDTO syrupDTO) {
		this.syrupDTO = syrupDTO;
	}
	
	public MenuOptMilkDTO getMilkDTO() {
		return milkDTO;
	}
	
	public void setMilkDTO(MenuOptMilkDTO milkDTO) {
		this.milkDTO = milkDTO;
	}
	
	public MenuDTO getMenuDTO() {
		return menuDTO;
	}
	
	public void setMenuDTO(MenuDTO menuDTO) {
		this.menuDTO = menuDTO;
	}
		
	public int getOptPrice() {
		return optPrice;
	}
	
	public void setOptPrice(int optPrice) {
		this.optPrice = optPrice;
	}

	public int getCartCnt() {
		return cartCnt;
	}

	public void setCartCnt(int cartCnt) {
		this.cartCnt = cartCnt;
	}
		
}
