package com.project.javabucksAdmin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.javabucksAdmin.dto.CouponDTO;
import com.project.javabucksAdmin.mapper.CouponMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CouponController {
	
	@Autowired
	private CouponMapper couponMapper;
	
	@RequestMapping("/admin_cpnmange")
	public String cpnIndex (HttpServletRequest req) {
		
		return "/coupon/admin_cpnmange";
	}
	
	@PostMapping("/insertCoupon")
	public String insertCounpon(HttpServletRequest req) {
		
		return "redirect:/coupon/insertCoupon";
	}

}
