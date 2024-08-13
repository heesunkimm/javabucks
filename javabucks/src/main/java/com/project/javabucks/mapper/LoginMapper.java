package com.project.javabucks.mapper;


import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.javabucks.dto.UserDTO;

@Service
public class LoginMapper {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertUser(UserDTO dto){
		return sqlSession.insert("insertUser",dto);
	}
	
	public int checkId(String id) {
		return sqlSession.selectOne("checkId", id);
	}
	
	public UserDTO findUserByEmail(Map<String,String> params) {
		return sqlSession.selectOne("findUserByEmail",params);
		
	}
	
}
