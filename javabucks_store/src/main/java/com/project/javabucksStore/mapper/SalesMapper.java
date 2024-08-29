package com.project.javabucksStore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.javabucksStore.dto.BaljooDTO;
import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.UserDTO;

@Repository
public class SalesMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<BaljooDTO> baljooList(String bucksId){
		return sqlSession.selectList("baljooList",bucksId);
	}
	
	public Map<String, Object> getStockInfo(String stockCode){
		//System.out.println(stockCode);
		return sqlSession.selectOne("getStockInfo",stockCode);
	}
	
	public List<BaljooDTO> searchBaljooList(Map<String, Object> params){
		return sqlSession.selectList("searchBaljooList",params);
	}
	
	
	

}
