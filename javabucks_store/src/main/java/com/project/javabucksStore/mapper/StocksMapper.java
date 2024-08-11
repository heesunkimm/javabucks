package com.project.javabucksStore.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksStore.dto.StoreStocksDTO;

@Service
public class StocksMapper {
	
	 @Autowired
	 private SqlSession sqlSession;
	 
	 
	 // s: 지점 재고현황 조회
	 // 음료
	 public List<StoreStocksDTO> bevStocksList(Map<String, Object> params){ 
		List<StoreStocksDTO> list = sqlSession.selectList("bevStocksList", params);
		return list;
	 }	
	
	 public int bevCount() {
		 int bevCount = sqlSession.selectOne("bevCount");
		 return bevCount;
	 }
	 
	 // 음식
	 public List<StoreStocksDTO> fooStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("fooStocksList", params);
		return list;
	 }

	 public int fooCount() {
		 int fooCount = sqlSession.selectOne("fooCount");
		 return fooCount;
	 }
	 
	 
	 // 컵
	 public List<StoreStocksDTO> cupStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("cupStocksList", params);
		return list;
	 }

	 public int cupCount() {
		 int cupCount = sqlSession.selectOne("cupCount");
		 return cupCount;
	 }
	 
	 // 시럽
	 public List<StoreStocksDTO> syrStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("syrStocksList", params);
		return list;
	 }

	 public int syrCount() {
		 int syrCount = sqlSession.selectOne("syrCount");
		 return syrCount;
	 }
	 
	 // 휘핑크림
	 public List<StoreStocksDTO> whiStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("whiStocksList", params);
		return list;
	 }

	 public int whiCount() {
		 int whiCount = sqlSession.selectOne("whiCount");
		 return whiCount;
	 }
	 
	 // 우유
	 public List<StoreStocksDTO> milStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("milStocksList", params);
		return list;
	 }

	 public int milCount() {
		 int milCount = sqlSession.selectOne("milCount");
		 return milCount;
	 }
	 
	 // 텀블러
	 public List<StoreStocksDTO> tumStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("tumStocksList", params);
		return list;
	 }

	 public int tumCount() {
		 int tumCount = sqlSession.selectOne("tumCount");
		 return tumCount;
	 }
	 
	 // 원두
	 public List<StoreStocksDTO> wonStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("wonStocksList", params);
		return list;
	 }

	 public int wonCount() {
		 int wonCount = sqlSession.selectOne("wonCount");
		 return wonCount;
	 }
	// e: 지점 재고현황 조회
	 
	// s: 재고 장바구니
	 public int addStocksCart(String stockListCode, int quantity) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("stockListCode", stockListCode);
		 params.put("quantity", quantity);
		 int addCartResult = sqlSession.insert("addStocksCart", params);
		 return addCartResult;
	 }
	// e: 재고 장바구니
	 
	 
}
