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
	
	// 로그인
	public BucksDTO findStoreById(String bucksId) {
		return sqlSession.selectOne("findStoreById",bucksId);
	}
	
	// 아이디 찾기
	public BucksDTO emailForId(Map<String, String> params) {
		return sqlSession.selectOne("emailForId",params);
	}
	
	
}
