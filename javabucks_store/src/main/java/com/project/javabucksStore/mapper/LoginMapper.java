package com.project.javabucksStore.mapper;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.javabucksStore.dto.BucksDTO;

@Service
public class LoginMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 - 아이디로 사용자 정보 가져오기, 비밀번호 찾기
	public BucksDTO findStoreById(String bucksId) {
		return sqlSession.selectOne("findStoreById",bucksId);
	}
	
	// 이메일 인증 전에 해당 계정있는지 확인
	public BucksDTO findStoreByEmail(Map<String,String> params) {
		return sqlSession.selectOne("findStoreByEmail", params);
	}
	
	// 아이디 찾기
	public String findStoreIdbyEmail(Map<String, String> params) {
		return sqlSession.selectOne("findStoreIdbyEmail", params);
	}
	
	// 비밀번호 찾기 이메일 인증 시 회원있는지 확인
	public BucksDTO findStoreByIDEmail(Map<String, String> params) {
		return sqlSession.selectOne("findStoreByIDEmail", params);
	}
	
}
