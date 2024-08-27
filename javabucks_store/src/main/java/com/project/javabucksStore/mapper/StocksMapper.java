package com.project.javabucksStore.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksStore.dto.StockCartDTO;
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
	
	 public int bevCount(String bucksId) {
		 int bevCount = sqlSession.selectOne("bevCount", bucksId);
		 return bevCount;
	 }
	 
	 // 음식
	 public List<StoreStocksDTO> fooStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("fooStocksList", params);
		return list;
	 }

	 public int fooCount(String bucksId) {
		 int fooCount = sqlSession.selectOne("fooCount", bucksId);
		 return fooCount;
	 }
	 
	 
	 // 컵
	 public List<StoreStocksDTO> cupStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("cupStocksList", params);
		return list;
	 }

	 public int cupCount(String bucksId) {
		 int cupCount = sqlSession.selectOne("cupCount", bucksId);
		 return cupCount;
	 }
	 
	 // 시럽
	 public List<StoreStocksDTO> syrStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("syrStocksList", params);
		return list;
	 }

	 public int syrCount(String bucksId) {
		 int syrCount = sqlSession.selectOne("syrCount", bucksId);
		 return syrCount;
	 }
	 
	 // 휘핑크림
	 public List<StoreStocksDTO> whiStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("whiStocksList", params);
		return list;
	 }

	 public int whiCount(String bucksId) {
		 int whiCount = sqlSession.selectOne("whiCount", bucksId);
		 return whiCount;
	 }
	 
	 // 우유
	 public List<StoreStocksDTO> milStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("milStocksList", params);
		return list;
	 }

	 public int milCount(String bucksId) {
		 int milCount = sqlSession.selectOne("milCount", bucksId);
		 return milCount;
	 }
	 
	 // 텀블러
	 public List<StoreStocksDTO> tumStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("tumStocksList", params);
		return list;
	 }

	 public int tumCount(String bucksId) {
		 int tumCount = sqlSession.selectOne("tumCount", bucksId);
		 return tumCount;
	 }
	 
	 // 원두
	 public List<StoreStocksDTO> wonStocksList(Map<String, Object> params){
		 List<StoreStocksDTO> list = sqlSession.selectList("wonStocksList", params);
		return list;
	 }

	 public int wonCount(String bucksId) {
		 int wonCount = sqlSession.selectOne("wonCount", bucksId);
		 return wonCount;
	 }
	 // e: 지점 재고현황 조회
	 
	
	 // s: 재고 장바구니 추가
	 public int addStocksCart(String stockListCode, int quantity, String bucksId) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("stockListCode", stockListCode);
		 params.put("quantity", quantity);
		 params.put("bucksId", bucksId);

		 int addCartResult = sqlSession.insert("addStocksCart", params);
		 return addCartResult;
	 }
	 // e: 재고 장바구니 추가
	 
	 
	 // s: 재고 장바구니 조회
	 public List<StockCartDTO> stockCartList(String bucksId){
		 List<StockCartDTO> list = sqlSession.selectList("stockCartList", bucksId);
		 return list;
	 }	 
	 // e: 재고 장바구니 조회
	 
	 // s: 장바구니 수량 추가
	 public int updateCartQuantity(String stockListCode, int quantity, String bucksId) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("stockListCode", stockListCode);
		 params.put("quantity", quantity);
		 params.put("bucksId", bucksId);
		 int updateResult = sqlSession.update("updateCartQuantity", params);		 
		 return updateResult;
	 }
	 // e: 장바구니 수량 추가
	 
	 // s: 재고 장바구니 수량 변경
	 public int updateQuantity(String stockListCode, int quantity, String bucksId) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("stockListCode", stockListCode);
		 params.put("quantity", quantity);		
		 params.put("bucksId", bucksId);
		 int updateResult = sqlSession.update("updateQuantity", params);		 
		 return updateResult;
	 }
	 // e: 재고 장바구니 수량 변경
	
		 
	 // s: 재고 장바구니 삭제
	 public int deleteCart(String stockListCode, String bucksId) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("stockListCode", stockListCode);
		 params.put("bucksId", bucksId);		 
		 int deleteResult = sqlSession.delete("deleteCart", params);		 
		 return deleteResult;
	 }
	 // e: 재고 장바구니 삭제
	 
	 
	 // s : 재고 장바구니 주문
	 public int addStoreOrder(String bucksId, String baljooList, int baljooPrice) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("bucksId", bucksId);
		 params.put("baljooList", baljooList);
		 params.put("baljooPrice", baljooPrice);
		 
		 int insertResult = sqlSession.insert("addStoreOrder", params);
		 return insertResult;
	 }
	 // e : 재고 장바구니 주문
	 
	 // s: 장바구니 상태 업데이트
	 public int updateCartStatus(String bucksId, int stockCartNum) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("bucksId", bucksId);
		 params.put("stockCartNum", stockCartNum);
		 
		 int updateResult = sqlSession.update("updateCartStatus", params);
		 return updateResult;
	 }
	 // e: 장바구니 상태 업데이트
}
