package com.project.javabucksStore.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.mapper.LoginMapper;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//store 

@Controller
public class LoginController {
	
	@Autowired
	LoginMapper loginMapper;
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value= {"/","/store_login"})
	public String index() {
		return "login/store_login";
	}
	
	// 로그인 및 아이디 저장
	@PostMapping("/store_index")
	public String login(@RequestParam Map<String, String> params,
						HttpServletRequest req, HttpServletResponse resp) {

		String storeId = params.get("storeId");
		String storePw = params.get("storePw");
		// 체크박스가 없으면 기본값 'off'
		String saveId = params.containsKey("saveId") ? "on" : "off";
		
		// 아이디로 사용자 정보 가져오기 
		BucksDTO bucks = loginMapper.findStoreById(storeId); 
		
		// user가 존재하면
		if(bucks != null) {
			// DB에 저장된 비밀번호와 입력한 비밀번호가 일치하는지 확인
			if(bucks.getBucksPasswd().equals(storePw)) { 
				// 세션에 사용자 정보 저장하여 로그인상태 유지
				req.getSession().setAttribute("inBucks", bucks); 
				req.setAttribute("msg", bucks.getBucksId()+"님이 로그인하셨습니다. 메인 페이지로 이동합니다");
				req.setAttribute("url", "store_index.do");
	            
				// 쿠키 처리
				if("on".equals(saveId)) {
					// 아이디 저장 체크박스가 선택된 경우 
					Cookie cookie = new Cookie("saveId",storeId); // 사용자 ID를 저장하는 쿠키 생성
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
			else if(!(bucks.getBucksPasswd().equals(storePw))){
				//System.out.println("비밀번호 불일치");
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인후 로그인 해주세요");
				req.setAttribute("url", "store_login");
			}
		// user가 존재하지 않으면 
		}else {
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인 후 로그인 해주세요.");
			req.setAttribute("url", "store_login");
		}
		return "message";
	}
	
	// 로그인 안하면 사이트 이용못하게 막기
	@ResponseBody
	@GetMapping("/sessionStoreCheck.ajax")
	public boolean sessionStoreCheck(HttpServletRequest req) {
		return req.getSession() != null && req.getSession().getAttribute("inBucks") != null;
	}

	// 아이디 찾기 이메일 발송
	@ResponseBody
	@PostMapping("/findStoreIdSendEmail.ajax")
	public String findStoreIdSendEmail(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String bucksEmail1, String bucksEmail2) throws Exception {
		try {
		        String email = bucksEmail1 + "@" + bucksEmail2;
		        Map<String, String> params = new HashMap<>();
		        params.put("bucksEmail1", bucksEmail1);
		        params.put("bucksEmail2", bucksEmail2);
		        
		        Random random = new Random();
		        String code = String.valueOf(random.nextInt(900000) + 100000);
		        Cookie cookie = new Cookie("checkCode",code);
		        cookie.setMaxAge(24 * 60 * 60);
		        cookie.setPath("/");
		        resp.addCookie(cookie);
		        
		        BucksDTO dto = loginMapper.findStoreByEmail(params);
		        
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
	 
	 
	// 아이디 찾기 처리
	@PostMapping("/findStoreIdbyEmail.do")
	public String findIdbyEmail(HttpServletRequest req, HttpServletResponse resp, String bucksEmail1, String bucksEmail2) throws Exception {
		try {
			String email = bucksEmail1 + "@" + bucksEmail2;
			Map<String, String> params = new HashMap<>();
			params.put("bucksEmail1", bucksEmail1);
			params.put("bucksEmail2", bucksEmail2);

			String Id = loginMapper.findStoreIdbyEmail(params);

			if (Id != null) {
				// 이메일 전송 로직
				MimeMessage msg = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(msg, true);

				helper.setFrom("admin@javabucks.com");
				helper.setTo(email);
				helper.setSubject("[JavaBucks BUCKS ID]");
				helper.setText(
						"안녕하세요!! JavaBucks 입니다.\n\n 아이디는  " + Id + " 입니다." + "\n\n --JavaBucks--");
				mailSender.send(msg);
				
				req.setAttribute("msg", "해당 메일로 아이디를 발송했습니다. 확인 후 로그인해주세요");
				req.setAttribute("url", "store_login");
			} else {
				req.setAttribute("msg", "아이디 메일 발송에 실패했습니다. 관리자에게 문의 바랍니다.");
				req.setAttribute("url", "store_login");
			}
			return "/message";

		} catch (Exception e) {
			e.printStackTrace(); 
			req.setAttribute("msg", "에러 발생. 관리자에게 문의바랍니다.");
			req.setAttribute("url", "store_login");
			return "/message";
		}
	}

	// 비밀번호 찾기 메일 발송
	@ResponseBody
	@PostMapping("/findStorePwSendEmail.ajax")
	public String findStorePwSendEmail(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String bucksId, String bucksEmail1, String bucksEmail2) throws Exception {
		 try {
		        String email = bucksEmail1 + "@" + bucksEmail2;
		        Map<String, String> params = new HashMap<>();
		        params.put("bucksEmail1", bucksEmail1);
		        params.put("bucksEmail2", bucksEmail2);
		        params.put("bucksId", bucksId);
		        
		        Random random = new Random();
		        String code = String.valueOf(random.nextInt(900000) + 100000);
		        Cookie cookie = new Cookie("checkCode",code);
		        cookie.setMaxAge(24 * 60 * 60);
		        resp.addCookie(cookie);
		        
		        BucksDTO dto = loginMapper.findStoreByIDEmail(params);
		        
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
	@PostMapping("/findStorePwbyEmail.do")
	public String findPwbyEmail(HttpServletRequest req, HttpServletResponse resp, String pw_id, String pw_email1, String pw_email2) throws Exception {
		try {
			String email = pw_email1 + "@" + pw_email2;
			Map<String, String> params = new HashMap<>();
			params.put("bucksEmail1", pw_email1);
			params.put("bucksEmail2", pw_email2);
			params.put("bucksId", pw_id);

			String Pw = loginMapper.findStorePWbyEmail(params);

			if (Pw != null) {
				// 이메일 전송 로직
				MimeMessage msg = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(msg, true);

				helper.setFrom("admin@javabucks.com");
				helper.setTo(email);
				helper.setSubject("[JavaBucks BUCKS PW]");
				helper.setText(
						"안녕하세요!! JavaBucks 입니다.\n\n 비밀번호는 " + Pw + " 입니다." + "\n\n --JavaBucks--");
				mailSender.send(msg);
				
				req.setAttribute("msg", "해당 메일로 비밀번호를 발송했습니다. 확인 후 로그인해주세요");
				req.setAttribute("url", "store_login");
			} else {
				req.setAttribute("msg", "비밀번호 메일 발송에 실패했습니다. 관리자에게 문의 바랍니다.");
				req.setAttribute("url", "store_login");
			}
			return "/message";

		} catch (Exception e) {
			e.printStackTrace(); 
			req.setAttribute("msg", "에러 발생. 관리자에게 문의바랍니다.");
			req.setAttribute("url", "store_login");
			return "/message";
		}
	}

	// 로그아웃 
	@GetMapping("/user_logout.do")
	public String logout(HttpServletRequest req) {
		// 세션 무효화
	    HttpSession session = req.getSession(false);
	    if (session != null) {
	        session.invalidate();
	        req.getSession().invalidate();  // invalidate() 세션 삭제
	    }
		req.setAttribute("msg", "로그아웃 되었습니다.");
		req.setAttribute("url", "store_login");
		return "message";
	}
	
	// 비밀번호 변경
	@ResponseBody
	@PostMapping("/changePasswd.ajax")
	public String changePasswd(HttpServletRequest req, String bucksId, String bucksPasswd) {
		
		Map<String, String> params = new HashMap<>();
		params.put("bucksId", bucksId);
		params.put("bucksPasswd", bucksPasswd);
		
		int changePasswdResult = loginMapper.changePasswd(params);
		
		if(changePasswdResult > 0) {
			return "success";
		} else {
			return "fail";
		}
	}

}
