package com.project.javabucks.dto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CartToPay2 {

	private int cartNum;
	private int cartCnt;
	
	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public int getCartCnt() {
		return cartCnt;
	}

	public void setCartCnt(int cartCnt) {
		this.cartCnt = cartCnt;
	}
		
}
