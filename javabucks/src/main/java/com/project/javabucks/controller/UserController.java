package com.project.javabucks.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.javabucks.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UserController {

	@RequestMapping("/user_index")
	public String userIndex(HttpServletRequest req) {
		UserDTO dto = new UserDTO();
		dto.setUserId("inUser");
		dto.setUserPasswd("inUser");
		dto.setUserName("이용중");
		dto.setUserNickname("별며어엉");
		dto.setUserGender("M");
		dto.setUserBirth("920606");
		dto.setUserEmail1("sky2464");
		dto.setUserEmail2("naver.com");
		dto.setUserTel1("010");
		dto.setUserTel2("6859");
		dto.setUserTel3("4432");
		dto.setGradeCode("gold");
		dto.setUserGradedate("24-08-06");
		dto.setUserJoindate("24-06-06");
		dto.setUserEnable("Y");
		dto.setUserFrequencyCount("500");
		req.getSession().setAttribute("inUser", dto);
		
		return "/user/user_index";
	}

	@RequestMapping("/user_pay")
	public String userPay() {
		return "/user/user_pay";
	}

	@RequestMapping("/user_addcard")
	public String userAddcard() {
		return "/user/user_addcard";
	}

	@RequestMapping("/user_store")
	public String userStore() {
		return "/user/user_store";
	}

	@RequestMapping("/user_delivers")
	public String userDelivers() {
		return "/user/user_delivers";
	}

	@RequestMapping("/user_other")
	public String userOther() {
		return "/user/user_other";
	}

	@RequestMapping("/user_alarm")
	public String userAlarm() {
		return "/user/user_alarm";
	}

	@RequestMapping("/user_starhistory")
	public String userStarhistory() {
		return "/user/user_starhistory";
	}

	@RequestMapping("/user_recepit")
	public String userRecepit() {
		return "/user/user_recepit";
	}

	@RequestMapping("/user_info")
	public String userInfo() {
		return "/user/user_info";
	}

	@RequestMapping("/user_mymenu")
	public String userMymenu() {
		return "/user/user_mymenu";
	}

	@RequestMapping("/user_cpnhistory")
	public String userCpnhistory() {
		return "/user/user_cpnhistory";
	}

	@RequestMapping("/user_delivershistory")
	public String userDelivershistory() {
		return "/user/user_delivershistory";
	}
	@RequestMapping("/user_orderhistory")
	public String userOrderhistory() {
		return "/user/user_orderhistory";
	}

	@RequestMapping("/user_paynow")
	public String userPaynow() {
		return "/user/user_paynow";
	}
	
	@RequestMapping("/user_paycharge")
	public String userPaycharge() {
		return "/user/user_paycharge";
	}
}
