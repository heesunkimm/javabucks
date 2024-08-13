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
    
	// 음료등록
	public int insertDrink(MenuDTO dto) { 
		return sqlSession.insert("insertDrink", dto);
	}
	// 조건에 해당하는 음료 리스트 검색
	public List<MenuDTO> searchDrink(Map<String, Object> params) {
		return sqlSession.selectList("searchDrink", params);
	}
	//조건에 해당하는 음료 리스트 갯수 구하기
	public int searchDrinkCount(Map<String, Object> params) {
		int res = sqlSession.selectOne("searchDrinkCount", params);
		return  res;
	}
	// 메뉴 수정
//	public int editDrink(MenuDTO dto) {
//		return sqlSession.update("editDrink", dto);
//	}
	public int delDrink(String menuCode) {
		return sqlSession.delete("delDrink", menuCode);
	}
	// 메뉴 상태 업데이트
	public int menuStatusUpdate(MenuDTO dto) {
		return sqlSession.update("menuStatusUpdate", dto);
	}
}
