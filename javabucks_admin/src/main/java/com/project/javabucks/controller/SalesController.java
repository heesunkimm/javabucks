package com.project.javabucks.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucks.dto.BucksDTO;
import com.project.javabucks.mapper.SalesMapper;

@Controller
public class SalesController {
	
	@Autowired
	private SalesMapper salesMapper;
	
	//시작
	@RequestMapping("/")
	public String index() {
		return "account/admin_index";
	}
	
	//지점 계정 관리 페이지로 이동 
	@RequestMapping("/storemanage.do")
	public String storemanage() {
		return "account/admin_storemanage";
	}
		
	//지점 등록페이지로 이동
	@RequestMapping("/inputstore.do")
	public String inputstore() {
		return "account/admin_addstore";
	}
	
	//랜덤id생성
	@GetMapping("/generateUserId")
    @ResponseBody
    public String generateUserId() {
        return salesMapper.generateUniqueBucksId();
    }
	
	
	
}
