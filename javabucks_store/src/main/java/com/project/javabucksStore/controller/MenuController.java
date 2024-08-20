package com.project.javabucksStore.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksStore.dto.MenuDTO;
import com.project.javabucksStore.dto.StoreMenuDTO;
import com.project.javabucksStore.mapper.MenuMapper;

@Controller
public class MenuController {
	
	@Autowired
	MenuMapper menuMapper;
	
	@GetMapping("/store_adddrink")
	public String addDrink() {
		return "/menu/store_adddrink";
	}
	
	// 메뉴추가 - 선택된 메뉴 리스트 필터링
	@PostMapping("/getSelectMenu.ajax")
	@ResponseBody
	public List<MenuDTO> getSelectmenu(@RequestBody Map<String, String> params) {
	    String selectedOpt = params.get("menuoptCode");
	    //System.out.println("메뉴옵션코드: " + selectedOpt);

	    List<MenuDTO> selectedList = menuMapper.getSelectMenu(selectedOpt);
	    //System.out.println("리스트: " + selectedList);

	    return selectedList;
	}
	
	// 어드민에서 등록된 메뉴 지점 메뉴로 추가
	@PostMapping("/addMenu.ajax")
	@ResponseBody
	public String addMenu(@ModelAttribute StoreMenuDTO dto) {
		int res = menuMapper.addMenu(dto);
		System.out.println(res);
		
		if(res>0) {
			return "메뉴추가 성공";
		}else {
			return "메뉴추가 실패";
		}
	}
	
	@GetMapping("/store_alldrink")
	public String getAllDrink() {
		return "/menu/store_alldrink";
	}

}
