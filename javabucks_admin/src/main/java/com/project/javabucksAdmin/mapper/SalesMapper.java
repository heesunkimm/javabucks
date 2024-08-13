package com.project.javabucksAdmin.mapper;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.BucksDTO;

@Service
public class SalesMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public boolean checkBucksId(String bucksId) {
		 int count = sqlSession.selectOne("checkBucksId", bucksId);
	     return count > 0;
    }
	
	 
	// 고유 ID 생성 메소드
    public String generateUniqueBucksId() {
        String bucksId;
        do {
        	bucksId = "bucks_" + generateNumericUUID(4);
            System.out.println("Generated Bucks ID: " + bucksId); // 디버깅용 출력
        } while (checkBucksId(bucksId)); // 중복 확인
        System.out.println("Unique Bucks ID confirmed: " + bucksId); // 디버깅용 출력
        return bucksId;
    }
    
    // 숫자로만 구성된 UUID 생성 메소드
    private String generateNumericUUID(int length) {
        String uuid = UUID.randomUUID().toString().replaceAll("[^0-9]", "");
        return uuid.substring(0, Math.min(length, uuid.length()));
    }
    
	//이메일 중복 확인	
    public boolean checkEmail(BucksDTO dto) {
		 int count = sqlSession.selectOne("checkEmail", dto);
		 return count > 0;
	 }
    
    //지점 등록
    public int addBucks(BucksDTO dto) {
    	return sqlSession.insert("addBucks", dto);
    }
    
    //특정 검색 지점 리스트 
    public List<BucksDTO> searchBucks(Map<String, Object> params){
    	return sqlSession.selectList("searchBucks", params);
    }
    
    //지점 상세보기
    public BucksDTO editbucks(String bucksId) {
    	return sqlSession.selectOne("editbucks",bucksId);
    }
    
    
    
 
    
	
    
  
	 
}
