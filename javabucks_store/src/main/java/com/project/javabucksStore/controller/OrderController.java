package com.project.javabucksStore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.project.javabucksStore.mapper.OrderMapper;

@Controller
public class OrderController {
	
	@Autowired
	OrderMapper mapper;
	
	
}
