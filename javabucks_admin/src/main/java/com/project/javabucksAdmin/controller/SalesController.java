package com.project.javabucksAdmin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.mapper.SalesMapper;

@Controller
public class SalesController {
	
	@Autowired
	private SalesMapper salesMapper;
	
	//시작
	@RequestMapping("/")
	public String index() {
		return "account/admin_index";
	}
	
	//지점 계정 관리 페이지로 이동 
	@RequestMapping("/storemanage.do")
	public String storemanage(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
		
		int itemsPerPage = 5; // 한 페이지에 보여질 리뷰 수
	    int startIndex = (page - 1) * itemsPerPage; // 시작 인덱스 수정
	    int endIndex = page * itemsPerPage; // 끝 인덱스 수정
	    
	    // 파라미터 설정
	    Map<String, Object> params = new HashMap<>();
	    params.put("startIndex", startIndex);
	    params.put("endIndex", endIndex);
	    System.out.println(startIndex);
	    System.out.println(endIndex);
	    
		List<BucksDTO> list = salesMapper.bucksList(params);
		int totalCount = salesMapper.bucksListCount();
	    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산
	    
		model.addAttribute("bucksList", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("pageCount", pageCount);
		
		return "account/admin_storemanage";
	}
		
	//지점 등록페이지로 이동
	@RequestMapping("/inputstore.do")
	public String inputstore() {
		return "account/admin_addstore";
	}
	
	//랜덤id생성
	@GetMapping("/generateUserId")
    @ResponseBody
    public String generateUserId() {
        return salesMapper.generateUniqueBucksId();
    }
	
	//이메일 중복 확인
	@ResponseBody
	@GetMapping("/checkEmail")
	public String checkEmail(@RequestParam("email1") String email1, @RequestParam("email2") String email2) {
		BucksDTO dto = new BucksDTO();
		dto.setBucksEmail1(email1);
		dto.setBucksEmail2(email2);
		if (salesMapper.checkEmail(dto)) {
			return "ok";
		} else {
			return "nok";
				}
	    }

	//지점 등록
	@RequestMapping(value = "/addStore.do", method = RequestMethod.POST )
	public String addBucks( @RequestParam("bucksId") String bucksId,
            @RequestParam("bucksPasswd") String bucksPasswd,
            @RequestParam("bucksName") String bucksName,
            @RequestParam("bucksOwner") String bucksOwner,
            @RequestParam("postcode") String postcode,
            @RequestParam("location") String location,
            @RequestParam("detailaddress") String detailaddress,
            @RequestParam("bucksTel1") String bucksTel1,
            @RequestParam("bucksTel2") String bucksTel2,
            @RequestParam("bucksTel3") String bucksTel3,
            @RequestParam("bucksEmail1") String bucksEmail1,
            @RequestParam("bucksEmail2") String bucksEmail2) {
       
        BucksDTO dto = new BucksDTO();
        dto.setBucksId(bucksId);
        dto.setBucksPasswd(bucksPasswd);
        dto.setBucksName(bucksName);
        dto.setBucksOwner(bucksOwner);
        dto.setBucksLocation(postcode + " " + location + " " + detailaddress);
        dto.setBucksTel1(bucksTel1);
        dto.setBucksTel2(bucksTel2);
        dto.setBucksTel3(bucksTel3);
        dto.setBucksEmail1(bucksEmail1);
        dto.setBucksEmail2(bucksEmail2);

        
        salesMapper.addBucks(dto);

        return "redirect:/storemanage.do"; // 성공 시 이동할 페이지
    }
	
	//특정 검색 지점 리스트 
	@ResponseBody
	@PostMapping("/searchBucks.do")
	public Map<String, Object> searchBucks(
	        @RequestParam(value = "bucksName", required = false) String bucksName,
	        @RequestParam(value = "bucksId", required = false) String bucksId,
	        @RequestParam(value = "bucksLocation", required = false) String bucksLocation,
	        @RequestParam(value = "startDate", required = false) String startDate,
	        @RequestParam(value = "endDate", required = false) String endDate,
	        @RequestParam(value = "page", defaultValue = "1") int page) {

	    int itemsPerPage = 5; // 한 페이지에 보여줄 항목 수
	    int startIndex = (page - 1) * itemsPerPage + 1;
	    int endIndex = page * itemsPerPage;

	    Map<String, Object> params = new HashMap<>();
	    params.put("bucksName", bucksName);
	    params.put("bucksId", bucksId);
	    params.put("bucksLocation", bucksLocation);
	    params.put("startDate", startDate);
	    params.put("endDate", endDate);
	    params.put("startIndex", startIndex);
	    params.put("endIndex", endIndex);

	    // 검색 결과와 총 카운트 가져오기
	    List<BucksDTO> list = salesMapper.searchBucks(params);
	    int totalCount = salesMapper.searchBucksCount(params);
	    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage);

	    // 결과를 JSON 형태로 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("bucksList", list);
	    response.put("currentPage", page);
	    response.put("pageCount", pageCount);

	    return response;
	}
//	public List<BucksDTO> searchBucks(
//            @RequestParam(value = "bucksName", required = false) String bucksName,
//            @RequestParam(value = "bucksId", required = false) String bucksId,
//            @RequestParam(value = "bucksLocation", required = false) String bucksLocation,
//            @RequestParam(value = "startDate", required = false) String startDate,
//            @RequestParam(value = "endDate", required = false) String endDate,
//            Model model) {
//
//        Map<String, Object> params = new HashMap<>();
//        params.put("bucksName", bucksName);
//        params.put("bucksId", bucksId);
//        params.put("bucksLocation", bucksLocation);
//        params.put("startDate", startDate);
//        params.put("endDate", endDate);
//
//      return salesMapper.searchBucks(params);
//      
//    } 
	
