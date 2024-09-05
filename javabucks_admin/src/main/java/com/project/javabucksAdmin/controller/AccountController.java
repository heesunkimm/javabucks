package com.project.javabucksAdmin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.javabucksAdmin.dto.AdminDTO;
import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.dto.UserDTO;
import com.project.javabucksAdmin.mapper.AccountMapper;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AccountController {

		@Autowired
		private AccountMapper accountMapper;
	
		
		@GetMapping("/admin_adminmanage.do")
		public String adminList(HttpServletRequest req, @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
			
			
			int totalCount = accountMapper.adminListCount();
			Map<String, Object> pagingMap = paging(totalCount, pageNum);
			
		 // 파라미터 설정
		    Map<String, Object> params = new HashMap<>();
		    params.put("startIndex", pagingMap.get("startRow"));
			params.put("endIndex", pagingMap.get("endRow"));
		    
		    List<AdminDTO> list = accountMapper.adminList(params);
		  // System.out.println(list);
			
		    
		    req.setAttribute("adminList", list);
			req.setAttribute("startPage", (int)pagingMap.get("startPage"));
			req.setAttribute("endPage", (int)pagingMap.get("endPage"));
			req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
			req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
			
			return "account/admin_adminmanage";
		} 
		
		//관리자 검색
		@ResponseBody
		@PostMapping("/searchAdmin.do")
		public Map<String, Object> searchAdminList(
				@RequestParam(value = "startDate", required = false) String startDate, 
				@RequestParam(value = "endDate", required = false) String endDate,   
				@RequestParam(value = "enable", required = false) String enable,    
				@RequestParam(value = "adminId", required = false) String adminId,   
				@RequestParam(value = "authority", required = false) String authority, 
				@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum){      
//			
//			System.out.println(startDate);
//			System.out.println(endDate);
//			System.out.println(adminId);
//			System.out.println(authority);
//			
		    
		    
		    

		    Map<String, Object> params = new HashMap<>();
		    params.put("startDate", startDate != null ? startDate : ""); 
		    params.put("endDate", endDate != null ? endDate : "");       
		    params.put("enable", enable != null ? enable : "");          
		    params.put("adminId", adminId != null ? adminId : "");       
		    params.put("authority", authority != null ? authority : ""); 
		    
		    int totalCount = accountMapper.searchAdminCount(params);
		    Map<String, Object> pagingMap = paging(totalCount, pageNum);
		    
		    params.put("startIndex", pagingMap.get("startRow"));
			params.put("endIndex", pagingMap.get("endRow"));
		    
		    List<AdminDTO> list = accountMapper.searchAdminList(params); 
		    

		    // 결과를 JSON 형태로 반환
		    Map<String, Object> response = new HashMap<>();
		    response.put("adminList", list);
		    response.put("startPage", (int)pagingMap.get("startPage"));
		    response.put("endPage", (int)pagingMap.get("endPage"));
		    response.put("pageCount", (int)pagingMap.get("pageCount"));
		    response.put("pageBlock", (int)pagingMap.get("pageBlock"));
		 //   System.out.println("response : "+response);

		    return response;
		}

		 @GetMapping("/deleteAdmin.do")
		    public String deleteAdmin(@RequestParam("adminId") String adminId, RedirectAttributes redirectAttributes, HttpServletRequest req) {
			 
			    HttpSession session = req.getSession();
			    AdminDTO adto = (AdminDTO) session.getAttribute("inAdmin");
			    
			    if (adto != null && adto.getAdminId().equals(adminId)) {
			        redirectAttributes.addFlashAttribute("errorMessage", "본인의 계정은 삭제할 수 없습니다.");
			        return "redirect:/admin_adminmanage.do";
			    }

			    try {
			        accountMapper.deleteAdminById(adminId);
			        redirectAttributes.addFlashAttribute("message", "계정이 성공적으로 삭제되었습니다.");
			    } catch (Exception e) {
			        redirectAttributes.addFlashAttribute("errorMessage", "계정 삭제 중 오류가 발생했습니다.");
			    }
			    
			    return "redirect:/admin_adminmanage.do";
		    }
		
		//관리자 등록페이지로 이동
			@RequestMapping("/inputAdmin.do")
			public String inputAdmin() {
				return "account/admin_addAdmin";
			}
		
			
			//관리자 이메일 중복 확인
			@ResponseBody
			@GetMapping("/AdmincheckEmail")
			public String checkAdminEmail(@RequestParam("email") String email) {
				AdminDTO dto = new AdminDTO();
				dto.setAdminEmail(email);
				if (accountMapper.checkAdminEmail(dto)) {
					return "ok";
				} else {
					return "nok";
						}
			    }
			
			//관리자 아이디 중복 확인
			@ResponseBody
			@GetMapping("/checkAdminId")
			public String checkAdminId(@RequestParam("adminId") String adminId) {
				if (accountMapper.checkAdminId(adminId)) {
					return "ok";
				} else {
					return "nok";
						}
			    }
			
			//관리자 등록
			@RequestMapping(value = "/addAdmin.do", method = RequestMethod.POST )
			public String addAdmin( @RequestParam("userId") String adminId,
		            @RequestParam("adminPasswd") String adminPasswd,
		            @RequestParam("adminEmail1") String adminEmail1,
		            @RequestParam("adminEmail2") String adminEmail2) {
		       
		        AdminDTO dto = new AdminDTO();
		        dto.setAdminId(adminId);
		        dto.setAdminPasswd(adminPasswd);
		        dto.setAdminEmail(adminEmail1 +  adminEmail2);

		        
		        accountMapper.addAdmin(dto);

		        return "redirect:/admin_adminmanage.do";
		    }
			
			//관리자 수정 
			
			@GetMapping("/editAdmin.do")
			public String editAdmin(@RequestParam("adminId") String adminId, Model model) {
				//System.out.println(adminId);
				AdminDTO admin = accountMapper.editAdmin(adminId);
				
				String email = admin.getAdminEmail();
				String email1 = "";
			    String email2 = "";
			    if (email != null && email.contains("@")) {
			        String[] emailParts = email.split("@");
			        email1 = emailParts[0];
			        if (emailParts.length > 1) {
			            email2 = emailParts[1];
			        }
			    }
			    
			    // Model에 이메일 앞부분과 뒷부분, 그리고 관리자 정보 추가
			    model.addAttribute("jadmin", admin);
			    model.addAttribute("adminEmail1", email1);
			    model.addAttribute("adminEmail2", email2);

			    //System.out.println(admin);
				return "account/admin_editAdmin";
			}
			
			//수정 이메일 중복 확인
			@ResponseBody
			@GetMapping("/editCheckAdminEmail")
			public String editCheckAdminEmail(@RequestParam("email") String email,  @RequestParam("adminId") String adminId) {
				AdminDTO dto = new AdminDTO();
				dto.setAdminEmail(email);
				dto.setAdminId(adminId);
//				 System.out.println(adminId);

				if (accountMapper.editCheckAdminEmail(dto)) {
					return "ok";
				} else {
					return "nok";
						}
			    }
			
			//수정 업데이트
			@RequestMapping(value = "/editUpdateAdmin.do", method = RequestMethod.POST )
			public String editUpdateAdmin( @RequestParam("userId") String adminId,
					//@RequestParam("adminPasswd") String adminPasswd,
		            @RequestParam("adminEmail1") String adminEmail1,
		            @RequestParam("adminEmail2") String adminEmail2) {
		       
		        AdminDTO dto = new AdminDTO();
		        dto.setAdminId(adminId);
		       // dto.setAdminPasswd(adminPasswd);
		        dto.setAdminEmail(adminEmail1 + adminEmail2);
		        
		       
		        
		        accountMapper.editUpdateAdmin(dto);

		        return "redirect:/admin_adminmanage.do";
		    }
			
////////////////////유저계정
			
			@GetMapping("/admin_usermanage.do")
			public String userList(HttpServletRequest req, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
				
				int totalCount = accountMapper.userListCount();
				Map<String, Object> pagingMap = paging(totalCount, pageNum);
			 // 파라미터 설정
			    Map<String, Object> params = new HashMap<>();
			    params.put("startIndex", pagingMap.get("startRow"));
				params.put("endIndex", pagingMap.get("endRow"));		
			    
			    List<UserDTO> list = accountMapper.userList(params);
			   // System.out.println(list);
			    
			    for (UserDTO user : list) {
			        // 이메일을 합침
			        String fullEmail = user.getUserEmail1() + "@" + user.getUserEmail2();
			        user.setFullEmail(fullEmail);
			        
			        // 전화번호를 합침
			        String fullPhoneNumber = user.getUserTel1() + "-" + user.getUserTel2() + "-" + user.getUserTel3();
			        user.setFullPhoneNumber(fullPhoneNumber);
			    }
			    
				
			    
			    req.setAttribute("userList", list);
				req.setAttribute("startPage", (int)pagingMap.get("startPage"));
				req.setAttribute("endPage", (int)pagingMap.get("endPage"));
				req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
				req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
				
				return "account/admin_usermanage";
			} 
			
			
			//유저 검색
			@ResponseBody
			@PostMapping("/searchUser.do")
			public Map<String, Object> searchUserList(
					@RequestParam(value = "startDate", required = false) String startDate, 
					@RequestParam(value = "endDate", required = false) String endDate,   
					@RequestParam(value = "enable", required = false) String enable,    
					@RequestParam(value = "userId", required = false) String userId,   
					@RequestParam(value = "userNickname", required = false) String userNickname, 
					@RequestParam(value = "gradeCode", required = false) String gradeCode, 
					 @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
					 HttpServletRequest req) {
				
//				System.out.println(startDate);
				
			    
			    

			    Map<String, Object> params = new HashMap<>();
			    params.put("startDate", startDate != null ? startDate : ""); 
			    params.put("endDate", endDate != null ? endDate : "");       
			    params.put("enable", enable != null ? enable : "");          
			    params.put("userId", userId != null ? userId : "");       
			    params.put("userNickname", userNickname);                        
			    params.put("gradeCode", gradeCode); 
			    
			    int totalCount = accountMapper.searchUserCount(params); 
				Map<String, Object> pagingMap = paging(totalCount, pageNum);
				
				params.put("startIndex", pagingMap.get("startRow"));
				params.put("endIndex", pagingMap.get("endRow"));		  
			    
			    List<UserDTO> list = accountMapper.searchUserList(params); 
//			    System.out.println("list : "+list);
			    for (UserDTO user : list) {
			        // 이메일을 합침
			        String fullEmail = user.getUserEmail1() + "@" + user.getUserEmail2();
			        user.setFullEmail(fullEmail);
			        
			        // 전화번호를 합침
			        String fullPhoneNumber = user.getUserTel1() + "-" + user.getUserTel2() + "-" + user.getUserTel3();
			        user.setFullPhoneNumber(fullPhoneNumber);
			    }
			    

			    // 결과를 JSON 형태로 반환
			    Map<String, Object> response = new HashMap<>();
			    response.put("userList", list);
			    response.put("startPage", (int)pagingMap.get("startPage"));
			    response.put("endPage", (int)pagingMap.get("endPage"));
			    response.put("pageCount", (int)pagingMap.get("pageCount"));
			    response.put("pageBlock", (int)pagingMap.get("pageBlock"));
			    

			    return response;
			}
			
			
			
			//유저 탈퇴
			@GetMapping("/deleteUser.do")
		    public String deleteUser(@RequestParam("userId") String userId, RedirectAttributes redirectAttributes) {
		        try {
		            // 관리자 계정 삭제 로직 호출
		        	accountMapper.deleteUserById(userId);
		            redirectAttributes.addFlashAttribute("message", "계정이 성공적으로 탈퇴되었습니다.");
		        } catch (Exception e) {
		            redirectAttributes.addFlashAttribute("errorMessage", "계정 탈퇴 중 오류가 발생했습니다.");
		        }
		        // 관리 계정 리스트 페이지로 리다이렉트
		        return "redirect:/admin_usermanage.do";
		    }
			
			//유저 수정
			@GetMapping("/editUser.do")
			public String editUser(@RequestParam("userId") String adminId, Model model) {
				UserDTO user = accountMapper.editUser(adminId);
				
				
			    model.addAttribute("juser", user);

				return "account/admin_editUser";
			}
			
			//유저 수정 이메일 중복 확인
			@ResponseBody
			@GetMapping("/editCheckUserEmail")
			public String editCheckUserEmail(@RequestParam("email1") String email1, @RequestParam("email2") String email2,  @RequestParam("userId") String userId) {
				UserDTO dto = new UserDTO();
				dto.setUserEmail1(email1);
				dto.setUserEmail2(email2);
				dto.setUserId(userId);
				if (accountMapper.editCheckUserEmail(dto)) {
					return "ok";
				} else {
					return "nok";
						}
			    }
			
			//수정 업데이트
			@RequestMapping(value = "/editUpdateUser.do", method = RequestMethod.POST )
			public String editUpdateUser(
			        @RequestParam("userId") String userId,
			        @RequestParam("userName") String userName,
			        @RequestParam("userNickname") String userNickname,
			        @RequestParam("userBirth") String userBirth,
			        @RequestParam("userTel1") String userTel1,
			        @RequestParam("userTel2") String userTel2,
			        @RequestParam("userTel3") String userTel3,
			        @RequestParam("userEmail1") String userEmail1,
			        @RequestParam("userEmail2") String userEmail2,
			        @RequestParam("gradeCode") String gradeCode,RedirectAttributes redirectAttributes) {

			    // UserDTO 객체 생성 및 필드 설정
			    UserDTO dto = new UserDTO();
			    dto.setUserId(userId);
			    dto.setUserName(userName);
			    dto.setUserNickname(userNickname);
			    dto.setUserBirth(userBirth);
			    dto.setUserTel1(userTel1);
			    dto.setUserTel2(userTel2);
			    dto.setUserTel3(userTel3);
			    dto.setUserEmail1(userEmail1);
			    dto.setUserEmail2(userEmail2);
			    dto.setGradeCode(gradeCode);

			    // 사용자 정보 업데이트
			    accountMapper.editUpdateUser(dto);
			    
			 // 수정 완료 메시지 추가
			    redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");

			    // 사용자 관리 페이지로 리다이렉트
			    return "redirect:/admin_usermanage.do";
			}
			

			// 페이징 처리 메서드
			public Map<String, Object> paging(int count, int pageNum) {
				int pageSize = 10; // 한 페이지에 보여질 게시글 수
				int startRow = (pageNum-1) * pageSize + 1; // 페이지별 시작 넘버
				int endRow = startRow + pageSize - 1; // 페이지별 끝 넘버
				if (endRow > count) endRow = count;		
				int no = count-startRow + 1; // 넘버링		
				int pageBlock = 3; //페이지별 보여줄 페이징번호 개수
				int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1); //총 페이징번호 개수		
				int startPage = (pageNum-1)/pageBlock * pageBlock +1; // 페이지별 시작 페이징번호
				int endPage = startPage + pageBlock -1;	// 페이지별 끝 페이징번호
				if(endPage > pageCount) endPage = pageCount;
				
				Map<String, Object> pagingMap = new HashMap<>();
				pagingMap.put("pageSize", pageSize);
				pagingMap.put("no", no);
				pagingMap.put("startRow", startRow);
				pagingMap.put("endRow", endRow);
				pagingMap.put("pageBlock", pageBlock);
				pagingMap.put("pageCount", pageCount);
				pagingMap.put("startPage", startPage);
				pagingMap.put("endPage", endPage);
				
				return pagingMap;
			}
		
		
}


