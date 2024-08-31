package com.project.javabucksAdmin.mapper;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.AdminDTO;

@Service
public class LoginMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 
	public AdminDTO findAdminById(String adminId) {
		return sqlSession.selectOne("findAdminById", adminId);
	}
	
	// 비밀번호 변경
	public int adminChangePw(Map<String, String> params) {
		return sqlSession.update("adminChangePw", params);
	}
	 
}
