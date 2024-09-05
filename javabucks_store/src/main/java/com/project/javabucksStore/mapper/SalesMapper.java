package com.project.javabucksStore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.javabucksStore.dto.BaljooDTO;
import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.PayhistoryDTO;
import com.project.javabucksStore.dto.UserDTO;

@Repository
public class SalesMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<BaljooDTO> baljooList(Map<String, Object> params){
		return sqlSession.selectList("baljooList",params);
	}
	
	public Map<String, Object> getStockInfo(String stockCode){
		//System.out.println(stockCode);
		return sqlSession.selectOne("getStockInfo",stockCode);
	}
	
	public List<BaljooDTO> searchBaljooList(Map<String, Object> params){
		return sqlSession.selectList("searchBaljooList",params);
	}
	
	public List<PayhistoryDTO> getSalesList(Map<String, Object> params){
		return sqlSession.selectList("getSalesList", params);
	}
	
	public int getSalesCount(String bucksId){
		return sqlSession.selectOne("getSalesCount", bucksId);
	}
	
	public String getMenuName(String menuCode){
		//System.out.println("menuCode : " + menuCode);
		return sqlSession.selectOne("MenuName", menuCode);
	}
	
	public int getTotalSalesAmount(String bucksId) {
	    Integer totalSalesAmount = sqlSession.selectOne("getTotalSalesAmount", bucksId);
	    if (totalSalesAmount == null) {
	        return 0; // null인 경우 0을 반환
	    }
	    return totalSalesAmount;
	}
	
	public int searchSalesCount(Map<String, Object> countParams){
		return sqlSession.selectOne("searchSalesCount", countParams);
	}
	
	public int searchTotalSalesAmount(Map<String, Object> countParams){
		return sqlSession.selectOne("searchTotalSalesAmount", countParams);
	}
	
	public List<PayhistoryDTO> getFilteredSalesList(Map<String, Object> countParams){
		return sqlSession.selectList("getFilteredSalesList", countParams);
	}
	
	//
	public int getselectCateCount(String bucksId){
		return sqlSession.selectOne("getselectCateCount", bucksId);
	}
	
	//
	public List<PayhistoryDTO> getselectCateList(Map<String, Object> searchParams){
		return sqlSession.selectList("getselectCateList", searchParams);
	}
	
	public PayhistoryDTO getMenuNameByCode(String menuCode) {
	    return sqlSession.selectOne("getMenuNameByCode", menuCode);
	}
	
	public int getOptionPriceByCode(String optionCode) {
	    return sqlSession.selectOne("getOptionPriceByCode", optionCode);
	}
	
	public int getCouponPrice(int coupon) {
		  //System.out.println(coupon);
    	return sqlSession.selectOne("getCouponPrice", coupon);
    }
	
	public int baljooCount(String bucksId){
		return sqlSession.selectOne("baljooCount", bucksId);
	}
	public int searchBaljooCount(Map<String, Object> params){
		return sqlSession.selectOne("searchBaljooCount", params);
	}
	
	public List<BaljooDTO> baljooPriceList(String bucksId){
		return sqlSession.selectList("baljooPriceList",bucksId);
	}
	
	
	public List<BaljooDTO> searchBaljooPriceList(Map<String, Object> params){
		return sqlSession.selectList("searchBaljooPriceList",params);
	}
	
	public int CateSearchSalesCount(Map<String, Object> searchParams){
		return sqlSession.selectOne("CateSearchSalesCount", searchParams);
	}
	
}