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

@Controller
public class AccountController {

		@Autowired
		private AccountMapper accountMapper;
	
		
		@GetMapping("/admin_adminmanage.do")
		public String adminList(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
			
			int itemsPerPage = 5; // 한 페이지에 보여질 리뷰 수
		    int startIndex = (page - 1) * itemsPerPage; // 시작 인덱스 수정
		    int endIndex = page * itemsPerPage; // 끝 인덱스 수정
			
		 // 파라미터 설정
		    Map<String, Object> params = new HashMap<>();
		    params.put("startIndex", startIndex);
		    params.put("endIndex", endIndex);
		    
		    List<AdminDTO> list = accountMapper.adminList(params);
		   // System.out.println(list);
			int totalCount = accountMapper.adminListCount();
		    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산
		    
			model.addAttribute("adminList", list);
			model.addAttribute("currentPage", page);
			model.addAttribute("pageCount", pageCount);
			
			return "account/admin_adminmanage";
		} 
		
		//관리자 검색
		@ResponseBody
		@PostMapping("/searchAdmin.do")
		public Map<String, Object> searchAdminList(
				@RequestParam(value = "startDate", required = false) String startDate, 
				@RequestParam(value = "endDate", required = false) String endDate,   
				@RequestParam(value = "enable", required = false) String enable,    
				@RequestParam(value = "userId", required = false) String adminId,   
				@RequestParam(value = "adminEmail1", required = false) String adminEmail1, 
				@RequestParam(value = "adminEmail2", required = false) String adminEmail2, 
				@RequestParam(value = "authority", required = false) String authority, 
	            @RequestParam(value = "page", defaultValue = "1") int page,       
	            @RequestParam(value = "itemsPerPage", defaultValue = "5") int itemsPerPage ) {
			
		    int startIndex = (page - 1) * itemsPerPage + 1;
		    int endIndex = page * itemsPerPage;
		    
		    String adminEmail = "";
		    if (adminEmail1 != null && !adminEmail1.isEmpty() && adminEmail2 != null && !adminEmail2.isEmpty()) {
		        adminEmail = adminEmail1 + adminEmail2; 
		    }

		    Map<String, Object> params = new HashMap<>();
		    params.put("startDate", startDate != null ? startDate : ""); 
		    params.put("endDate", endDate != null ? endDate : "");       
		    params.put("enable", enable != null ? enable : "");          
		    params.put("adminId", adminId != null ? adminId : "");       
		    params.put("adminEmail", adminEmail);                        
		    params.put("authority", authority != null ? authority : ""); 
		    params.put("startIndex", startIndex); 
		    params.put("endIndex", endIndex);     
		    
		    List<AdminDTO> list = accountMapper.searchAdminList(params); 
		    int totalCount = accountMapper.searchAdminCount(params); 
		    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage); 

		    // 결과를 JSON 형태로 반환
		    Map<String, Object> response = new HashMap<>();
		    response.put("adminList", list);
		    response.put("currentPage", page);
		    response.put("pageCount", pageCount);
		   // System.out.println("response : "+response);

		    return response;
		}

		 @GetMapping("/deleteAdmin.do")
		    public String deleteAdmin(@RequestParam("adminId") String adminId, RedirectAttributes redirectAttributes) {
		        try {
		            // 관리자 계정 삭제 로직 호출
		        	accountMapper.deleteAdminById(adminId);
		            redirectAttributes.addFlashAttribute("message", "계정이 성공적으로 삭제되었습니다.");
		        } catch (Exception e) {
		            redirectAttributes.addFlashAttribute("errorMessage", "계정 삭제 중 오류가 발생했습니다.");
		        }
		        // 관리 계정 리스트 페이지로 리다이렉트
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
				if (accountMapper.editCheckAdminEmail(dto)) {
					return "ok";
				} else {
					return "nok";
						}
			    }
			
			//수정 업데이트
			@RequestMapping(value = "/editUpdateAdmin.do", method = RequestMethod.POST )
			public String editUpdateAdmin( @RequestParam("adminId") String adminId,
					//@RequestParam("adminPasswd") String adminPasswd,
		            @RequestParam("adminEmail1") String adminEmail1,
		            @RequestParam("adminEmail2") String adminEmail2) {
		       
		        AdminDTO dto = new AdminDTO();
		        dto.setAdminId(adminId);
		       // dto.setAdminPasswd(adminPasswd);
		        dto.setAdminEmail(adminEmail1 + "@" + adminEmail2);

		        
		        accountMapper.editUpdateAdmin(dto);

		        return "redirect:/admin_adminmanage.do";
		    }
			
////////////////////유저계정
			
			@GetMapping("/admin_usermanage.do")
			public String userList(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
				
				int itemsPerPage = 5; // 한 페이지에 보여질 리뷰 수
			    int startIndex = (page - 1) * itemsPerPage; // 시작 인덱스 수정
			    int endIndex = page * itemsPerPage; // 끝 인덱스 수정
				
			 // 파라미터 설정
			    Map<String, Object> params = new HashMap<>();
			    params.put("startIndex", startIndex);
			    params.put("endIndex", endIndex);
			    
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
			    
				int totalCount = accountMapper.userListCount();
			    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산
			    
				model.addAttribute("userList", list);
				model.addAttribute("currentPage", page);
				model.addAttribute("pageCount", pageCount);
				
				return "account/admin_usermanage";
			} 
			
			
			//유저 검색
			@ResponseBody
			@PostMapping("/searchUser.do")
			public Map<String, Object> searchUserList(
					@RequestParam(value = "startDate", required = false) String startDate, 
					@RequestParam(value = "endDate", required = false) String endDate,   
					@RequestParam(value = "enable", required = false) String enable,    
					@RequestParam(value = "UserId", required = false) String UserId,   
					@RequestParam(value = "userNickname", required = false) String userNickname, 
					@RequestParam(value = "gradeCode", required = false) String gradeCode, 
		            @RequestParam(value = "page", defaultValue = "1") int page,       
		            @RequestParam(value = "itemsPerPage", defaultValue = "5") int itemsPerPage ) {
				
			    int startIndex = (page - 1) * itemsPerPage + 1;
			    int endIndex = page * itemsPerPage;
			    
			    

			    Map<String, Object> params = new HashMap<>();
			    params.put("startDate", startDate != null ? startDate : ""); 
			    params.put("endDate", endDate != null ? endDate : "");       
			    params.put("enable", enable != null ? enable : "");          
			    params.put("UserId", UserId != null ? UserId : "");       
			    params.put("userNickname", userNickname);                        
			    params.put("gradeCode", gradeCode); 
			    params.put("startIndex", startIndex); 
			    params.put("endIndex", endIndex);     
			    
			    List<UserDTO> list = accountMapper.searchUserList(params); 
			    int totalCount = accountMapper.searchUserCount(params); 
			    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage); 

			    // 결과를 JSON 형태로 반환
			    Map<String, Object> response = new HashMap<>();
			    response.put("userList", list);
			    response.put("currentPage", page);
			    response.put("pageCount", pageCount);
			   // System.out.println("response : "+response);

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
			

		
		
}


