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

import com.project.javabucks.dto.UserDTO;
import com.project.javabucks.mapper.LoginMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class LoginController {
	
	
	@Autowired
	LoginMapper loginMapper;
	
	// 로그인 창
	@RequestMapping(value= {"/", "/user_login"})
	public String index() {
		return "userLogin/user_login";
	}
	// 회원가입창으로 이동
	@GetMapping("/user_join.do")
	public String join() {
		return "userLogin/user_join";
	}
	
	// 회원가입하면 메인으로 이동
	@PostMapping("/user_join.do")
	public String join_form(Model model, @ModelAttribute UserDTO dto) {
		int res =  loginMapper.insertUser(dto);
		 
		if(res>0) {
			model.addAttribute("msg","회원가입성공! 메인페이지로 이동합니다.");
			model.addAttribute("url","user/user_index.do");
			 
		}else {
			model.addAttribute("msg", "회원가입 실패");
			model.addAttribute("url","user_join.do");
		}
		return "message";
	}
	
	// 아이디 중복 확인
	 @ResponseBody
	 @RequestMapping(value = "/idCheck.do")
	 public String checkId(@RequestParam("id") String id) {
		 int res = loginMapper.checkId(id);
		 if(res == 0) {
			 return "OK";
		 }else {
			 return "FAIL";
		 }
	 }
	  
	  @ResponseBody
	  @RequestMapping(value = { "/codeCheck.do" })
	  public String getCookie(@RequestParam("id") String id, HttpServletRequest req) {
	        // 쿠키 배열을 가져옵니다
	        Cookie[] cookies = req.getCookies();
	        
	        if (cookies != null) {
	            for (Cookie cookie : cookies) {
	                // 쿠키의 이름이 "checkCode"인지 확인합니다
	                if (cookie.getName().contentEquals("checkCode")) {
	                    // 쿠키의 값과 요청 파라미터의 값을 비교합니다
	                    if (cookie.getValue().equals(id)) {
	                        return "OK"; // 일치할 경우 "OK" 반환
	                    }
	                }
	            }
	        }
	        return "FAIL"; // 일치하지 않을 경우 "FAIL" 반환
	    }
	
 
	 
}
