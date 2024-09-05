package com.project.javabucksAdmin.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.javabucksAdmin.dto.BaljooDTO;
import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.dto.OrderDTO;
import com.project.javabucksAdmin.dto.OrderItem;
import com.project.javabucksAdmin.dto.PayhistoryDTO;

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
           // System.out.println("Generated Bucks ID: " + bucksId); // 디버깅용 출력
        } while (checkBucksId(bucksId)); // 중복 확인
       // System.out.println("Unique Bucks ID confirmed: " + bucksId); // 디버깅용 출력
        return bucksId;
    }
    
    // 숫자로만 구성된 UUID 생성 메소드
    private String generateNumericUUID(int length) {
        String uuid = UUID.randomUUID().toString().replaceAll("[^0-9]", "");
        return uuid.substring(0, Math.min(length, uuid.length()));
    }
    
  //지점 리스트 
    public List<BucksDTO> bucksList(Map<String, Object> params){
    	//System.out.println(params);
    	return sqlSession.selectList("bucksList",params);
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
    	//System.out.println(params);
    	return sqlSession.selectList("searchBucks", params);
    }
    
  //특정 검색 지점 페이징 
    public int searchBucksCount(Map<String, Object> params) {
    	return sqlSession.selectOne("searchBucksCount",params);
    }

    
    //지점 상세보기
    public BucksDTO editbucks(String bucksId) {
    	return sqlSession.selectOne("editbucks",bucksId);
    }
    
    
  //이메일 중복 확인	
    public boolean editCheckEmail(BucksDTO dto) {
		 int count = sqlSession.selectOne("editCheckEmail", dto);
		 return count > 0;
	 }
    
 
  //지점 수정
    public int editBucks(BucksDTO dto) {
    	return sqlSession.update("editBucks", dto);
    }
    
    //지점 삭제 
    public int deleteBucks(String bucksId) {
    	return sqlSession.update("deleteBucks",bucksId);
    }
    
    //페이징 
    public int bucksListCount() {
		return sqlSession.selectOne("bucksListCount");
	}
    
//Sales
    //발주페이지에 벅스이름 들고가기
//    public List<BucksDTO> selectBucksName() {
//    	return sqlSession.selectList("selectBucksName");
//    }
    
    public List<BaljooDTO> selectBaljoo() {
    	return sqlSession.selectList("selectBaljoo");
    }
    
    
  //검색한 지점과 날짜로 발주정산 수정
    public List<BaljooDTO> selectOrderSum(Map<String, Object> params){
    	return sqlSession.selectList("selectOrderSum",params);
    }
    
//    ////검색한 지점과 날짜로 발주정산
//    public List<BaljooDTO> baljoolist(Map<String, Object> params){
//    	return sqlSession.selectList("baljoolist", params);
//    }
    
    //발주 상세보기  
    public List<BaljooDTO> selectDetails(Map<String, Object> params) {
    	return sqlSession.selectList("selectDetails",params);
    }
    
    public List<String> baljooNamesByCodes(@Param("codes") List<String> codes) {
    	//System.out.println("매퍼콘솔 : " +codes);
    	return sqlSession.selectOne("baljooNameByCode",codes);
    }

	public List<Object> getlistName(String stockCode) {
		//System.out.println("매퍼코드 : "+stockCode);
		return sqlSession.selectList("getlistName",stockCode);
	}
    
//    //발주 상세보기 2 ..ㅋㅋㅋㅋ 너무 멀리간 코드,,,,ㅋㅋㅋㅋㅋㅋㅋ 월뵬 카테고리 할때 참고하기,,,
//	public List<Map<String, Object>> selectPricesByCodes(@Param("codes") List<String> codes) {
//		System.out.println(codes);
//		return sqlSession.selectList("selectPricesByCodes", codes);
//	}
    
    
 
	public List<PayhistoryDTO> monthlyBucksSales() {
    	return sqlSession.selectList("monthlyBucksSales");
    }
	
	//검색한 지점과 날짜로 월별정산 
    public List<PayhistoryDTO> searchMonth(Map<String, Object> params){
    	return sqlSession.selectList("searchMonth",params);
    }
    
    //월별 매출 상세보기 1 - 
    public List<OrderDTO> monthlyDetails(Map<String, Object> params){
    	//System.out.println(params);
    	return sqlSession.selectList("monthlyDetails", params);
    }
    
    //월별 매출 상세보기 2 - 메뉴가격 가져오기
	public int getMenuPrice(String menuCode){
		//System.out.println("menuCode : " + menuCode);
		return sqlSession.selectOne("getMenuPrice", menuCode);
	}
	
	//월별 매출 상세보기 3 - 옵션가격 가져오기
    public int getOptPrice(String optionId) {
    	//System.out.println("optionId : "+ optionId);
    	return sqlSession.selectOne("getOptPrice",optionId);
    }
    
    //쿠폰 코드로 쿠폰가격 가져오기
    public int getCouponPrice(int coupon) {
    	//System.out.println("coupon : " + coupon);
    	return sqlSession.selectOne("getCouponPrice", coupon);
    }
    
    public List<PayhistoryDTO> dailyBucksSales(Map<String, Object> params) {
    	return sqlSession.selectList("dailyBucksSales", params);
    }
    public int dailyBucksSalesPrice() {
    	Integer price =  sqlSession.selectOne("dailyBucksSalesPrice");
    	 return (price != null) ? price : 0;
    }
    
    
    // 메뉴코드의 첫 글자를 통해 카테고리 분류
 	public String categorizeMenu(String menuCode) {
 			    if (menuCode.startsWith("B")) {
 			        return "음료";
 			    } else if (menuCode.startsWith("C")) {
 			        return "디저트";
 			    } else if (menuCode.startsWith("M")) {
 			        return "MD상품";
 			    } else {
 			        return "Unknown";
 			    }
 			}
 	
 	public List<PayhistoryDTO> searchDailySales(Map<String, Object> params) {
 		//System.out.println(params);
 		return sqlSession.selectList("searchDailySales",params);
 	}
 	
 	public int dailySalesCount() {
    	return sqlSession.selectOne("dailySalesCount");
    }
 	
 	public int searchDSalesCount(Map<String, Object> params) {
    	return sqlSession.selectOne("searchDSalesCount",params);
    }

 			
	 
}
