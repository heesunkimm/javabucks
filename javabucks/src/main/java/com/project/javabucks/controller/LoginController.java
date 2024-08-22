package com.project.javabucks.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
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
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	
	
	@Autowired
	LoginMapper loginMapper;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 로그인 창
	@RequestMapping(value= {"/", "/user_login"})
	public String index() {
		return "userLogin/user_login";
	}
	
	// 회원가입창으로 이동
	@GetMapping("/user_join")
	public String join() {
		return "userLogin/user_join";
	}
	
	// 회원가입 ---------------------------------
	
	// 회원가입하고나면 메인으로 이동
	@PostMapping("/user_join")
	public String join_form(HttpServletRequest req, @ModelAttribute UserDTO dto) {
		// System.out.println("req:"+req); 
//		System.out.println("dto.id:"+dto.getUserId());
//		System.out.println("dto.passwd:"+dto.getUserPasswd());
//		System.out.println("dto.name:"+dto.getUserName());
//		System.out.println("dto.nickname:"+dto.getUserNickname());
//		System.out.println("dto.gender:"+dto.getUserGender());
//		System.out.println("dto.birth:"+dto.getUserBirth());
//		System.out.println("dto.email1:"+dto.getUserEmail1());
//		System.out.println("dto.email2:"+dto.getUserEmail2());
//		System.out.println("dto.tel1:"+dto.getUserTel1());
//		System.out.println("dto.tel2:"+dto.getUserTel2());
//		System.out.println("dto.tel3:"+dto.getUserTel3());
//		System.out.println("dto.getGradeCode:"+dto.getGradeCode());
//		System.out.println("dto.getUserGradedate:"+dto.getUserGradedate());
//		System.out.println("dto.getUserJoindate:"+dto.getUserJoindate());
//		System.out.println("dto.getUserEnable:"+dto.getUserEnable());
//		System.out.println("dto.getUserFrequencyCount:"+dto.getUserFrequencyCount());
		int res =  loginMapper.insertUser(dto);
		System.out.println("res:"+res); // 1 
		 
		if(res>0) {
			req.setAttribute("msg","회원가입성공! 로그인 페이지로 이동합니다.");
			req.setAttribute("url","user_login");
			return "message";
		}else {
			req.setAttribute("msg", "회원가입 실패. 다시 시도 해주세요");
			req.setAttribute("url","user_join");
			return "message";
		}
	}
	
	// 아이디 중복 확인
	 @ResponseBody
	 @RequestMapping(value = "/idCheck")
	 public String checkId(@RequestParam("id") String id) {
		 int res = loginMapper.checkId(id);
		 if(res == 0) {
			 return "OK";
		 }else {
			 return "FAIL";
		 }
	 }
	  
