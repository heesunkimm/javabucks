package com.project.javabucksStore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksStore.dto.MenuDTO;
import com.project.javabucksStore.dto.StoreMenuDTO;

@Service
public class MenuMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 메뉴추가 - 선택된 메뉴 리스트 필터링
	public List<MenuDTO> getSelectMenu(String menuoptCode) {
		return sqlSession.selectList("getSelectMenu", menuoptCode);
	}
	// 어드민에서 등록된 메뉴 지점 메뉴로 추가
	public int addMenu(StoreMenuDTO dto) {
		return sqlSession.insert("addMenu",dto);
	}
	// 추가된 메뉴 리스트 불러오기 - 메뉴 추가 후 상태변경, 버튼 유지
	public List<StoreMenuDTO> getSelectedMenu(String bucksId) {
		return sqlSession.selectList("getSelectedMenu", bucksId);
	}
	// 조건에 해당하는 음료 리스트 뽑기
	public List<StoreMenuDTO> searchDrinks(Map<String, Object> params) {
		return sqlSession.selectList("searchDrinks", params);
	}
//	// 조건에 해당하는 음료 리스트 갯수
	public int searchDrinksCount(Map<String, Object> params) {
		return sqlSession.selectOne("searchDrinksCount", params);
	}

}
