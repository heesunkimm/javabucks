package com.project.javabucksStore.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
		
		Map<String, Object> params = new HashMap<>();
		params.put("menuCode", dto.getMenuCode());
	    params.put("bucksId", dto.getBucksId());
		
		// 지점에 이미 등록된 메뉴가 있는지 확인
		StoreMenuDTO menuCheck = menuMapper.getMenuByStore(params);
		
		if(menuCheck != null) {
			return "이미 추가된 메뉴입니다.";
		}
		
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
	
	private static final List<String> various_bases = Arrays.asList("D", "E", "F", "J", "L", "P");
	
	@PostMapping("/searchDrinks.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchDrinks(HttpServletRequest req, @RequestBody Map<String, Object> params,
	        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
		
		
		String bucksId = (String) params.get("bucksId");
	    String menuCate = (String) params.get("menu_cate");
	    String menuBase = (String) params.get("menu_base");
	    
	    // menuBase가 SPECIAL_MENU_BASES에 포함되어 있으면 'F'로 변경
        if (menuBase != null && various_bases.contains(menuBase)) {
            menuBase = "F";
        }
	    
	    menuCate = (menuCate == null || menuCate.isEmpty()) ? "" : menuCate;
	    menuBase = (menuBase == null || menuBase.isEmpty()) ? "" : menuBase;

		Map<String, Object> searchParams = new HashMap<>();
		searchParams.put("bucksId", bucksId);
		searchParams.put("menuCate", menuCate);
		searchParams.put("menuBase", menuBase);
		
		int searchCount = menuMapper.searchDrinksCount(searchParams); // 검색결과별 리스트 수
	    int pageSize = 10; // 한 페이지의 보여줄 리스트 갯수
	    int startRow = (pageNum - 1) * pageSize + 1;
	    int endRow = startRow + pageSize - 1;	
	    if (endRow > searchCount) endRow = searchCount;		
	    int no = searchCount - startRow + 1;				
	    int pageBlock = 3;
	    int pageCount = searchCount / pageSize + (searchCount % pageSize == 0 ? 0 : 1);		
	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1;		
	    int endPage = startPage + pageBlock - 1;
	    if (endPage > pageCount) endPage = pageCount;
	    
	    List<StoreMenuDTO> drinkList;
	    
	    // 검색 조건에 따라 메뉴 리스트 가져오기
	    searchParams.put("startRow", startRow);
	    searchParams.put("endRow", endRow);
	    
	    drinkList = menuMapper.searchDrinks(searchParams);
	    
	    req.setAttribute("searchCount", searchCount);
	    req.setAttribute("drinkList", drinkList);
	    req.setAttribute("pageSize", pageSize);
	    req.setAttribute("startRow", startRow);
	    req.setAttribute("endRow", endRow);
	    req.setAttribute("no", no);
	    req.setAttribute("pageBlock", pageBlock);
	    req.setAttribute("pageCount", pageCount);
	    req.setAttribute("startPage", startPage);
	    req.setAttribute("endPage", endPage);
	    
	    return drinkList;
	}
	
	// 메뉴 키워드 검색 리스트 뽑기
	@PostMapping("/searchDrinksList.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchDrinksList(HttpServletRequest req, @RequestBody Map<String, Object> params) {

	    String bucksId = (String) params.get("bucksId");
	    String searchCont = (String) params.get("menuName");

	    searchCont = (searchCont == null || searchCont.isEmpty()) ? "" : searchCont;
	    
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("bucksId", bucksId);
	    searchParams.put("searchCont", searchCont);
	    
	    List<StoreMenuDTO> filterList = menuMapper.searchDrinksList(searchParams);
	    
	    return filterList;
	}

}
