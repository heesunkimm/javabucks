package com.project.javabucksStore.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksStore.dto.MenuDTO;
import com.project.javabucksStore.dto.StoreMenuDTO;
import com.project.javabucksStore.mapper.MenuMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MenuController {
	
	@Autowired
	MenuMapper menuMapper;
	
	@GetMapping("/store_adddrink")
	public String addDrink() {
		return "/menu/store_adddrink";
	}
	
	@GetMapping("/store_adddessert")
	public String addDessert() {
		return "/menu/store_adddessert";
	}
	
	@GetMapping("/store_addmd")
	public String addMd() {
		return "/menu/store_addmd";
	}
	
	// 메뉴추가 - 선택된 메뉴 리스트 필터링
	@PostMapping("/getSelectMenu.ajax")
	@ResponseBody
	public List<MenuDTO> getSelectmenu(@RequestBody Map<String, String> params) {
	    String selectedOpt = params.get("menuoptCode");

	    List<MenuDTO> selectedList = menuMapper.getSelectMenu(selectedOpt);

	    return selectedList;
	}
	
	// 어드민에서 등록된 메뉴 지점 메뉴로 추가
	@PostMapping("/addMenu.ajax")
	@ResponseBody
	public String addMenu(@RequestBody StoreMenuDTO dto) {
		int res = menuMapper.addMenu(dto);
		
		if(res>0) {
			return "가 메뉴에 추가되었습니다.";
		}else {
			return "메뉴추가에 실패하였습니다.";
		}
	}
	// 추가된 메뉴 리스트 불러오기 - 메뉴 추가 후 상태변경, 버튼 유지
	@GetMapping("/getSelectedMenu.ajax")
	@ResponseBody
	public List<StoreMenuDTO> getSelectedMenu(@RequestParam("bucksId") String bucksId) {
	    return menuMapper.getSelectedMenu(bucksId);
	}

	@GetMapping("/store_alldrink")
	public String getAllDrink() {		
		return "/menu/store_alldrink";
	}
	
	@GetMapping("/store_alldessert")
	public String getAllDessert() {		
		return "/menu/store_alldessert";
	}
	
	@GetMapping("/store_allmd")
	public String getAllMd() {
		return "/menu/store_allmd";
	}
	
//	@PostMapping("/searchDrinks.ajax")
//	@ResponseBody
//	public Map<String, Object> searchDrinks(HttpServletRequest req, @RequestParam Map<String, Object> params, 
//	        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
//		
//		// 검색 필터가 null or ""일 경우 기본값 설정
//	    String menuCate = (String) params.get("menu_cate");
//	    String menuBase = (String) params.get("menu_base");
//	    String menuName = (String) params.get("menuName");
//	    
//	    menuCate = (menuCate == null || menuCate.isEmpty()) ? "" : menuCate;
//	    menuBase = (menuBase == null || menuBase.isEmpty()) ? "" : menuBase;
//	    menuName = (menuName == null || menuName.isEmpty()) ? "" : menuName;
//	    
//	    // 검색 조건을 포함한 매퍼 호출
//	    Map<String, Object> searchParams = new HashMap<>();
//	    searchParams.put("menuCate", menuCate);
//	    searchParams.put("menu_base", menuBase);
//	    searchParams.put("menuName", menuName);
//	    
//		int searchCount = menuMapper.searchDrinksCount(searchParams);
//	    int pageSize = 10;
//	    int startRow = (pageNum - 1) * pageSize + 1;
//	    int endRow = startRow + pageSize - 1;	
//	    if (endRow > searchCount) endRow = searchCount;		
//	    int no = searchCount - startRow + 1;				
//	    int pageBlock = 3;
//	    int pageCount = searchCount / pageSize + (searchCount % pageSize == 0 ? 0 : 1);		
//	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1;		
//	    int endPage = startPage + pageBlock - 1;
//	    if (endPage > pageCount) endPage = pageCount;
//	    
//	    // 검색 조건에 따라 메뉴 리스트 가져오기
//	    searchParams.put("startRow", startRow);
//	    searchParams.put("endRow", endRow);
//	    
//    	List<StoreMenuDTO> drinkList = menuMapper.searchDrinks(searchParams);
//	    Map<String, Object> allList = new HashMap<>();
//	    
//	    if (drinkList.isEmpty()) {
//	        // 값이 없을 때
//	    	allList.put("noList", true);
//	    } else {
//	        // 값이 있을 때
//	    	allList.put("drinkList", drinkList);
//	    	allList.put("searchParams", searchParams);
//	    	allList.put("searchCount", searchCount);
//	    	allList.put("pageSize", pageSize);
//	    	allList.put("startRow", startRow);
//	    	allList.put("endRow", endRow);
//	    	allList.put("no", no);
//	    	allList.put("pageBlock", pageBlock);
//	    	allList.put("pageCount", pageCount);
//	    	allList.put("startPage", startPage);
//	    	allList.put("endPage", endPage);
//	    }
//	    
//	    return allList;
//	}
}
