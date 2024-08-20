package com.project.javabucksStore.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.mapper.LoginMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LoginController {
	
	@Autowired
	LoginMapper loginMapper;
	
	// store 
	@RequestMapping(value= {"/","/store_login"})
	public String index() {
		return "login/store_login";
	}
	
	@GetMapping("/store_login")
	public String login() {
		return "login/store_login";
	}
	
	@GetMapping("/store_index")
	public String store_index() {
		return "store_index";
	}
	
	@PostMapping("/store_index")
	public String loginOk(@RequestParam Map<String, String> params,
			HttpServletRequest req, HttpServletResponse resp) {
		
		System.out.println(params);
		String storeId = params.get("storeId");
		String storePw = params.get("storePw");
		String saveId = params.containsKey("saveId") ? "on" : "off";
		
		System.out.println(storeId);
		System.out.println(storePw);
		System.out.println(saveId);
		
		//String userId = params.get("userId");
		//String userPasswd = params.get("userPasswd");
		//String saveId = params.containsKey("saveId") ? "on" : "off";
		BucksDTO dto = loginMapper.findStoreById(storeId);
		// System.out.println(dto);
		
		if(dto != null) {
			if(dto.getBucksPasswd().equals(storePw)) {
				System.out.println("로그인");
				
				req.getSession().setAttribute("inUser", dto); 
				req.setAttribute("msg", dto.getBucksId()+"님이 로그인하셨습니다. 메인 페이지로 이동합니다");
				req.setAttribute("url", "store_index");
			}
		}
		return "message";
	}
	
}
