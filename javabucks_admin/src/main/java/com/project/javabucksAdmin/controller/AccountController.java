package com.project.javabucksAdmin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.javabucksAdmin.mapper.AccountMapper;

@Controller
public class AccountController {

		@Autowired
		private AccountMapper accountMapper;
	
		
		@GetMapping("adminmanage.do2")
		public String adminList() {
			return "account/admin_adminmanage";
		} 
		
}
