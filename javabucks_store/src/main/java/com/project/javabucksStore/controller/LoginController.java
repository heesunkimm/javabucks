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

//store 

@Controller
public class LoginController {
	
	@Autowired
	LoginMapper loginMapper;
	
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
		
		System.out.println(params); // storeId, storePw 
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
				req.getSession().setAttribute("inBucks", dto); 
				req.setAttribute("msg", dto.getBucksId()+"님이 로그인하셨습니다. 메인 페이지로 이동합니다");
				req.setAttribute("url", "store_index");
				
				if("on".equals(saveId)) {
					// 아이디 저장 체크박스가 선택된 경우 
					Cookie cookie = new Cookie("saveId",storeId); // 사용자 ID를 저장하는 쿠키 생성
					cookie.setMaxAge(24 * 60 * 60);  // 24시간동안 유지
					cookie.setPath("/");  	 // 모든 경로에서 접근 가능하도록 설정
					resp.addCookie(cookie);	 // 응답에 쿠키 추가
				}else {
					// 체크박스가 선택되지 않은 경우, 기존 쿠키 삭제
					Cookie cookie = new Cookie("saveId","");
					cookie.setMaxAge(0);
					cookie.setPath("/");
					resp.addCookie(cookie);  
				}
			}  
			// 비밀번호 불일치 
			else if(!dto.getBucksPasswd().equals(storePw)) {
				System.out.println("비밀번호 불일치");
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인후 로그인 해주세요");
				req.setAttribute("url", "store_login");
			}
		}
		// store가 존재하지 않으면 
		else {
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인후 로그인 해주세요.");
			req.setAttribute("url", "store_login");
		}
		
		return "message";
	}
	
}
