package com.project.javabucks.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	// 로그인 안하면 사이트 이용못하게 막기
	@ResponseBody
	@RequestMapping(value = { "/sessionUserCheck" })
	public boolean sessionUserCheck(HttpServletRequest req) {
		return req.getSession() != null && req.getSession().getAttribute("inUser") != null;
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/user_join")
	public String join() {
		return "userLogin/user_join";
	}
	
	// 회원가입 처리
	@PostMapping("/userRegister.do")
	public String join_form(HttpServletRequest req, UserDTO dto) {
		String userId = String.valueOf(dto.getUserId());
		String passWd = String.valueOf(dto.getUserPasswd());
		String userName = String.valueOf(dto.getUserName());
		String userNickName = String.valueOf(dto.getUserId());
		String gender = String.valueOf(dto.getUserGender());
		String birth = String.valueOf(dto.getUserBirth());
		String email1 = String.valueOf(dto.getUserEmail1());
		String email2 = String.valueOf(dto.getUserEmail2());
		String tel1 = String.valueOf(dto.getUserTel1());
		String tel2 = String.valueOf(dto.getUserTel2());
		String tel3 = String.valueOf(dto.getUserTel3());
		String grade = String.valueOf(dto.getGradeCode());
		
		// "yyyyMMdd" 형식의 DateTimeFormatter 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        // 문자열을 LocalDate로 변환
        LocalDate birthDate = LocalDate.parse(birth, formatter);
		
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("passWd", passWd);
		params.put("userName", userName);
		params.put("userNickName", userNickName);
		params.put("gender", gender);
		params.put("birth", birthDate);
		params.put("email1", email1);
		params.put("email2", email2);
		params.put("tel1", tel1);
		params.put("tel2", tel2);
		params.put("tel3", tel3);
		params.put("grade", grade);
		
		// 오늘 날짜 가져오기
        LocalDate today = LocalDate.now();
        // 생일 가져오기
        String byear = "2024";
        String bmonth = birth.substring(4, 6);
        String bday = birth.substring(6, 8);
        String userBirth = byear+ bmonth +bday;
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate birthday = LocalDate.parse(userBirth, formatter2);

        // 만약 생일이 이미 지나갔다면, 다음 해 생일로 계산
        if (birthday.isBefore(today)) {
            birthday = birthday.plusYears(1);
        }
        
        // 생일까지의 차이 계산
        long daysUntilBirthday = ChronoUnit.DAYS.between(today, birthday);
        
        int registerResult = 0;
        // 가입했는데 생일이 일주일 이내인 경우
	    if(daysUntilBirthday <= 7) {
	    	registerResult = loginMapper.insertUser(params);
	    	if(registerResult > 0) {
	    		loginMapper.insertBday(params);
	    		req.setAttribute("msg","회원가입 완료! 로그인 후 이용해주세요.");
	    	}else {
	    		req.setAttribute("msg","회원가입 실패! 관리자에게 문의해주세요.");
	    	}
	    } 
	    // 가입했는데 생일이 일주일 이내에 해당하지 않는 경우
	    else {
	    	registerResult = loginMapper.insertUser(params);
	    	if(registerResult > 0) {
	    		loginMapper.insertNotBday(params);
	    		req.setAttribute("msg","회원가입 완료! 로그인 후 이용해주세요.");
	    	}else {
	    		req.setAttribute("msg","회원가입 실패! 관리자에게 문의해주세요.");
	    	}
	    }
		req.setAttribute("url", "user_login");
		
		return "message";
	}
	
	// 아이디 중복 확인
	@ResponseBody
	@PostMapping("/idCheck.ajax")
	public String checkId(String id) {
		 int res = loginMapper.checkId(id);
		 if(res == 0) {
			 return "OK";
		 }else {
			 return "FAIL";
		 }
	}
	 
	// 이메일 중복 확인
	 @ResponseBody
	 @PostMapping("/mailCheck.ajax")
	 public String checkId(String email1, String email2) {
		 
		 Map<String, String> params = new HashMap<>();
		 params.put("email1", email1);
		 params.put("email2", email2);
		 
		 int res = loginMapper.checkEmail(params);
		 if(res == 0) {
			 return "OK";
		 }else {
			 return "FAIL";
		 }
	 }
	  
	 // 회원가입 이메일 인증 
	 @ResponseBody
	 @PostMapping("/sendEmail.ajax")
	 public String sendEmail(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String userEmail1, String userEmail2) throws Exception {
		 try {
		        String email = userEmail1 + "@" + userEmail2;
 
		        Map<String, String> params = new HashMap<>();
		        params.put("userEmail1", userEmail1);
		        params.put("userEmail2", userEmail2);
		        
		        Random random = new Random();
		        String code = String.valueOf(random.nextInt(900000) + 100000);
		        Cookie cookie = new Cookie("checkCode",code);
		        cookie.setMaxAge(24 * 60 * 60);
		        cookie.setPath("/");
		        resp.addCookie(cookie);
		        
		        UserDTO dto = loginMapper.findUserByEmail(params);
		        
		        if(dto!=null) {
		        	return "FAIL"; // 이메일이 이미 존재하는 경우
		        }
		        
		        // 이메일 전송 로직
			 	MimeMessage msg = mailSender.createMimeMessage();
		        MimeMessageHelper helper = new MimeMessageHelper(msg, true);
		        helper.setFrom("admin@javabucks.com");
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
	 
	 // 인증번호 체크
	 @ResponseBody
	 @PostMapping("/codeCheck.ajax")
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
	 
	 // 아이디 찾기 이메일 발송 
	 @ResponseBody
	 @PostMapping("/findIdSendEmail.ajax")
	 public String findIdSendEmail(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String userEmail1, String userEmail2) throws Exception {
		 try {
		        String email = userEmail1 + "@" + userEmail2;
		        Map<String, String> params = new HashMap<>();
		        params.put("userEmail1", userEmail1);
		        params.put("userEmail2", userEmail2);
		        
		        Random random = new Random();
		        String code = String.valueOf(random.nextInt(900000) + 100000);
		        Cookie cookie = new Cookie("checkCode",code);
		        cookie.setMaxAge(24 * 60 * 60);
		        cookie.setPath("/");
		        resp.addCookie(cookie);
		        
		        UserDTO dto = loginMapper.findUserByEmail(params);
		        
		        if(dto!=null) {
			        // 이메일 전송 로직
				 	MimeMessage msg = mailSender.createMimeMessage();
			        MimeMessageHelper helper = new MimeMessageHelper(msg, true);
			        helper.setFrom("admin@javabucks.com");
			        helper.setTo(email);
			        helper.setSubject("JavaBucks 이메일 인증번호입니다.");
			        helper.setText("안녕하세요!! JavaBucks 입니다.\n\n 이메일 인증 번호 : " + code
			                + " \n\n 아이디찾기를 진행 하시려면 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다." + "\n\n --JavaBucks--");
			        mailSender.send(msg);
			        return "OK";
		        } else {
		        	return "NONE";
		        }
		 }catch(Exception  e) {
			  e.printStackTrace(); 
		        return "FAIL";
		 }
	 }
	 
	 
	 // 아이디 찾기 처리
	 @PostMapping("/findIdbyEmail.do")
	 public String findIdbyEmail(HttpServletRequest req, HttpServletResponse resp, String userEmail1, String userEmail2) throws Exception {
		try {
			String email = userEmail1 + "@" + userEmail2;
			Map<String, String> params = new HashMap<>();
			params.put("userEmail1", userEmail1);
			params.put("userEmail2", userEmail2);

			String Id = loginMapper.findIdbyEmail(params);

			if (Id != null) {
				// 이메일 전송 로직
				MimeMessage msg = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(msg, true);

				helper.setFrom("admin@javabucks.com");
				helper.setTo(email);
				helper.setSubject("[JavaBucks USER ID]");
				helper.setText(
						"안녕하세요!! JavaBucks 입니다.\n\n 아이디는  " + Id + " 입니다." + "\n\n --JavaBucks--");
				mailSender.send(msg);
				
				req.setAttribute("msg", "해당 메일로 아이디를 발송했습니다. 확인 후 로그인해주세요");
				req.setAttribute("url", "user_login");
			} else {
				req.setAttribute("msg", "아이디 메일 발송에 실패했습니다. 관리자에게 문의 바랍니다.");
				req.setAttribute("url", "user_login");
			}
			return "/message";

		} catch (Exception e) {
			e.printStackTrace(); 
			req.setAttribute("msg", "에러 발생. 관리자에게 문의바랍니다.");
			req.setAttribute("url", "user_login");
			return "/message";
		}
	}
	 
	// 비밀번호 찾기
	@ResponseBody
	@PostMapping("/findPwSendEmail.ajax")
	public String findPwSendEmail(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String userId, String userEmail1, String userEmail2) throws Exception {
		 try {
		        String email = userEmail1 + "@" + userEmail2;
		        Map<String, String> params = new HashMap<>();
		        params.put("userEmail1", userEmail1);
		        params.put("userEmail2", userEmail2);
		        params.put("userId", userId);
		        
		        Random random = new Random();
		        String code = String.valueOf(random.nextInt(900000) + 100000);
		        Cookie cookie = new Cookie("checkCode",code);
		        cookie.setMaxAge(24 * 60 * 60);
		        resp.addCookie(cookie);
		        
		        UserDTO dto = loginMapper.findUserByIDEmail(params);
		        if(dto!=null) {
			        // 이메일 전송 로직
				 	MimeMessage msg = mailSender.createMimeMessage();
			        MimeMessageHelper helper = new MimeMessageHelper(msg, true);
			        helper.setFrom("admin@javabucks.com");
			        helper.setTo(email);
			        helper.setSubject("JavaBucks 이메일 인증번호입니다.");
			        helper.setText("안녕하세요!! JavaBucks 입니다.\n\n 이메일 인증 번호 : " + code
			                + " \n\n 비밀번호 찾기를 진행 하시려면 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다." + "\n\n --JavaBucks--");
			        mailSender.send(msg);
			        return "OK";
		        } else {
		        	return "NONE";
		        }
		 }catch(Exception  e) {
			  e.printStackTrace(); 
		        return "FAIL";
		 }
	 }
	 
	// 비밀번호 찾기 처리
	@PostMapping("/findPwbyEmail.do")
	public String findPwbyEmail(HttpServletRequest req, HttpServletResponse resp, String findbypw_id, String findbypw_email1, String findbypw_email2) throws Exception {
		try {
			String email = findbypw_email1 + "@" + findbypw_email2;
			Map<String, String> params = new HashMap<>();
			params.put("userEmail1", findbypw_email1);
			params.put("userEmail2", findbypw_email2);
			params.put("userId", findbypw_id);

			String Pw = loginMapper.findPwbyEmail(params);

			if (Pw != null) {
				// 이메일 전송 로직
				MimeMessage msg = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(msg, true);

				helper.setFrom("admin@javabucks.com");
				helper.setTo(email);
				helper.setSubject("[JavaBucks USER ID]");
				helper.setText(
						"안녕하세요!! JavaBucks 입니다.\n\n 비밀번호는 " + Pw + " 입니다." + "\n\n --JavaBucks--");
				mailSender.send(msg);
				
				req.setAttribute("msg", "해당 메일로 비밀번호를 발송했습니다. 확인 후 로그인해주세요");
				req.setAttribute("url", "user_login");
			} else {
				req.setAttribute("msg", "비밀번호 메일 발송에 실패했습니다. 관리자에게 문의 바랍니다.");
				req.setAttribute("url", "user_login");
			}
			return "/message";

		} catch (Exception e) {
			e.printStackTrace(); 
			req.setAttribute("msg", "에러 발생. 관리자에게 문의바랍니다.");
			req.setAttribute("url", "user_login");
			return "/message";
		}
	}
	
	// 로그인 처리
	@PostMapping("/logincheck.do")
	public String login(@RequestParam Map<String, String> params,
						HttpServletRequest req, HttpServletResponse resp) {

		String userId = params.get("userId");
		String userPasswd = params.get("userPasswd");
		String saveId = params.containsKey("saveId") ? "on" : "off";

		// 아이디로 사용자 정보 가져오기 
		UserDTO user = loginMapper.findUserByLogin(userId); 
		
		// user가 존재하면
		if(user != null) {
			// DB에 저장된 비밀번호와 입력한 비밀번호가 일치한지 확인
			if(user.getUserPasswd().equals(userPasswd)) { 
				//System.out.println("로그인");
				
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
				//System.out.println("비밀번호 불일치");
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인 후 로그인 해주세요");
				req.setAttribute("url", "user_login");
			}
		// user가 존재하지 않으면 
		}else {
			//System.out.println("누구세요?");
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인 후 로그인 해주세요.");
			req.setAttribute("url", "user_login");
		}
		return "message";
	}
	
	// 로그아웃 
	@GetMapping("/user_logout")
	public String logout(HttpServletRequest req, HttpServletResponse resp) {
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

		
	// 개인정보 수정 화면
	@GetMapping("/userInfo.do")
	public String userInfo(HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO)session.getAttribute("inUser");
		String userId = dto.getUserId();
		
		UserDTO udto = loginMapper.getUserInfo(userId);
		
		req.setAttribute("userInfo", udto);

		return "/user/user_info";
	}
	
	
	// 비밀번호 체크
	@ResponseBody
	@PostMapping("/passWdCheck.ajax")
	public Boolean passWdCheck(HttpServletRequest req, String inputPasswd) {
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO)session.getAttribute("inUser");
		String userId = dto.getUserId();
		
		Boolean result = false;
		String passWd = loginMapper.getUserPassWd(userId);
		
		if(passWd.equals(inputPasswd)) {
			result = true;
		}
		return result;
	}
	
	
	
	// 개인정보 수정 처리
	@PostMapping("/updateUserInfo.do")
	public String updateUserInfo(HttpServletRequest req, String userNickname, String userPassword, String userTel1, String userTel2, String userTel3, String userEmail1, String userEmail2) {
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO)session.getAttribute("inUser");
		String userId = dto.getUserId();
		
		Map<String, Object> params = new HashMap<>();
		params.put("userNickname", String.valueOf(userNickname));
		params.put("userTel1", String.valueOf(userTel1));
		params.put("userTel2", String.valueOf(userTel2));
		params.put("userTel3", String.valueOf(userTel3));
		params.put("userEmail1", String.valueOf(userEmail1));
		params.put("userEmail2", String.valueOf(userEmail2));
		params.put("userId", userId);
		if(userPassword != null && !userPassword.isEmpty()) {
			params.put("userPassWd", String.valueOf(userPassword));
		}

		int updateResult = loginMapper.updateUserInfo(params);
		
		String msg = null;
		if(updateResult > 0) {
			msg = "회원정보가 수정되었습니다.";
			
		}else {
			msg = "회원정보 수정에 실패하였습니다. 관리자에게 문의해주세요.";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("url", "userInfo.do");
		
		return "message";
	}
	
	// 회원탈퇴
	@GetMapping("/userDel.do")
	public String userDel(HttpServletRequest req, String userId) {
		//System.out.println("userId :" +userId);
		int userEnableNUpdate = loginMapper.updateUserDel(userId);
		
		String msg = null;
		if(userEnableNUpdate > 0) {
			msg = "탈퇴처리가 완료되었습니다. 그동안 자바벅스를 이용해주셔서 감사드립니다.";
			
		}else {
			msg = "회원 탈퇴 실패. 관리자에게 문의해주세요.";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("url", "user_login");
		
		return "message";
	}
} 
 
	 
 