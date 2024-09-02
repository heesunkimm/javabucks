package com.project.javabucksAdmin.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.BaljooDTO;
import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.dto.StockListDTO;

@Service
public class OrderMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 어드민 재고관리 조회
	public List<StockListDTO> adminStockList(Map<String, Object> params){
		List<StockListDTO> list = sqlSession.selectList("getAdminStockList", params);
		return list;
	}
	
	// 검색 어드민 재고관리 조회 ALL
	public List<StockListDTO> findAdminStockListAll(Map<String, Object> params){
		List<StockListDTO> list = sqlSession.selectList("findAdminStockListAll", params);
		return list;
	}
	
	// 검색 어드민 재고관리 조회 ALL 외
	public List<StockListDTO> findAdminStockList(Map<String, Object> params){
		List<StockListDTO> list = sqlSession.selectList("findAdminStockList", params);
		return list;
	}
	
	// 어드민 재고관리 리스트 개수
	public int adminStockListCount() {
		return sqlSession.selectOne("adminStockListCount");
	}
	
	// 검색 어드민 재고관리 리스트 개수 ALL
	public int searchAdminStockListCountAll(String searchStockListName) {
		Map<String, Object> params = new HashMap<>();
		params.put("searchStockListName", searchStockListName);	
		return sqlSession.selectOne("searchAdminStockListCountAll", params);
	}
	
	// 검색 어드민 재고관리 리스트 개수 ALL 외
	public int searchAdminStockListCount(String searchCate, String searchStockListName) {
		Map<String, Object> params = new HashMap<>();
		params.put("searchCate", searchCate);
		params.put("searchStockListName", searchStockListName);	
		return sqlSession.selectOne("searchAdminStockListCount", params);
	}	
	
	// 재고 확충
	public int stockPlus(Map<String, Object> params) {
		return sqlSession.update("stockPlus", params);
	}
	
	// 업데이트된 재고 수량
	public int stockCountUpdated(Map<String, Object> params) {
		return sqlSession.selectOne("stockCountUpdated", params);
	}
	
	// 발주막기
	public int stockStatusUpdateN(String stockListCode) {
		return sqlSession.update("stockStatusUpdateN", stockListCode);
	}
	
	// 발주풀기
	public int stockStatusUpdateY(String stockListCode) {
		return sqlSession.update("stockStatusUpdateY", stockListCode);
	}
	
	// 발주 리스트
	public List<BaljooDTO> baljooList(Map<String, Object> params){
		List<BaljooDTO> list = sqlSession.selectList("baljooList", params);
		return list;
	}
	
	// 발주 리스트 개수
	public int baljooCount(Map<String, Object> params) {
		return sqlSession.selectOne("baljooCount", params);
	}
	
	// 품목명 조회
	public String getStcokName(String stockListCode) {
		return sqlSession.selectOne("getStockName", stockListCode);
	}
	
	// 지점 리스트 조회
	public List<BucksDTO> getStoreName(){
		return sqlSession.selectList("getStoreName");
	}
	
	// 검색 발주 리스트 개수
	public int searchBaljooCount(Map<String, Object> params) {
		return sqlSession.selectOne("searchBaljooCount", params);
	}
	
	// 검색 발주 리스트 조회
	public List<BaljooDTO> searchBaljooList(Map<String, Object> params){
		List<BaljooDTO> list = sqlSession.selectList("searchBaljooList", params);
		return list;
	}
	
	// 발주 상태 업데이트 '접수완료'
	public int baljooStatusUpdateOk(int baljooNum) {
		return sqlSession.update("baljooStatusUpdateOk", baljooNum);
	}

	
	// 발주번호로 발주리스트 조회
	public List<BaljooDTO> storeOrderBaljooList(int baljooNum){
		List<BaljooDTO> list = sqlSession.selectList("storeOrderBaljooList", baljooNum);
		return list;
	}
	
	// 재고코드로 어드민 재고 개수 확인
	public int getAdminStocksCount(String stockListCode) {
		return sqlSession.selectOne("getAdminStocksCount", stockListCode);
	}
	
	// 재고 차감
	public int updateCountMinus(Map<String, Object> params) {
		return sqlSession.update("updateCountMinus", params);
	}
	
	// 발주지점 가져오기
	public String getBucksId(int baljooNum) {
		return sqlSession.selectOne("getBucksId", baljooNum);
	}
	
	// 스토어 재고 업데이트
	public int storeStocksUpdate(Map<String, Object> params) {
		return sqlSession.update("storeStocksUpdate", params);
	}

}
