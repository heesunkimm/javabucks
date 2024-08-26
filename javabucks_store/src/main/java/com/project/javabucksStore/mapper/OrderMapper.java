package com.project.javabucksStore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.javabucksStore.dto.OrderDTO;
import com.project.javabucksStore.dto.OrderOptDTO;
import com.project.javabucksStore.dto.StockUseDTO;

@Repository
public class OrderMapper {

	@Autowired
	private SqlSession sqlSession;
	
	// 매장 주문내역 조회
	public List<OrderDTO> orderInfo(Map<String, Object> params){
		List<OrderDTO> list = sqlSession.selectList("orderInfo", params);
		return list;
	}
	
	// 주문정보 검색
	public List<OrderDTO> searchOrderInfo(Map<String, Object> params){
		List<OrderDTO> list = sqlSession.selectList("searchOrderInfo", params);
		return list;
	}
	
	// 배달주문정보 조회 
	public List<OrderDTO> deliversOrderInfo(Map<String, Object> params){
		List<OrderDTO> list = sqlSession.selectList("deliversOrderInfo", params);
		return list;
	}
	
	// 배달주문정보 검색
	public List<OrderDTO> searchDeliversOrderInfo(Map<String, Object> params){
		List<OrderDTO> list = sqlSession.selectList("searchDeliversOrderInfo", params);
		return list;
	}
	
	public String getMenuName(String menuCode) {
		String menuName = sqlSession.selectOne("getMenuName", menuCode);
		return menuName;
	}
	
	public List<OrderOptDTO> getMenuOpt(String optId) {
		List<OrderOptDTO> list = sqlSession.selectList("getMenuOpt",optId);
		return list;
	}
	
	public String getCupType(int cupNum) {
		String cupType = sqlSession.selectOne("getCupType", cupNum);
		return cupType;
	}
	
	public Integer getCupPrice(int cupNum) {
        return sqlSession.selectOne("getCupPrice", cupNum);
    }
	
	public String getShotType(int shotNum) {
		String shotType = sqlSession.selectOne("getShotType", shotNum);
		return shotType;
	}
	
	public Integer getShotPrice(int shotNum) {
        return sqlSession.selectOne("getShotPrice", shotNum);
    }
	
	public String getSyrupType(int syrupNum) {
		String syrupType = sqlSession.selectOne("getSyrupType", syrupNum);
		return syrupType;
	}
	
	public Integer getSyrupPrice(int syrupNum) {
        return sqlSession.selectOne("getSyrupPrice", syrupNum);
    }
	
	public String getMilkType(int milkNum) {
		String milkType = sqlSession.selectOne("getMilkType", milkNum);
		return milkType;
	}
	
	public Integer getMilkPrice(int milkNum) {
        return sqlSession.selectOne("getMilkPrice", milkNum);
    }
	
	public String getIceType(int iceNum) {
		String iceType = sqlSession.selectOne("getIceType", iceNum);
		return iceType;
	}
	
	public Integer getIcePrice(int iceNum) {
        return sqlSession.selectOne("getIcePrice", iceNum);
    }
	
	public String getWhipType(int whipNum) {
		String whipType = sqlSession.selectOne("getWhipType", whipNum);
		return whipType;
	}
	
	public Integer getWhipPrice(int whipNum) {
        return sqlSession.selectOne("getWhipPrice", whipNum);
    }
	
	public int getStoreOrderListCount(String bucksId) {
		return sqlSession.selectOne("getStoreOrderListCount", bucksId);
	}
	
	public List<OrderDTO> getStoreOrderList(Map<String, Object> params){
		return sqlSession.selectList("getStoreOrderList", params);
	}
	
	public int getDeliverOrderListCount(String bucksId) {
		return sqlSession.selectOne("getDeliverOrderListCount", bucksId);
	}
		
	public List<OrderDTO> getDeliverOrderList(Map<String, Object> params){
		return sqlSession.selectList("getDeliverOrderList", params);
	}
	
	public List<OrderDTO> getAllOrderList(Map<String, Object> params){
		return sqlSession.selectList("getAllOrderList", params);
	}
	
	public List<StockUseDTO> getUseList(String menuOptCode){
		return sqlSession.selectList("getUseList", menuOptCode);
	}
	
	public int updateCountMinus(Map<String, Object> params) {
		return sqlSession.update("updateCountMinus", params);
	}
	
	public int getStoreStocksCount(Map<String, Object> params) {
		System.out.println(params);
		return sqlSession.selectOne("getStoreStocksCount", params);
	}
	
	public String getSyrupCode(String syrupType) {
		return sqlSession.selectOne("getSyrupCode", syrupType);
	}
	
	public String getMilkCode(String milkType) {
		return sqlSession.selectOne("getMilkCode", milkType);
	}
	
	public String getStockListCode(String menuName) {
		return sqlSession.selectOne("getStockListCode", menuName);
	}
	
	public int updateOrderStatus(String orderCode) {
		return sqlSession.update("updateOrderStatus", orderCode);
	}
	
	public int getMakingListCount(String bucksId) {
		return sqlSession.selectOne("getMakingListCount", bucksId);
	}
	
	public List<OrderDTO> getMakingList(Map<String, Object> params){
		return sqlSession.selectList("getMakingList", params);
	}
}
