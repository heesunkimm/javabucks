package com.project.javabucksAdmin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksAdmin.dto.AdminDTO;
import com.project.javabucksAdmin.mapper.LoginMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
public class LoginController {

	@Autowired
	LoginMapper loginMapper;

	@GetMapping(value = { "/", "/login.do" })
	public String index() {
		return "login/admin_login";
	}

	// 로그인 
	@ResponseBody
	@GetMapping("/sessionUserCheck")
	public boolean sessionUserCheck(HttpServletRequest req) {
		return req.getSession() != null && req.getSession().getAttribute("inAdmin") != null;
	}

	// 로그인 
	@PostMapping("/adminLogin.do")
	public String admin_login(@RequestParam Map<String, String> params, HttpServletRequest req,
			HttpServletResponse resp) {
		String adminId = params.get("adminId");
		String adminPasswd = params.get("adminPasswd");
		String saveId = params.containsKey("saveId") ? "on" : "off";

		AdminDTO admin = loginMapper.findAdminById(adminId);

		// admin 존재하면
		if (admin != null) {
			if (admin.getAdminPasswd().equals(adminPasswd)) {
				req.getSession().setAttribute("inAdmin", admin);
				req.setAttribute("msg", admin.getAdminId() + "님이 로그인하셨습니다.");
				req.setAttribute("url", "admin_adminmanage.do"); // 합치고나서 핑복이꺼로 경로 변경
				
				if("on".equals(saveId)) {
					Cookie cookie = new Cookie("saveId",adminId); // 사용자 ID를 저장하는 쿠키 생성
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
			else if (!admin.getAdminPasswd().equals(adminPasswd)) {
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인 후 로그인 해주세요");
				req.setAttribute("url", "/login.do");
			}
		}
		// admin이 존재하지 않으면
		else {
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인 후 로그인 해주세요.");
			req.setAttribute("url", "/login.do");
		}
		return "message";
	}

	
	// 비밀번호 재설정 
	@ResponseBody
	@PostMapping("/adminChangePw.ajax")
	public String adminChangePw(HttpServletRequest req, String adminId, String adminPasswd) {
		
		Map<String, String> params = new HashMap<>();
		params.put("adminId", adminId);
		params.put("adminPasswd", adminPasswd);
		
        int changeResult = loginMapper.adminChangePw(params);
        if(changeResult > 0) {
        	return "success";
        } else {
        	return "fail";
        }
        
	}
	
	// 로그아웃
	@GetMapping("/adminLogout.do")
	public String adminLogout(HttpServletRequest req) {
		// 세션 무효화
	    HttpSession session = req.getSession(false);
	    if (session != null) {
	        session.invalidate();
	        req.getSession().invalidate();
	    }
	    
		req.setAttribute("msg", "로그아웃 되었습니다.");
		req.setAttribute("url", "/login.do"); 
		return "message";

	}
} 
        
 
 
        
 
 
		
 