//	 이메일 인증 
	 @ResponseBody
	 @PostMapping("/sendEmail")
	 public String sendEmail(@RequestParam Map<String,String> params, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws Exception {
		 try {
		        // System.out.println(params); // userEmail1 , userEmail2
		        String email1 = params.get("userEmail1");
		        String email2 = params.get("userEmail2");
		        String email = email1 + "@" + email2;
 
		        Map<String, String> paramMap = new HashMap<>();
		        paramMap.put("userEmail1", email1);
		        paramMap.put("userEmail2", email2);
		        
		        Random random = new Random();
		        String code = String.valueOf(random.nextInt(900000) + 100000);
		        Cookie cookie = new Cookie("checkCode",code);
		        // cookie.setMaxAge(60*3);
		        resp.addCookie(cookie);
		        
		        UserDTO dto = loginMapper.findUserByEmail(paramMap);
		        
		        if(dto!=null) {
		        	return "FAIL"; // 이메일이 이미 존재하는 경우
		        }
		        
		        // 이메일 전송 로직
			 	MimeMessage msg = mailSender.createMimeMessage();
		        MimeMessageHelper helper = new MimeMessageHelper(msg, true);
		        
		        helper.setFrom("mihyun6656@gmail.com");
		        helper.setTo(email);
		        helper.setSubject("JavaBucks 이메일 인증번호입니다.");
		        helper.setText("안녕하세요!! JavaBucks 입니다.\n\n 이메일 인증 번호 : " + code
		                + " \n\n 회원가입을 진행 하시려면 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다." + "\n\n --JavaBucks--");
		        mailSender.send(msg);
		        req.setAttribute("msg", "해당 이메일로 정보를 전송하였습니다.");
		        return "OK";
		        
		 }catch(Exception  e) {
			  e.printStackTrace();  // 로그를 통해 상세 예외 메시지 확인
		        req.setAttribute("msg", "이메일 전송 중 오류가 발생했습니다.");
		        return "FAIL";
		 }
	 }
	 
	 @ResponseBody
	 @RequestMapping(value = {"/codeCheck"})
	 public String codeCheck(@RequestParam("code") String code, HttpServletRequest req) {
		 Cookie [] ck = req.getCookies();
		 if(ck != null) {
			 for(Cookie cookie : ck) {
				 if(cookie.getName().contentEquals("checkCode")) {
					 if(cookie.getValue().equals(code)) {
						 return "OK";
					 }
				 }
			 }
		 }
		 return "FAIL";
	 }
	 
	 
	// 로그인 ---------------------------------
	// 로그인을 누르면 user_index 창으로 이동
	// 중요) 성진님과 중복이니 꼭 협의 후에 커밋할 것 !!!  
	@GetMapping("/user_index")
	public String user_index() {
		return "user/user_index";
	}
	
	// 중요) 성진님과 중복이니 꼭 협의 후에 커밋할 것 !!!  
	@PostMapping("/user_index")
	public String login(@RequestParam Map<String, String> params,
						HttpServletRequest req, HttpServletResponse resp) {

		String userId = params.get("userId");
		String userPasswd = params.get("userPasswd");
		// String saveId = params.getOrDefault("saveId", "off"); // 체크박스가 없으면 기본값 'off'
		String saveId = params.containsKey("saveId") ? "on" : "off";
		
		System.out.println("userId: "+ userId); 
		System.out.println("userPasswd: "+ userPasswd); 
		System.out.println("saveId: "+ saveId); 
		System.out.println("params : " + params);
		
		// 아이디로 사용자 정보 가져오기 
		UserDTO user = loginMapper.findUserById(userId); 
		
		// user가 존재하면
		if(user != null) {
			// DB에 저장된 비밀번호와 입력한 비밀번호가 일치한지 확인
			if(user.getUserPasswd().equals(userPasswd)) { 
				System.out.println("로그인");
				
				// 세션에 사용자 정보 저장하여 로그인상태 유지
				req.getSession().setAttribute("inUser", user); 
				req.setAttribute("msg", user.getUserId()+"님이 로그인하셨습니다. 메인 페이지로 이동합니다");
				req.setAttribute("url", "user_index");
	            
				// 쿠키처리
				if("on".equals(saveId)) {
					// 아이디 저장 체크박스가 선택된 경우 
					Cookie cookie = new Cookie("saveId",userId); // 사용자 ID를 저장하는 쿠키 생성
					cookie.setMaxAge(24 * 60 * 60);  // 24시간동안 유지
					cookie.setPath("/");  	 // 모든 경로에서 접근 가능하도록 설정
					resp.addCookie(cookie);	 // 응답에 쿠키 추가
				}
				// 쿠키 제거
				else {
					 // 체크박스가 선택되지 않은 경우, 기존 쿠키 삭제
					Cookie cookie = new Cookie("saveId","");
					cookie.setMaxAge(0);
					cookie.setPath("/");
					resp.addCookie(cookie);  
				}
			}
			// 비밀번호 불일치
			else if(!(user.getUserPasswd().equals(userPasswd))){
				System.out.println("비밀번호 불일치");
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인후 로그인 해주세요");
				req.setAttribute("url", "user_login");
			}
		// user가 존재하지 않으면 
		}else {
			System.out.println("누구세요?");
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인후 로그인 해주세요.");
			req.setAttribute("url", "user_login");
		}
		return "message";
	}
	
	// 로그아웃 
	@GetMapping("/user_logout")
	public String logout(HttpServletRequest req,HttpServletResponse resp) {
		 // 세션 무효화
	    HttpSession session = req.getSession(false);
	    if (session != null) {
	        session.invalidate();
	        req.getSession().invalidate();  // invalidate() 세션 삭제
	    }
	    
		req.setAttribute("msg", "로그아웃 되었습니다.");
		req.setAttribute("url", "user_login"); // 로그인 페이지로 이동 
		return "message";
	}
	
	// 아이디 찾기 
	@ResponseBody
	@PostMapping("/emailForId")
	public String emailForId(@RequestParam Map<String, String> params, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws Exception {
	    try {
	        System.out.println("params:" + params);
	        String email1 = params.get("userEmail1");
	        String email2 = params.get("userEmail2");
	        String email = email1 + "@" + email2;

	        Map<String, String> paramMap = new HashMap<>();
	        paramMap.put("userEmail1", email1);
	        paramMap.put("userEmail2", email2);

	        Random random = new Random();
	        String code = String.valueOf(random.nextInt(900000) + 100000);
	        Cookie cookie = new Cookie("checkCode", code);
	        resp.addCookie(cookie);

	        UserDTO dto = loginMapper.emailForId(paramMap);

	        MimeMessage msg = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(msg, true);

	        helper.setFrom("mihyun6656@gmail.com");
	        helper.setTo(email);
	        helper.setSubject("JavaBucks 이메일 인증번호입니다.");
	        helper.setText("안녕하세요!! JavaBucks 입니다.\n\n 이메일 인증 번호 : " + code
	                + " \n\n 회원가입을 진행 하시려면 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다." + "\n\n --JavaBucks--");
	        mailSender.send(msg);

	        req.setAttribute("msg", "해당 이메일로 정보를 전송하였습니다.");
	        req.setAttribute("url", "user_login");
	         
	        return "OK";

	    } catch (Exception e) {
	        e.printStackTrace();
	        req.setAttribute("msg", "이메일 전송 중 오류가 발생했습니다.");
	        return "FAIL";
	    }
	}
	
	// emailForPw
	@ResponseBody
	@PostMapping("/emailForPw")
	public String emailForPw(@RequestParam Map<String, String> params, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws Exception {
	    try {
	        System.out.println("params:" + params);
	        String id = params.get("findbypw_id");
	        String email1 = params.get("findbypw_email1");
	        String email2 = params.get("findbypw_email2");
	        String email = email1 + "@" + email2;
	        
	        System.out.println("id: " + id);
	        System.out.println("email1: " + email1);
	        System.out.println("email2: " + email2);

	        Map<String, String> paramMap = new HashMap<>();
	        paramMap.put("userEmail1", email1);
	        paramMap.put("userEmail2", email2);

	        Random random = new Random();
	        String code = String.valueOf(random.nextInt(900000) + 100000);
	        Cookie cookie = new Cookie("checkCode", code);
	        resp.addCookie(cookie);

	        UserDTO dto = loginMapper.emailForId(paramMap);

	        MimeMessage msg = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(msg, true);

	        helper.setFrom("mihyun6656@gmail.com");
	        helper.setTo(email);
	        helper.setSubject("JavaBucks 이메일 인증번호입니다.");
	        helper.setText("안녕하세요!! JavaBucks 입니다.\n\n 현재 비밀번호 : " + dto.getUserPasswd() + "입니다."
	                + " \n\n 회원가입을 진행 하시려면 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다." + "\n\n --JavaBucks--");
	        mailSender.send(msg);

	        req.setAttribute("msg", "해당 이메일로 정보를 전송하였습니다.");
	        req.setAttribute("url", "user_login");
	         
	        return "OK";

	    } catch (Exception e) {
	        e.printStackTrace();
	        req.setAttribute("msg", "이메일 전송 중 오류가 발생했습니다.");
	        return "FAIL";
	    }
	}
	
	 
	 
	 
} 
 
	 
 