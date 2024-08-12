package com.project.javabucks.controller;

import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LoginController {
	
	
	@Autowired
	LoginMapper loginMapper;
	
	@Autowired
	JavaMailSender javaMailSender;
	
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
	 @RequestMapping(value = "/sendEmail")
	 public String sendEmail(@RequestParam Map<String,String>params, HttpServletRequest req, HttpServletResponse resp) throws Exception{ // 쿠키 추가를 위해 resp 
		 	MimeMessage msg = javaMailSender.createMimeMessage();
		 	MimeMessageHelper helper = new MimeMessageHelper(msg,true);
		 	String email = params.get("userEmail1") + params.get("userEmail2");
		 	
		 	Random random = new Random();
		 	String code = String.valueOf(random.nextInt(900000) + 100000);
		 	Cookie cookie = new Cookie("code",code);
		 	cookie.setMaxAge(60*2);
		 	resp.addCookie(cookie);
		 	
			// 보내는 사람 이메일 주소 설정.
			helper.setFrom("mh5624@nate.com");
			// 이메일의 수신자 주소를 설정
			helper.setTo(email);
			// 이메일의 제목을 설정합니다.
			helper.setSubject("JavaBucks Email 인증번호입니다. ");
			 // 이메일의 본문 내용을 설정합니다. 생성된 인증 코드가 포함됩니다.
			helper.setText("안녕하세요!! JavaBucks입니다.\n\n 이메일 인증 번호 : " + code
					+ "\n\n 회원가입을 진행 하시려면 해당 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다.");
			// 이메일을 전송합니다.
			javaMailSender.send(msg);
			// 메소드가 성공적으로 수행되었음을 클라이언트에게 알리기 위해 "OK" 문자열을 반환합니다.
			return "OK";
		 	
		 	
	 }
	 
	 
	  
 
	
 
	 
}