package com.project.javabucksAdmin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.CouponDTO;


@Service
public class CouponMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 쿠폰등록
	public int insertCoupon(CouponDTO dto) { 
	    return sqlSession.insert("insertCoupon", dto);
	}
	// 등록된 쿠폰리스트 조회
	public List<CouponDTO> listCoupon() {
		return sqlSession.selectList("listCoupon");
	}
	// 쿠폰리스트 - 쿠폰명, 쿠폰코드 중복체크
	public CouponDTO cpnCheck(CouponDTO dto) {
		return sqlSession.selectOne("cpnCheck", dto);
	}
	// 쿠폰 삭제
	public int deleteCoupon(String cpnCode) {
		return sqlSession.delete("deleteCoupon", cpnCode);
	}
	// 
}

