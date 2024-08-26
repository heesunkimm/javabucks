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
		System.out.println("adminId : " + adminId);
		return sqlSession.selectOne("findAdminById",adminId);
	}
	
	// 비밀번호 찾기 
	public int updatePasswd(AdminDTO dto) {
		return sqlSession.update("updatePasswd",dto);
	}
	 
}
