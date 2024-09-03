package com.project.javabucksAdmin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.AlarmDTO;
import com.project.javabucksAdmin.dto.CouponDTO;
import com.project.javabucksAdmin.dto.CouponListDTO;
import com.project.javabucksAdmin.dto.UserDTO;


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
	// 삭제 전 유저에게 발급된 쿠폰이 있는지 확인
	public CouponListDTO userCpnCheck(String cpnCode) {
		return sqlSession.selectOne("userCpnCheck", cpnCode);
	}
	// 쿠폰 삭제
	public int deleteCoupon(String cpnCode) {
		return sqlSession.delete("deleteCoupon", cpnCode);
	}
	// 유저 정보 조회
	public List<UserDTO> getUserInfo() {
		return sqlSession.selectList("getUserInfo");
	}
	// 등록된 쿠폰리스트 조회
	public List<CouponListDTO> getUserCpnList() {
		return sqlSession.selectList("getUserCpnList");
	}
	// 유저에게 쿠폰 등록
	public int toUserCoupon(CouponListDTO dto) {
		return sqlSession.insert("toUserCoupon", dto);
	}
	// 유저에게 하나의 쿠폰이 같은 날 중복발급 안되게 체크
	public CouponListDTO todayCpnCheck(Map<String, Object> params) {
		return sqlSession.selectOne("todayCpnCheck", params);
	}
	// 특정 유저에게 쿠폰 전송
	public int sendUserCoupon(Map<String, Object> params) {
		return sqlSession.insert("toUserCoupon", params);
	}
	// 유저에게 등록된 쿠폰 알림 전송
	public int toUserAlarm(AlarmDTO dto) {
		return sqlSession.insert("toUserAlarm", dto);
	}
	// 등록된 쿠폰코드, 코드명 조회
	public List<CouponDTO> cpnInfoList() {
		return sqlSession.selectList("cpnInfoList");
	}
	// 검색 조건에 맞게 필터링된 쿠폰리스트
	public List<CouponListDTO> searchFilterCpn(Map<String, Object> params) {
		return sqlSession.selectList("searchFilterCpn", params); 
	}
	// 검색 조건에 맞게 필터링된 쿠폰리스트 갯수
	public int searchFilterCpnCount(Map<String, Object> params) {
		return sqlSession.selectOne("searchFilterCpnCount", params);
	}
}

