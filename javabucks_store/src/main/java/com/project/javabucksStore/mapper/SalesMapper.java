package com.project.javabucksStore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.javabucksStore.dto.BaljooDTO;

@Repository
public class SalesMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<BaljooDTO> baljooList(String userId){
		return sqlSession.selectList("baljooList",userId);
	}
	
	public Map<String, Object> getStockInfo(String stockCode){
		return sqlSession.selectOne("getStockInfo",stockCode);
	}
	
	public List<BaljooDTO> searchBaljooList(Map<String, Object> params){
		return sqlSession.selectList("searchBaljooList",params);
	}
	
	
	

}
