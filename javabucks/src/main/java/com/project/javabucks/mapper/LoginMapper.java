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
	
	// 회원가입 insert 
	public int insertUser(UserDTO dto){
		return sqlSession.insert("insertUser",dto);
	}
	 
	// 아이디 중복체크 
	public int checkId(String id) {
		return sqlSession.selectOne("checkId", id);
	}
	
	// 회원가입 이메일인증 - 이메일이 이미 존재한지 확인
	public UserDTO findUserByEmail(Map<String,String> params) {
		return sqlSession.selectOne("findUserByEmail",params);
	}
	
	// 로그인하기 위해 아이디가 있는지 확인  
	public UserDTO findUserById(String userId) {
		// System.out.println("???"); 찍힌다 
		return sqlSession.selectOne("findUserById",userId);
	}
	
	// 아이디찾기 이메일인증 
//	public UserDTO emailForId(Map<String, String> params) {
//		return sqlSession.selectOne("emailForId",params);
//	} 
	
	// 아이디 찾기 
	public UserDTO findUserById2(Map<String, String> paramMap) {
		return sqlSession.selectOne("findUserById2",paramMap);
	}
 
	// 개인정보 수정 
	public int updateInfo(UserDTO dto) {
		return sqlSession.update("updateInfo", dto);
	}
		
	// 탈퇴 
	
	
}
