package com.project.javabucksAdmin.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.StockListDTO;

@Service
public class OrderMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 어드민 재고관리 조회
	public List<StockListDTO> adminStockList(){
		List<StockListDTO> list = sqlSession.selectList("getAdminStockList");
		return list;
	}
}
