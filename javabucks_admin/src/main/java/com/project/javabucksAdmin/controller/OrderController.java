package com.project.javabucksAdmin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.javabucksAdmin.dto.StockListDTO;
import com.project.javabucksAdmin.mapper.OrderMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {
	
	@Autowired
	private OrderMapper mapper;
	
	@GetMapping("/adminStockList.do")
	public String stockList(HttpServletRequest req) {
		
		List<StockListDTO> list = mapper.adminStockList();
		
		req.setAttribute("adminStockList", list);
		return "/order/admin_stocklist";
	}
}