	//지점 상세보기 
	
	@GetMapping("/editbucks.do")
	public String editStore(@RequestParam(value = "id", required = false) String bucksId, Model model) {
		System.out.println(bucksId);
		BucksDTO bucks = salesMapper.editbucks(bucksId);
		model.addAttribute("jbucks", bucks);
		System.out.println(bucks);
		return "account/admin_editstore";
	}
	
	//수정 이메일 중복 확인
		@ResponseBody
		@GetMapping("/editCheckEmail")
		public String editCheckEmail(@RequestParam("email1") String email1, @RequestParam("email2") String email2,  @RequestParam("bucksId") String bucksId) {
			BucksDTO dto = new BucksDTO();
			dto.setBucksEmail1(email1);
			dto.setBucksEmail2(email2);
			dto.setBucksId(bucksId);
			if (salesMapper.editCheckEmail(dto)) {
				return "ok";
			} else {
				return "nok";
					}
		    }
		
		//지점 수정
		@RequestMapping(value = "/editStore.do", method = RequestMethod.POST )
		public String editBucks( @RequestParam("bucksId") String bucksId,
	            @RequestParam("bucksName") String bucksName,
	            @RequestParam("bucksOwner") String bucksOwner,
	            @RequestParam("bucksTel1") String bucksTel1,
	            @RequestParam("bucksTel2") String bucksTel2,
	            @RequestParam("bucksTel3") String bucksTel3,
	            @RequestParam("bucksEmail1") String bucksEmail1,
	            @RequestParam("bucksEmail2") String bucksEmail2) {
	       
	        BucksDTO dto = new BucksDTO();
	        dto.setBucksId(bucksId);
	        dto.setBucksName(bucksName);
	        dto.setBucksOwner(bucksOwner);
	        dto.setBucksTel1(bucksTel1);
	        dto.setBucksTel2(bucksTel2);
	        dto.setBucksTel3(bucksTel3);
	        dto.setBucksEmail1(bucksEmail1);
	        dto.setBucksEmail2(bucksEmail2);

	        
	        salesMapper.editBucks(dto);

	        return "account/admin_storemanage"; // 성공 시 이동할 페이지
	    }
		
		//지점 삭제
		@RequestMapping(value = "/deleteBucks.do", method = RequestMethod.POST)
		public String deleteBucks(@RequestParam("bucksId") String bucksId) {
		    salesMapper.deleteBucks(bucksId);
		    return "redirect:/storemanage.do";  // 삭제 후 리다이렉트할 페이지
		}
		
		//ㄱ
	
}
	
	
	
	

