package com.project.javabucksAdmin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.AdminDTO;
import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.dto.UserDTO;

@Service
public class AccountMapper {
	
		 @Autowired
		 private SqlSession sqlSession;
		 
		 
		//관리자 리스트 
		 public List<AdminDTO> adminList(Map<String, Object> params){
	    	return sqlSession.selectList("adminList",params);
		    }
		 
		 public int adminListCount() {
				return sqlSession.selectOne("adminListCount");
			}

		 public List<AdminDTO> searchAdminList(Map<String, Object> params){
			 //System.out.println("params : "+params);
		    	return sqlSession.selectList("searchAdminList",params);
			    }
			 
		 public int searchAdminCount(Map<String, Object> params) {
				return sqlSession.selectOne("searchAdminCount",params);
			}
		 
		 public int deleteAdminById(String adminId) {
				return sqlSession.update("deleteAdmin",adminId);
			}
		 
		//이메일 중복 확인	
		    public boolean checkAdminEmail(AdminDTO dto) {
				 int count = sqlSession.selectOne("checkAdminEmail", dto);
				 return count > 0;
			 }
		   
		  //아이디 중복 확인	
		    public boolean checkAdminId(String adminId) {
				 int count = sqlSession.selectOne("checkAdminId", adminId);
				 return count > 0;
			 }
		    
		  //지점 등록
		    public int addAdmin(AdminDTO dto) {
		    	return sqlSession.insert("addAdmin", dto);
		    }
		    
		    
		  //지점 상세보기
		    public AdminDTO editAdmin(String adminId) {
		    	return sqlSession.selectOne("editAdmin",adminId);
		    }
		    
		  //이메일 중복 확인	
		    public boolean editCheckAdminEmail(AdminDTO dto) {
				 int count = sqlSession.selectOne("editCheckAdminEmail", dto);
				 return count > 0;
			 }
		    //지점수정등록
		    public int editUpdateAdmin(AdminDTO dto) {
		    	return sqlSession.update("editUpdateAdmin", dto);
		    }
		    
///////////////user
		    
		    //유저 계정
		    public List<UserDTO> userList(Map<String, Object> params){
		    	return sqlSession.selectList("userList",params);
			    }
			 
			 public int userListCount() {
					return sqlSession.selectOne("userListCount");
				}
			 
			 
			 public int deleteUserById(String userId) {
					return sqlSession.update("deleteUser",userId);
				}
			 
			//user 상세보기
			    public UserDTO editUser(String userId) {
			    	return sqlSession.selectOne("editUser",userId);
			    }
			  
			    //user이메일 중복 확인	
			    public boolean editCheckUserEmail(UserDTO dto) {
					 int count = sqlSession.selectOne("editCheckUserEmail", dto);
					 return count > 0;
				 }
			    //user수정등록
			    public int editUpdateUser(UserDTO dto) {
			    	return sqlSession.update("editUpdateUser", dto);
			    }   
	    
			    public List<UserDTO> searchUserList(Map<String, Object> params){
			    	//System.out.println(params);
			    	return sqlSession.selectList("searchUserList",params);
			    }
					 
				 public int searchUserCount(Map<String, Object> params) {
						return sqlSession.selectOne("searchUserCount",params);
					}
			    
			    
			    

}
