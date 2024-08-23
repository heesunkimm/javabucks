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
	
	@GetMapping("/store_login")
	public String login() {
		return "login/store_login";
	}
	
	@GetMapping("/store_index")
	public String store_index() {
		return "store_index";
	}
	
	// 로그인 및 아이디 저장
	@PostMapping("/store_index")
	public String login(@RequestParam Map<String, String> params,
						HttpServletRequest req, HttpServletResponse resp) {

		String storeId = params.get("storeId");
		String storePw = params.get("storePw");
		// String saveId = params.getOrDefault("saveId", "off"); // 체크박스가 없으면 기본값 'off'
		String saveId = params.containsKey("saveId") ? "on" : "off";
		
		System.out.println("storeId: "+ storeId); 
		System.out.println("storePw: "+ storePw); 
		System.out.println("saveId: "+ saveId); 
		System.out.println("params : " + params);
		
		 // getOrDefault 
		 // Java의 Map 인터페이스에서 제공하는 메서드로, 주어진 키에 대한 값을 반환하거나, 해당 키가 존재하지 않을 때 기본값을 반환
		
		// 아이디로 사용자 정보 가져오기 
		BucksDTO bucks = loginMapper.findStoreById(storeId); 
		
		// user가 존재하면
		if(bucks != null) {
			// DB에 저장된 비밀번호와 입력한 비밀번호가 일치한지 확인
			if(bucks.getBucksPasswd().equals(storePw)) { 
				System.out.println("로그인");
				
				// 세션에 사용자 정보 저장하여 로그인상태 유지
				req.getSession().setAttribute("inBucks", bucks); 
				req.setAttribute("msg", bucks.getBucksId()+"님이 로그인하셨습니다. 메인 페이지로 이동합니다");
				req.setAttribute("url", "store_index");
	            
				// 쿠키처리
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
				System.out.println("비밀번호 불일치");
				req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인후 로그인 해주세요");
				req.setAttribute("url", "store_login");
			}
		// user가 존재하지 않으면 
		}else {
			System.out.println("누구세요?");
			req.setAttribute("msg", "등록되지 않은 ID입니다. 다시 확인후 로그인 해주세요.");
			req.setAttribute("url", "store_login");
		}
		return "message";
		}
	
	
	 // 아이디 찾기 -------------------------------------------------------------------------------------------------------

		@ResponseBody
		@PostMapping("/findById")
		public String findById(@RequestParam Map<String, String> params, HttpServletRequest req, HttpServletResponse resp)
				throws Exception {
			try {
				String email1 = params.get("bucksEmail1");
				String email2 = params.get("bucksEmail2");
				String email = email1 + "@" + email2;

				Map<String, String> paramMap = new HashMap<>();
				paramMap.put("bucksEmail1", email1);
				paramMap.put("bucksEmail2", email2);

				BucksDTO dto = loginMapper.findStoreById2(paramMap);

				if (dto != null) {
					// 이메일 전송 로직
					MimeMessage msg = mailSender.createMimeMessage();
					MimeMessageHelper helper = new MimeMessageHelper(msg, true);
					email = params.get("bucksEmail1") + "@" + params.get("bucksEmail2");
					Random random = new Random();
					String code1 = String.valueOf(random.nextInt(900000) + 100000);

					Cookie cookie = new Cookie("checkCode1", code1);
					cookie.setMaxAge(60 * 3); // 쿠키의 수명을 3분으로 설정합니다.
					cookie.setPath("/");
					resp.addCookie(cookie);

					helper.setFrom("mihyun6656@gmail.com");
					helper.setTo(email);
					helper.setSubject("JavaBucks [아이디 찾기] 이메일 인증번호입니다.");
					helper.setText("안녕하세요!! JavaBucks 입니다.\n\n 이메일 인증 번호 : " + code1
							+ " \n\n 아이디 찾기을 진행 하시려면 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다." + "\n\n --JavaBucks--");
					mailSender.send(msg);
					return "OK";
				} else {
					System.out.println("누구?");
					return "FAIL";
				}

			} catch (Exception e) {
				e.printStackTrace(); // 로그를 통해 상세 예외 메시지 확인
				return "FAIL";
			}

		}
		
			// 아이디 찾기
			@ResponseBody
			@PostMapping("/verifyCode_id")
			public String verifyCode_id(@RequestParam Map<String, String> params, HttpServletRequest req, HttpServletResponse resp)
					throws Exception {
				try {
//							System.out.println(params.get("pw_id"));
//							System.out.println(params.get("pw_email1"));
//						 	System.out.println(params.get("pw_email2"));

					String email1 = params.get("bucksEmail1");
					String email2 = params.get("bucksEmail2");
					String email3 = email1 + "@" + email2;
					System.out.println(params);

					Map<String, String> paramMap = new HashMap<>();
					paramMap.put("bucksEmail1", email1);
					paramMap.put("bucksEmail2", email2);

					BucksDTO dto = loginMapper.findStoreById2(paramMap);

					if (dto != null) {
						// 이메일 전송 로직
						MimeMessage msg = mailSender.createMimeMessage();
						MimeMessageHelper helper = new MimeMessageHelper(msg, true);
						//String email = params.get("bucksEmail1") + "@" + params.get("bucksEmail2");
						Random random = new Random();
						String code1 = String.valueOf(random.nextInt(900000) + 100000);

						Cookie cookie = new Cookie("checkCode1", code1);
						cookie.setMaxAge(60 * 3); // 쿠키의 수명을 3분으로 설정합니다.
						cookie.setPath("/");
						resp.addCookie(cookie);

						helper.setFrom("mihyun6656@gmail.com");
						helper.setTo(email3);
						helper.setSubject("[JavaBucks STORE ID]");
						helper.setText(
								"안녕하세요!! JavaBucks 입니다.\n\n 아이디는  " + dto.getBucksId() + " 입니다." + "\n\n --JavaBucks--");
						mailSender.send(msg);
						return "OK";
					} else {
						System.out.println("누구?");
						return "FAIL";
					}

				} catch (Exception e) {
					e.printStackTrace(); // 로그를 통해 상세 예외 메시지 확인
					return "FAIL";
				}
			}
	 
		// 비밀번호 찾기 ----------------------------------------------------------

		// 비밀번호 찾기
		@ResponseBody
		@PostMapping("/findByPw")
		public String findByPw(@RequestParam Map<String, String> params, HttpServletRequest req, HttpServletResponse resp)
				throws Exception {
			try {
//					System.out.println(params.get("pw_id"));
//					System.out.println(params.get("pw_email1"));
//				 	System.out.println(params.get("pw_email2"));

				String id = params.get("pw_id");
				String email1 = params.get("pw_email1");
				String email2 = params.get("pw_email2");
				String email3 = email1 + "@" + email2;

				Map<String, String> paramMap = new HashMap<>();
				paramMap.put("bucksId", id);
				paramMap.put("bucksEmail1", email1);
				paramMap.put("bucksEmail2", email2);

				BucksDTO dto = loginMapper.findStoreById(id);

				if (dto != null) {
					// 이메일 전송 로직
					MimeMessage msg = mailSender.createMimeMessage();
					MimeMessageHelper helper = new MimeMessageHelper(msg, true);
					String email = params.get("pw_email1") + "@" + params.get("pw_email2");
					Random random = new Random();
					String code = String.valueOf(random.nextInt(900000) + 100000);

					Cookie cookie = new Cookie("checkCode1", code);
					cookie.setMaxAge(60 * 3); // 쿠키의 수명을 3분으로 설정합니다.
					cookie.setPath("/");
					resp.addCookie(cookie);

					helper.setFrom("mihyun6656@gmail.com");
					helper.setTo(email);
					helper.setSubject("JavaBucks [비밀번호 찾기] 이메일 인증번호입니다.");
					helper.setText("안녕하세요!! JavaBucks 입니다.\n\n 이메일 인증 번호 : " + code
							+ " \n\n 비밀번호 찾기을 진행 하시려면 인증번호를 해당 칸에 입력해주세요.\n 이용해주셔서 감사합니다." + "\n\n --JavaBucks--");
					mailSender.send(msg);
					return "OK";
				} else {
					System.out.println("누구?");
					return "FAIL";
				}

			} catch (Exception e) {
				e.printStackTrace(); // 로그를 통해 상세 예외 메시지 확인
				return "FAIL";
			}
		}

		// 비밀번호 찾기
		@ResponseBody
		@PostMapping("/verifyCode")
		public String verifyCode(@RequestParam Map<String, String> params, HttpServletRequest req, HttpServletResponse resp)
				throws Exception {
			try {
//						System.out.println(params.get("pw_id"));
//						System.out.println(params.get("pw_email1"));
//					 	System.out.println(params.get("pw_email2"));

				String id = params.get("pw_id");
				String email1 = params.get("pw_email1");
				String email2 = params.get("pw_email2");
				String email3 = email1 + "@" + email2;

				Map<String, String> paramMap = new HashMap<>();
				paramMap.put("bucksId", id);
				paramMap.put("bucksEmail1", email1);
				paramMap.put("bucksEmail2", email2);

				BucksDTO dto = loginMapper.findStoreById(id);

				if (dto != null) {
					// 이메일 전송 로직
					MimeMessage msg = mailSender.createMimeMessage();
					MimeMessageHelper helper = new MimeMessageHelper(msg, true);
					String email = params.get("pw_email1") + "@" + params.get("pw_email2");
					Random random = new Random();
					String code = String.valueOf(random.nextInt(900000) + 100000);

					Cookie cookie = new Cookie("checkCode", code);
					cookie.setMaxAge(60 * 3); // 쿠키의 수명을 3분으로 설정합니다.
					cookie.setPath("/");
					resp.addCookie(cookie);

					helper.setFrom("mihyun6656@gmail.com");
					helper.setTo(email);
					helper.setSubject("[JavaBucks STORE PASSWORD]");
					helper.setText(
							"안녕하세요!! JavaBucks 입니다.\n\n 비밀번호는  " + dto.getBucksPasswd() + " 입니다." + "\n\n --JavaBucks--");
					mailSender.send(msg);
					return "OK";
				} else {
					System.out.println("누구?");
					return "FAIL";
				}

			} catch (Exception e) {
				e.printStackTrace(); // 로그를 통해 상세 예외 메시지 확인
				return "FAIL";
			}
		}

	 
	
}
