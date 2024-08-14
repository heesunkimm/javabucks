package com.project.javabucksStore.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksStore.dto.OrderDTO;

@Service
public class OrderMapper {

	@Autowired
	private SqlSession sqlSession;
	
	// 매장 주문내역 조회
	public List<OrderDTO> orderInfo(Map<String, Object> params){
		List<OrderDTO> list = sqlSession.selectList("orderInfo", params);
		return list;
	}
	
	public String getMenuName(String menuCode) {
		String menuName = sqlSession.selectOne("getMenuName", menuCode);
		return menuName;
	}
	
}
