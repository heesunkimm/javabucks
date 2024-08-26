package com.project.javabucksStore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.javabucksStore.mapper.MenuMapper;

@Controller
public class MenuController {
	
	@Autowired
	MenuMapper menuMapper;
	
	@RequestMapping("/store_alldrink")
	public String getAllDrink() {
		return "/menu/store_alldrink";
	}
	
	@RequestMapping("/store_adddrink")
	public String addDrink() {
		return "/menu/store_adddrink";
	}

}
