package com.project.javabucksStore.mapper;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.javabucksStore.dto.BucksDTO;

@Service
public class LoginMapper {
	
	// store
	@Autowired
	private SqlSession sqlSession;
	
	public BucksDTO findStoreById(String bucksId) {
		return sqlSession.selectOne("findStoreById",bucksId);
	}
	
	
}
