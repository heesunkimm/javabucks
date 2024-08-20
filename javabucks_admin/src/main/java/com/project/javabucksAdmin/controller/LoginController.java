package com.project.javabucksAdmin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.javabucksAdmin.dto.AdminDTO;
import com.project.javabucksAdmin.mapper.LoginMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// admin 어드민 

@Controller
public class LoginController {
	
	@Autowired
	LoginMapper loginMapper;
	
	//시작
	@RequestMapping(value= {"/","/login.do"}) // http://localhost:8889/login.do
	public String index() {
		return "login/admin_login";
	}
	
	@GetMapping("/admin_login")
	public String login() {
		return "login/admin_login";
	}
	
	@GetMapping("/admin_index")
	public String admin_index() {
		return "account/admin_index";
	}
	
	@PostMapping("/admin_index")
	public String admin_login(@RequestParam Map<String,String> params, HttpServletRequest req, HttpServletResponse resp) {
		String adminId = params.get("adminId");
		String adminPasswd = params.get("adminPasswd");
		System.out.println(adminId);
		System.out.println(adminPasswd);
		
		AdminDTO dto = loginMapper.findAdminById(adminId);
		System.out.println("dto:"+dto);
		
		if(dto != null) {
			if(dto.getAdminPasswd().equals(adminPasswd)) {
				System.out.println("로그인");
				req.getSession().setAttribute("inBucks", dto); 
				req.setAttribute("msg", dto.getAdminId()+"님이 로그인하셨습니다. 메인 페이지로 이동합니다");
				req.setAttribute("url", "admin_index");
			}
//				if("on".equals(saveId)) {
//					// 아이디 저장 체크박스가 선택된 경우 
//					Cookie cookie = new Cookie("saveId",storeId); // 사용자 ID를 저장하는 쿠키 생성
//					cookie.setMaxAge(24 * 60 * 60);  // 24시간동안 유지
//					cookie.setPath("/");  	 // 모든 경로에서 접근 가능하도록 설정
//					resp.addCookie(cookie);	 // 응답에 쿠키 추가
//				}else {
//					// 체크박스가 선택되지 않은 경우, 기존 쿠키 삭제
//					Cookie cookie = new Cookie("saveId","");
//					cookie.setMaxAge(0);
//					cookie.setPath("/");
//					resp.addCookie(cookie);  
//				}
//			} 
			// 비밀번호 불일치 
			else if(!dto.getAdminPasswd().equals(adminPasswd)) {
				System.out.println("비밀번호 불일치");
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인후 로그인 해주세요");
				req.setAttribute("url", "admin_login");
			}
		}
		// store가 존재하지 않으면 
		else {
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인후 로그인 해주세요.");
			req.setAttribute("url", "admin_login");
		}
		
		return "message";
	}
		 
	}
	
	
	 
	
 
