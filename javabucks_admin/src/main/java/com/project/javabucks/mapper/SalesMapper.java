package com.project.javabucks.mapper;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucks.dto.BucksDTO;

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
    
    
    
	
    
  
	 
}
