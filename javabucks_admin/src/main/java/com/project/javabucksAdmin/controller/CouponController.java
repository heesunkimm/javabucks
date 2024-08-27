package com.project.javabucksAdmin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
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
	public String insertCoupon(@RequestBody CouponDTO dto) {
	    
	    // 중복 체크
	    CouponDTO cpnCheck = couponMapper.cpnCheck(dto);
	    
	    if (cpnCheck != null) {
	        // 중복된 쿠폰이 있을 경우
	    	return "[" + dto.getCpnCode() + "] " + "이미 등록된 쿠폰코드입니다.";
	    }

	    // 쿠폰 등록
	    int res = couponMapper.insertCoupon(dto);

	    if (res > 0) {
	        return "쿠폰등록이 완료되었습니다.";
	    } else {
	        return "쿠폰등록에 실패하였습니다.";
	    }
	}
	
	// 쿠폰삭제
	@PostMapping("/deleteCoupon.ajax")
	@ResponseBody
	public String deleteCoupon(@RequestBody Map<String, String> params) {
		String cpnCode = params.get("cpnCode");
		
		int res = couponMapper.deleteCoupon(cpnCode);
		System.out.println(res);
		
	    if (res > 0) {
	        return "해당 쿠폰이 삭제되었습니다.";
	    } else {
	        return "해당 쿠폰 삭제를 실패하였습니다.";
	    }
	}
	
	
	@GetMapping("/getCouponList.ajax")
	@ResponseBody
	public ResponseEntity<List<CouponDTO>> getCouponList() {
	    List<CouponDTO> cpnList = couponMapper.listCoupon();
	    return ResponseEntity.ok(cpnList);
	}
	
	// 매일 자정에 실행
//    @Scheduled(cron = "0 0 0 * * ?")
//    public String userinfoCheck() {
//    	
//    }
}
