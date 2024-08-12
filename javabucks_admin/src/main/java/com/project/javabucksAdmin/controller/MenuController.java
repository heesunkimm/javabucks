package com.project.javabucksAdmin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String insertDrink(@ModelAttribute MenuDTO dto, 
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
	
	@RequestMapping("/admin_drinklist")
	public String listDrink(HttpServletRequest req, String menuCode) {
	    return "/menu/admin_drinklist";
	}
	
	@PostMapping("/searchDrink")
	public String searchDrink(HttpServletRequest req, @RequestParam Map<String, Object> params) {
	    List<MenuDTO> drinkList = null;
	    
	    // 검색조건 초기화
	    String menuCate = (String) params.get("menu_cate");
	    String menuBase = (String) params.get("menu_base");
	    String menuName = (String) params.get("menuName");
	    String menuEnable = (String) params.get("menuEnable");
	    
	    // 검색필터가 null or ""일 경우 기본값 설정
	    menuCate = (menuCate == null || menuCate.isEmpty()) ? "" : menuCate;
	    menuBase = (menuBase == null || menuBase.isEmpty()) ? "" : menuBase;
	    menuName = (menuName == null || menuName.isEmpty()) ? "" : menuName;
	    menuEnable = (menuEnable == null || menuEnable.isEmpty()) ? "N" : menuEnable;
	    
	    // 검색 조건을 포함한 매퍼 호출
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("menu_cate", menuCate);
	    searchParams.put("menu_base", menuBase);
	    searchParams.put("menuName", menuName);
	    searchParams.put("menuEnable", menuEnable);
	    
	    drinkList = menuMapper.searchDrink(searchParams);
	    
	    if (drinkList.isEmpty()) {
	    	req.setAttribute("noList", true);
        } else {
    	    req.setAttribute("drinkList", drinkList);
    	    req.setAttribute("searchParams", searchParams);
        }
	    
	    return "/menu/admin_drinklist";
	}

}
