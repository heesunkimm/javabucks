package com.project.javabucksAdmin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.javabucksAdmin.dto.AdminDTO;
import com.project.javabucksAdmin.mapper.LoginMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// admin 어드민 

@Controller
public class LoginController {

	@Autowired
	LoginMapper loginMapper;

	// 시작
	@RequestMapping(value = { "/", "/login.do" }) // http://localhost:8889/login.do
	public String index() {
		return "login/admin_login";
	}

	@GetMapping("/admin_login")
	public String login() {
		return "login/admin_login";
	}
	
	// 로그인 
	@GetMapping(value = { "/sessionUserCheck" })
	public boolean sessionUserCheck(HttpServletRequest req) {
		// 로그인되지 않은 상태에서 접근 시 로그인 페이지로 리다이렉트
		return req.getSession() != null && req.getSession().getAttribute("inAdmin") != null;
	}
	
	@GetMapping("/admin_adminmanage")
	public String admin_index(HttpServletRequest req) {
		if (req.getSession().getAttribute("inAdmin") == null) {
	        // 로그인되지 않은 상태에서 접근 시 로그인 페이지로 리다이렉트
	        return "redirect:/admin_login";
	    }
	    // return "account/admin_index";
		return "account/admin_adminmanage";
	}

	// 로그인 
	@PostMapping("/admin_adminmanage")
	public String admin_login(@RequestParam Map<String, String> params, HttpServletRequest req,
			HttpServletResponse resp) {
		String adminId = params.get("adminId");
		String adminPasswd = params.get("adminPasswd");
		String saveId = params.containsKey("saveId") ? "on" : "off"; // 아이디 저장하기

		System.out.println("adminId: " + adminId);
		System.out.println("adminPasswd: " + adminPasswd);
		System.out.println("saveId: " + saveId);

		AdminDTO admin = loginMapper.findAdminById(adminId);
		System.out.println("dto:" + admin);

		// admin 존재하면
		if (admin != null) {
			// // DB에 저장된 비밀번호와 입력한 비밀번호가 일치한지 확인
			if (admin.getAdminPasswd().equals(adminPasswd)) {
				System.out.println("로그인");
				// 세션에 사용자 정보 저장하여 로그인상태 유지
				req.getSession().setAttribute("inAdmin", admin);
				req.setAttribute("msg", admin.getAdminId() + "님이 로그인하셨습니다. 메인 페이지로 이동합니다");
				req.setAttribute("url", "admin_adminmanage");
				
				// 쿠키처리
				if("on".equals(saveId)) {
					// 아이디 저장 체크박스가 선택된 경우 
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
				System.out.println("비밀번호 불일치");
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인후 로그인 해주세요");
				req.setAttribute("url", "admin_login");
			}
		}
		// admin이 존재하지 않으면
		else {
			System.out.println("누구세요?");
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인후 로그인 해주세요.");
			req.setAttribute("url", "admin_login");
		}
		return "message";
	}
	
	// 비밀번호 재설정 
	@PostMapping("/admin_ChangePw")
	public String editAdmin(@RequestParam Map<String, String> params, HttpServletRequest req,
			HttpServletResponse resp) {
		
		String adminId = params.get("adminId");
		String changePw1 = params.get("changePw1");
		String changePw2 = params.get("changePw2");
		System.out.println(adminId);
		System.out.println(changePw1);
		System.out.println(changePw2);
		
		 // 비밀번호 확인
        if (!changePw1.equals(changePw2)) {
        	req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 비밀번호를 다시 입력해주세요. ");
        	req.setAttribute("url","admin_login");  // 오류 페이지로 이동
            return "message";
        }

        AdminDTO dto = loginMapper.findAdminById(params.get("adminId"));
        
        if(dto!=null) {
        	dto.setAdminPasswd(changePw1); // 비밀번호 재설정 
        	
        	int result = loginMapper.updatePasswd(dto); // 비밀번호 변경 쿼리문 
        	if(result>0) {
        		req.setAttribute("msg", "비밀번호 변경을 성공하였습니다. 다시 로그인 해주세요.");
        		req.setAttribute("url", "admin_login");
        	}else {
        		req.setAttribute("msg", "비밀번호 변경이 실패되었습니다. 비밀번호를 다시 확인해 주세요.");
     		    req.setAttribute("url", "admin_login");
        	}
        }
        return "message";
	}
	
	// 관리자 계정관리 ------------------------------------------------------
	@GetMapping("/adminmanage.do")
	public String adminManage(@RequestParam Map<String, String> params, HttpServletRequest req,
			HttpServletResponse resp) {
		return "account/admin_adminmanage";
	}
	
	
	
	// 유저 계정관리  ------------------------------------------------------
	
	
} 
        
 
 
        
 
 
		
 










