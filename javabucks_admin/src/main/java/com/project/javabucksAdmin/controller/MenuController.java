package com.project.javabucksAdmin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.javabucksAdmin.dto.MenuDTO;
import com.project.javabucksAdmin.mapper.MenuMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MenuController {
	
	@Autowired
	private MenuMapper menuMapper;
	
	@RequestMapping("/addmenu")
	public String addMenu(HttpServletRequest req) {
		return "/menu/addmenu";
	}
	
	@RequestMapping("/admin_adddrink")
	public String addMenuDrink(HttpServletRequest req) {
	    return "/menu/admin_adddrink";
	}
	
	// 음료등록
	@PostMapping("/insertDrink")
	public String insertDrink(HttpServletRequest req, @ModelAttribute MenuDTO dto, 
			@RequestParam(value = "menuImages", required = false) MultipartFile menuImages) throws IOException {
		
	    if (menuImages != null && !menuImages.isEmpty()) {
	        // 파일명 중복 방지를 위한 UUID 생성
	        UUID uuid = UUID.randomUUID();
	        String fileName = uuid.toString().split("-")[0] + "_" + menuImages.getOriginalFilename();
	        String path = "D:/fintech_hee/final_project/javabucks_admin/src/main/resources/static/images/upload_menuImages";

	        File directory = new File(path);
	        if (!directory.exists()) {
	            directory.mkdirs();
	        }

	        File file = new File(directory, fileName);
	        menuImages.transferTo(file);
	        
	        System.out.println("파일위치: " + file.getAbsolutePath());

	        // DTO에 파일 이름 설정
	        dto.setMenuImages(fileName);
	    }

	    // 나머지 DTO 값 설정
	    dto.setMenuCode(dto.getMenuCode());
	    dto.setMenuName(dto.getMenuName());
	    dto.setMenuPrice(dto.getMenuPrice());
	    dto.setMenuDesc(dto.getMenuDesc());
	    dto.setMenuEnable("Y");
	    dto.setMenuoptCode(dto.getMenuoptCode());

	    // 데이터베이스에 저장
	    int res = menuMapper.insertDrink(dto);
	    
	    return "/menu/admin_drinklist";
	}
	
	// 조건에 해당하는 음료리스트 검색
	@RequestMapping("/admin_drinklist")
	public String getAllDrinks(HttpServletRequest req, @RequestParam Map<String, Object> params, 
	        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
	    
	    // 검색 필터가 null or ""일 경우 기본값 설정
	    String menuCate = (String) params.get("menu_cate");
	    String menuBase = (String) params.get("menu_base");
	    String menuName = (String) params.get("menuName");
	    String menuEnable = (String) params.get("menuEnable");
	    
	    menuCate = (menuCate == null || menuCate.isEmpty()) ? "" : menuCate;
	    menuBase = (menuBase == null || menuBase.isEmpty()) ? "" : menuBase;
	    menuName = (menuName == null || menuName.isEmpty()) ? "" : menuName;
	    menuEnable = (menuEnable == null || menuEnable.isEmpty()) ? "N" : "Y";
	    
	    // 검색 조건을 포함한 매퍼 호출
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("menu_cate", menuCate);
	    searchParams.put("menu_base", menuBase);
	    searchParams.put("menuName", menuName);
	    searchParams.put("menuEnable", menuEnable);
	    
	    int searchCount = menuMapper.searchDrinkCount(searchParams); // 검색결과별 리스트 수
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
	    
	    List<MenuDTO> drinkList;
	    
	    // 검색 조건에 따라 메뉴 리스트 가져오기
	    searchParams.put("startRow", startRow);
	    searchParams.put("endRow", endRow);
	    
	    drinkList = menuMapper.searchDrink(searchParams);
	    
	    if (drinkList.isEmpty()) {
	        // 값이 없을 때
	        req.setAttribute("noList", true);
	    } else {
	        // 값이 있을 때
	        req.setAttribute("drinkList", drinkList);
	        req.setAttribute("searchParams", searchParams);
	        req.setAttribute("searchCount", searchCount);
	        req.setAttribute("pageSize", pageSize);
	        req.setAttribute("startRow", startRow);
	        req.setAttribute("endRow", endRow);
	        req.setAttribute("no", no);
	        req.setAttribute("pageBlock", pageBlock);
	        req.setAttribute("pageCount", pageCount);
	        req.setAttribute("startPage", startPage);
	        req.setAttribute("endPage", endPage);
	    }
	    return "/menu/admin_drinklist";
	}
	
	// 주문막기 버튼 활성화 여부
	@PostMapping("/menuStatusUpdate.ajax")
	@ResponseBody
	public ResponseEntity<String> menuStatusUpdate(@RequestBody MenuDTO dto) {
	    int res = menuMapper.menuStatusUpdate(dto);
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/plain; charset=UTF-8");
	    
	    if (res > 0) {
	        return ResponseEntity.ok().headers(headers).body("주문 막기/풀기 완료");
	    } else {
	        return ResponseEntity.ok().headers(headers).body("주문 막기/풀기 실패");
	    }
	}
	
	// 메뉴 수정
	 @RequestMapping("/admin_editdrink") 
	 public String editDrink(HttpServletRequest req, @ModelAttribute MenuDTO dto) { 
//		 int res = menuMapper.editDrink(dto);
//		 if (res > 0) {
//			 req.setAttribute("msg", "메뉴 수정에 성공하였습니다.");
//		 } else {
//			 req.setAttribute("msg", "메뉴 수정에 실패했습니다.");
//		}
		 return "/menu/admin_editdrink"; 
	 }
	
	@RequestMapping("/admin_delDrink")
	public String delDrink(HttpServletRequest req, @RequestParam String menuCode) {
		
		int res = menuMapper.delDrink(menuCode);
		if(res>0) {
			req.setAttribute("msg", menuCode+ "를 삭제하였습니다.");
		}else {
			req.setAttribute("msg", menuCode + "를 삭제하지 못했습니다.");
		}
		req.setAttribute("url", "/menu/admin_drinklist");
		return "message";
	}


}
