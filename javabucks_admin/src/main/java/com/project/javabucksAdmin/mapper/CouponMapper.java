package com.project.javabucksAdmin.mapper;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.CouponDTO;


@Service
public class CouponMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertCoupon(CouponDTO dto) { 
	    return sqlSession.insert("insertCoupon", dto);
	}
}

