package com.project.javabucksStore.mapper;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.javabucksStore.dto.BucksDTO;

@Service
public class LoginMapper {
	
	// store
	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 - 아이디로 사용자 정보 가져오기, 비밀번호 찾기
	public BucksDTO findStoreById(String bucksId) {
		return sqlSession.selectOne("findStoreById",bucksId);
	}
	
	// 아이디 찾기 
	public BucksDTO findStoreById2(Map<String, String> paramMap) {
		return sqlSession.selectOne("findStoreById2",paramMap);
	}
	
	
}
