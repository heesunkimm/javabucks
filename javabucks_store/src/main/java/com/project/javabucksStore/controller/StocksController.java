package com.project.javabucksStore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.javabucksStore.mapper.StocksMapper;

@Controller
public class StocksController {
	
	@Autowired
	StocksMapper mapper;
	
	@RequestMapping("/stocks")
	public String stocks() {
		return "/stocks/store_stocks";
	}
	
	
	
}
