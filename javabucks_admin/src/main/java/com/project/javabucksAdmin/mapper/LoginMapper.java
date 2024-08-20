package com.project.javabucksAdmin.mapper;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.AdminDTO;

@Service
public class LoginMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public AdminDTO findAdminById(String adminId) {
		System.out.println("adminId : " + adminId);
		return sqlSession.selectOne("findAdminById",adminId);
	}
	
}
