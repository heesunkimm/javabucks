package com.project.javabucksAdmin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.MenuDTO;

@Service
public class MenuMapper {
	
	@Autowired
	private SqlSession sqlSession;
    
	// 등록 - 음료등록
	public int insertDrink(MenuDTO dto) { 
		return sqlSession.insert("insertDrink", dto);
	}
	// 음료리스트
//	public List<MenuDTO> listDrink(String menuCode) {
//		return sqlSession.selectList("listDrink");
//	}
	// 검색 - 음료리스트
	public List<MenuDTO> searchDrink(Map<String, Object> params) {
		return sqlSession.selectList("searchDrink", params);
	}
  
	 
}
