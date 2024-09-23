package com.project.javabucksStore.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class ExceptionController {
	
	@ExceptionHandler(NullPointerException.class)
	public String controlNullPointerException(NullPointerException ex, HttpServletRequest req) {
		if (req.getSession().getAttribute("inBucks") != null) {
			req.setAttribute("msg", "세션이 만료되었거나 잘못된 접근입니다. 이전 페이지로 이동합니다.");
			req.setAttribute("url", "login.do");
		} else {
			req.setAttribute("msg", "잘못된 접근입니다. 로그인 후 이용해주세요.");
			req.setAttribute("url", "login.do");
		}
		return "message"; 
	}
}
