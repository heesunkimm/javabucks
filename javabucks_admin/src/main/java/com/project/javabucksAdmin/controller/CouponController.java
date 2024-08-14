package com.project.javabucksAdmin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksAdmin.dto.CouponDTO;
import com.project.javabucksAdmin.mapper.CouponMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CouponController {
	
	@Autowired
	private CouponMapper couponMapper;
	
	@RequestMapping("/admin_cpnmange")
	public String cpnIndex (HttpServletRequest req) {
		List<CouponDTO> cpnList = couponMapper.listCoupon();
		req.setAttribute("cpnList", cpnList);
		
		return "/coupon/admin_cpnmange";
	}
	
	// 쿠폰등록
	@PostMapping("/insertCoupon.ajax")
	@ResponseBody
	public ResponseEntity<String> insertCoupon(@RequestBody CouponDTO dto) {
	    
	    // 중복 체크
	    CouponDTO cpnCheck = couponMapper.cpnCheck(dto);
	    
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/plain; charset=UTF-8");
	    
	    if (cpnCheck != null) {
	        // 중복된 쿠폰이 있을 경우
	    	System.out.println("중복쿠폰 확인");
	    	return ResponseEntity.ok().headers(headers).body("중복 쿠폰 확인");
	    }

	    // 쿠폰 등록
	    int res = couponMapper.insertCoupon(dto);

	    if (res > 0) {
	        return ResponseEntity.ok().headers(headers).body("쿠폰 등록 완료");
	    } else {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).headers(headers).body("쿠폰 등록 실패");
	    }
	}
	
	// 쿠폰삭제
	@PostMapping("/deleteCoupon.ajax")
	@ResponseBody
	public ResponseEntity<String> deleteCounpon(@RequestBody Map<String, String> params) {
		String cpnCode = params.get("cpnCode");
		int res = couponMapper.deleteCoupon(cpnCode);
		
		HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/plain; charset=UTF-8");
	    
	    if (res > 0) {
	        return ResponseEntity.ok().headers(headers).body("쿠폰 삭제 완료");
	    } else {
	        return ResponseEntity.ok().headers(headers).body("쿠폰 삭제 실패");
	    }
	}
	
	@GetMapping("/getCouponList.ajax")
	@ResponseBody
	public ResponseEntity<List<CouponDTO>> getCouponList() {
	    List<CouponDTO> cpnList = couponMapper.listCoupon();
	    return ResponseEntity.ok(cpnList);
	}
}
