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
	// 지점에 이미 등록된 메뉴가 있는지 확인
	public StoreMenuDTO getMenuByStore(Map<String, Object> params) {
	    return sqlSession.selectOne("getMenuByStore", params);
	}
	// 지점에 등록된 메뉴 중 이미 주문막기 처리가 됐는지 여부 확인
	public StoreMenuDTO getMenuByStatus(Map<String, Object> params) {
		return sqlSession.selectOne("getMenuByStatus", params);
	}
	// 추가된 메뉴 리스트 불러오기 - 메뉴 추가 후 상태변경, 버튼 유지
	public List<StoreMenuDTO> getSelectedMenu(String bucksId) {
		return sqlSession.selectList("getSelectedMenu", bucksId);
	}
	// 조건에 해당하는 음료 리스트 뽑기
	public List<StoreMenuDTO> searchDrinks(Map<String, Object> params) {
		return sqlSession.selectList("searchDrinks", params);
	}
	// 조건에 해당하는 디저트 리스트 뽑기
	public List<StoreMenuDTO> searchDessert(Map<String, Object> params) {
		return sqlSession.selectList("searchDessert", params);
	}
	// 조건에 해당하는 MD 리스트 뽑기
	public List<StoreMenuDTO> searchMd(Map<String, Object> params) {
		return sqlSession.selectList("searchMd", params);
	}
	// 체크박스 조건에 해당하는 음료 리스트 갯수
	public int searchDrinksCount(Map<String, Object> params) {
		return sqlSession.selectOne("searchDrinksCount", params);
	}
	// 메뉴 키워드 검색 리스트 뽑기
	public List<StoreMenuDTO> searchDrinksList(Map<String, Object> params) {
		return sqlSession.selectList("searchDrinksList", params);
	}
	// 디저트 키워드 검색 리스트 뽑기
	public List<StoreMenuDTO> searchDessertList(Map<String, Object> params) {
		return sqlSession.selectList("searchDessertList", params);
	}
	// MD 키워드 검색 리스트 뽑기
	public List<StoreMenuDTO> searchMdList(Map<String, Object> params) {
		return sqlSession.selectList("searchMdList", params);
	}
	// 주문막기 상태 업데이트
	public int menuStatusUpdate(StoreMenuDTO dto) {
		return sqlSession.update("menuStatusUpdate", dto);
	}
	// 메뉴삭제 - 지점에 추가한 메뉴 삭제
	public int deleteMenu(Map<String, Object> params) {
		return sqlSession.delete("deleteMenu", params);
	}
}
