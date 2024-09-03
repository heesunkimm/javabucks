package com.project.javabucksAdmin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.MenuDTO;
import com.project.javabucksAdmin.dto.OrderDTO;

@Service
public class MenuMapper {
	
	@Autowired
	private SqlSession sqlSession;
    
	// 메뉴 등록
	public int insertMenu(MenuDTO dto) { 
		return sqlSession.insert("insertMenu", dto);
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
	// 조건에 해당하는 디저트 리스트 검색
	public List<MenuDTO> searchDessert(Map<String, Object> params) {
		return sqlSession.selectList("searchDessert", params);
	}
	//조건에 해당하는 디저트 리스트 갯수 구하기
	public int searchDessertCount(Map<String, Object> params) {
		return sqlSession.selectOne("searchDessertCount", params);
	}
	// 조건에 해당하는 MD 리스트 검색
	public List<MenuDTO> searchMd(Map<String, Object> params) {
		return sqlSession.selectList("searchMd", params);
	}
	//조건에 해당하는 MD리스트 갯수 구하기
	public int searchMdCount(Map<String, Object> params) {
		return sqlSession.selectOne("searchMdCount", params);
	}
	// 메뉴 수정
	public int editMenu(MenuDTO dto) {
		return sqlSession.update("editMenu", dto);
	}
	// 주문들어온 메뉴가 있는지 여부 확인
	public List<OrderDTO> OrderCheck(Map<String, Object> params) {
		return sqlSession.selectList("OrderCheck", params);
	}
	// 메뉴 삭제 (상태업데이트)
	public int delMenu(String menuCode) {
		return sqlSession.update("delMenu", menuCode);
	}
	// 메뉴 상세 페이지
	public MenuDTO getEditMenu(String menuCode) {
		return sqlSession.selectOne("getEditMenu", menuCode);
	}
	// 메뉴 막기/풀기 상태 업데이트
	public int menuStatusUpdate(MenuDTO dto) {
		return sqlSession.update("menuStatusUpdate", dto);
	}
}
