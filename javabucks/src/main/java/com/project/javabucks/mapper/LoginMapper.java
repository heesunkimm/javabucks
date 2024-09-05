package com.project.javabucks.mapper;


import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.javabucks.dto.UserDTO;

@Service
public class LoginMapper {

	@Autowired
	private SqlSession sqlSession;
	
	// 회원가입
	public int insertUser(Map<String, Object> params) {
		return sqlSession.insert("insertUser", params);
	}
	

	// 생일 해당
	@Transactional
	public void insertBday(Map<String, Object> params) {
		// 웰컴 쿠폰
		sqlSession.insert("insertWelcomeCoupon", params);
		// 웰컴 알람
		sqlSession.insert("insertWelcomeAlarm", params);
		// 생일 쿠폰
		sqlSession.insert("insertBdayCoupon", params);
		// 생일 알람
		sqlSession.insert("insertBdayCouponAlarm", params);
		
	}
	
	// 생일 미해당
	@Transactional
	public void insertNotBday(Map<String, Object> params) {
		// 웰컴 쿠폰
		sqlSession.insert("insertWelcomeCoupon", params);
		// 웰컴 알람
		sqlSession.insert("insertWelcomeAlarm", params);
	}
	
	
	// 아이디 중복체크 
	public int checkId(String id) {
		return sqlSession.selectOne("checkId", id);
	}
	
	// 이메일 중복체크 
	public int checkEmail(Map<String,String> params) {
		return sqlSession.selectOne("checkEmail", params);
	}
	
	// 회원가입 이메일인증 - 이메일이 이미 존재한지 확인
	public UserDTO findUserByEmail(Map<String,String> params) {
		return sqlSession.selectOne("findUserByEmail", params);
	}
	
	// 비밀번호 찾기 이메일 인증 시 회원있는지 확인
	public UserDTO findUserByIDEmail(Map<String, String> params) {
		return sqlSession.selectOne("findUserByIDEmail", params);
	}
	
	// 로그인하기 위해 아이디가 있는지 확인  
	public UserDTO findUserByLogin(String userId) {
		return sqlSession.selectOne("findUserByLogin",userId);
	}
	
	// 아이디 찾기
	public String findIdbyEmail(Map<String, String> params) {
		return sqlSession.selectOne("findIdbyEmail", params);
	}
	
	// 비밀번호 찾기
	public String findPwbyEmail(Map<String, String> params) {
		return sqlSession.selectOne("findPwbyEmail", params);
	}
	
	// 유저 정보 불러오기
	public UserDTO getUserInfo(String userId) {
		return sqlSession.selectOne("getUserInfo", userId);
	}
	
	// 유저 비밀번호 가져오기
	public String getUserPassWd(String userId) {
		return sqlSession.selectOne("getUserPassWd", userId);
	}
		
	// 정보수정
	public int updateUserInfo(Map<String, Object> params) {
		return sqlSession.update("updateUserInfo", params);
	}
	
	// 회원탈퇴
	public int updateUserDel(String userId) {
		return sqlSession.update("updateUserDel", userId);
	}
}
