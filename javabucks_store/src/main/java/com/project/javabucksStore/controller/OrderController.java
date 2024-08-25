package com.project.javabucksStore.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.javabucksStore.dto.MenuOrder;
import com.project.javabucksStore.dto.OrderDTO;
import com.project.javabucksStore.dto.OrderOptDTO;
import com.project.javabucksStore.mapper.OrderMapper;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class OrderController {

    @Autowired
    OrderMapper mapper;

    @GetMapping("/orderHistory.do")
    public String orderHistory(HttpServletRequest req) {
    	// 주문일 검색조건 세팅
    	Date date = new Date();
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	String today = dateFormat.format(date);    	
    	//System.out.println("today : " + today);
    	
    	// 지점 아이디 받아서 추가하는 작업 필요
        String bucksId = "bucks_1115";
        
        Map<String, Object> params = new HashMap<>();
        params.put("bucksId", bucksId);
        params.put("searchOpt_orderDate", today);
        
        // 주문정보
        List<OrderDTO> orderInfoList = mapper.orderInfo(params);      
        
        // order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
        orderListMethod(orderInfoList);
        
        req.setAttribute("searchOpt_orderDate", today);
        req.setAttribute("orderInfoList", orderInfoList);
        return "/order/store_orderHistory";
    }
    

    
    @PostMapping("/orderHistory.do")
    public String orderSearch(HttpServletRequest req, String searchOpt_orderDate, String searchOpt_orderCode) {
    	//System.out.println("searchOpt_orderDate :" + searchOpt_orderDate);
    	//System.out.println("searchOpt_orderCode :" + searchOpt_orderCode);
    	
    	// 지점 아이디 받아서 추가하는 작업 필요
        String bucksId = "bucks_1115";
    	
        Map<String, Object> params = new HashMap<>();
        params.put("bucksId", bucksId);
        params.put("searchOpt_orderCode", searchOpt_orderCode);
        params.put("searchOpt_orderDate", searchOpt_orderDate);
        
        // 주문정보
        List<OrderDTO> searchOrderInfoList = mapper.searchOrderInfo(params);
        // order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
        orderListMethod(searchOrderInfoList);
        
    	req.setAttribute("searchOpt_orderCode", searchOpt_orderCode);    	
    	req.setAttribute("searchOpt_orderDate", searchOpt_orderDate);
    	req.setAttribute("orderInfoList", searchOrderInfoList);

    	return "/order/store_orderHistory";
    }    
    
    
    @GetMapping("/deliversHistory.do")
    public String deliversHistory(HttpServletRequest req) {
    	// 주문일 검색조건 세팅
    	Date date = new Date();
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	String today = dateFormat.format(date);    	
    	//System.out.println("today : " + today);
    	
    	// 지점 아이디 받아서 추가하는 작업 필요
        String bucksId = "bucks_1115";
        
        Map<String, Object> params = new HashMap<>();
        params.put("bucksId", bucksId);
        params.put("searchOpt_orderDate", today);
        
        // 주문정보
        List<OrderDTO> deliversOrderInfoList = mapper.deliversOrderInfo(params);
        // order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
        orderListMethod(deliversOrderInfoList);
        
        req.setAttribute("searchOpt_orderDate", today);
        req.setAttribute("deliversOrderInfoList", deliversOrderInfoList);        
    	return "/order/store_deliversHistory";
    }
    
    
    @PostMapping("/deliversHistory.do")
    public String deliversOrderSearch(HttpServletRequest req, String searchOpt_orderDate, String searchOpt_orderCode) {
    	// 지점 아이디 받아서 추가하는 작업 필요
        String bucksId = "bucks_1115";
        
        Map<String, Object> params = new HashMap<>();
        params.put("bucksId", bucksId);
        params.put("searchOpt_orderCode", searchOpt_orderCode);
        params.put("searchOpt_orderDate", searchOpt_orderDate);
        
        // 주문정보
        List<OrderDTO> searchDeliversOrderInfoList = mapper.searchDeliversOrderInfo(params);
        // order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
        orderListMethod(searchDeliversOrderInfoList);
        
        req.setAttribute("searchOpt_orderCode", searchOpt_orderCode);    	
    	req.setAttribute("searchOpt_orderDate", searchOpt_orderDate);
        req.setAttribute("deliversOrderInfoList", searchDeliversOrderInfoList);        
    	return "/order/store_deliversHistory";
    }
    
    @GetMapping("/orderManage.do")
    public String orderManage(HttpServletRequest req,
    		@RequestParam(value = "storeOrder_pageNum", required = false, defaultValue = "1") int storeOrder_pageNum,
    		@RequestParam(value = "deliverOrder_pageNum", required = false, defaultValue = "1") int deliverOrder_pageNum) {

    	// 세션값 꺼내기
    	String bucksId = "bucks_1115";
    	
    	// 매장 신규주문
    	int storeOrderListCount = mapper.getStoreOrderListCount(bucksId);
    	Map<String, Object> storeOrder_pagingMap = paging(storeOrderListCount, storeOrder_pageNum); 
    	
    	Map<String, Object> storeOrder_params = new HashMap<>();
    	storeOrder_params.put("bucksId", bucksId);
    	storeOrder_params.put("startRow", storeOrder_pagingMap.get("startRow"));
    	storeOrder_params.put("endRow", storeOrder_pagingMap.get("endRow"));

    	List<OrderDTO> storeOrderList = mapper.getStoreOrderList(storeOrder_params);
    	// order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
    	orderListMethod(storeOrderList);
    	
    	req.setAttribute("storeOrder_startPage", (int)storeOrder_pagingMap.get("startPage"));
		req.setAttribute("storeOrder_endPage", (int)storeOrder_pagingMap.get("endPage"));
		req.setAttribute("storeOrder_pageCount", (int)storeOrder_pagingMap.get("pageCount"));
		req.setAttribute("storeOrder_pageBlock", (int)storeOrder_pagingMap.get("pageBlock"));
    	req.setAttribute("storeOrderList", storeOrderList);
    	
    	// 배달 신규주문
    	int deliverOrderListCount = mapper.getDeliverOrderListCount(bucksId);
    	Map<String, Object> deliverOrder_pagingMap = paging(deliverOrderListCount, deliverOrder_pageNum);
    	
    	Map<String, Object> deliverOrder_params = new HashMap<>();
    	deliverOrder_params.put("bucksId", bucksId);
    	deliverOrder_params.put("startRow", deliverOrder_pagingMap.get("startRow"));
    	deliverOrder_params.put("endRow", deliverOrder_pagingMap.get("endRow"));
    	
    	List<OrderDTO> deliverOrderList = mapper.getDeliverOrderList(deliverOrder_params);
    	// order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
    	orderListMethod(deliverOrderList);
    	
    	req.setAttribute("deliverOrder_startPage", (int)deliverOrder_pagingMap.get("startPage"));
		req.setAttribute("deliverOrder_endPage", (int)deliverOrder_pagingMap.get("endPage"));
		req.setAttribute("deliverOrder_pageCount", (int)deliverOrder_pagingMap.get("pageCount"));
		req.setAttribute("deliverOrder_pageBlock", (int)deliverOrder_pagingMap.get("pageBlock"));
    	req.setAttribute("deliverOrderList", deliverOrderList);
    	
    	return "/order/store_orderManage";
    }
    
    // 주문접수 처리
  	@PostMapping("/startOrder.ajax")
  	public Map<String, Object> startOrder(String orderCode) {
  		// 세션값 꺼내기
     	String bucksId = "bucks_1115";
     	
     	// 코드 앞에 붙일 날짜_ 만들기
     	int intYear = LocalDate.now().getYear();
     	String StringYear = String.valueOf(intYear);
     	String year = StringYear.substring(2, 4);
     	//System.out.println(year); // 24
     	
     	int intMonth = LocalDate.now().getMonthValue();
     	String StringMonth = String.valueOf(intMonth);
     	String month = null;
     	if (intMonth < 10) {
     		month = "0" + StringMonth;
     	}
     	//System.out.println(month); // 08
     	
     	int intDay = LocalDate.now().getDayOfMonth();
     	String day = String.valueOf(intDay);
     	//System.out.println(day); // 25
     	
     	String orderDate = year + month + day + "_";
     	//System.out.println(orderDate); // 240825_
     	
     	String realOrderCode = orderDate + orderCode;
     	//System.out.println(realOrderCode);
     	
     	Map<String, Object> params = new HashMap<>();
     	params.put("bucksId", bucksId);
     	params.put("orderCode", realOrderCode);
     	
     	Map<String, Object> response = new HashMap<>();
     	
  		// orderCode로 주문 리스트 뽑아오기
  		List<OrderDTO> allOrderList = mapper.getAllOrderList(params);
  		// order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
     	orderListMethod(allOrderList);
     	
     	// 차감해야하는 재고 확인 & 스토어 재고 수량 확인 & 주문접수
     	for(int i=0; i<allOrderList.size(); i++) {
     		// 주문리스트의 orderList컬럼 뽑기
     		List<MenuOrder> orderList = allOrderList.get(i).getOrderListbyMenuOrder();
     		
     		for(MenuOrder order : orderList) {
     			String menuCode = order.getMenuCode();
     			//System.out.println(menuCode); // BESWHAMC
     			String optionId = order.getOptionId();
     			//System.out.println(optionId); // 6
     			
     			
     			// 메뉴코드의 앞글자가 B로 시작하면
     			if(menuCode.startsWith("B")) {
     				// 음료 1) 메뉴옵션코드 뽑아서 차감해야하는 기본 재료 뽑기
         			String menuOptCode = menuCode.substring(1, 4);
         			System.out.println(menuOptCode); // ESW
         			
         			// 음료 2) 옵션아이디로 차감해야하는 컵, 샷, 시럽, 우유, 휘핑 재료 뽑기
         			
         			
         			
         			
         			
         			
     			} else { // 메뉴코드의 앞글자가 B가 아니면(C 또는 M)
     				
     				// 음료 외 메뉴코드 뽑아서 차감해야하는 기본재료 뽑기
     				
     			}
     			
     			
     			 			
     			
     			
     			
     			
     			
     			// 뽑은 재료 스토어 재고 확인
     			
     			// 재고가 남아있으면 오더테이블 상태 업데이트
	     			// 오더테이블 상태 업데이트
	     	 		//int updateResult = mapper.updateOrderStatus();
	      		
	      			
     			// 재고가 없으면 알림
     		}

     	}

  			
  		return response;
  	}

    
    
    
    
    
    
    // order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
    public void orderListMethod(List<OrderDTO> list) {
    	for (OrderDTO orderDTO : list) {
    		try {
                // JSON 문자열을 List<String>으로 변환
                List<String> orderList = orderDTO.getOrderListtoStringList();
                // 메뉴명까지 들어간 orderList (업데이트용)
                List<MenuOrder> updateOrderList = new ArrayList<>();                
                
                for (String orderItem : orderList) {
                    // ":"로 문자열을 분리
                    String[] s = orderItem.split(":");                     
                    String menuCode = s[0];
                    String optId = s[1];
                    String quantity = s[2];
                    
                    // Menuorder 객체 만들어서 생성
                    MenuOrder menuOrder = new MenuOrder(menuCode, optId, Integer.parseInt(quantity));
                    
                    // MenuName DB에서 조회
                    String menuName = mapper.getMenuName(menuCode);
                    menuOrder.setMenuName(menuName);
                    
                    // 옵션정보
                    List<OrderOptDTO> optList = mapper.getMenuOpt(optId);
                    
                    for(OrderOptDTO dto : optList) {
                    	int cupNum = dto.getCupNum(); 
                    	String cupType = mapper.getCupType(cupNum);                    	
                    	Integer cupPriceInteger = mapper.getCupPrice(cupNum);
                        int cupPrice = Optional.ofNullable(cupPriceInteger).orElse(99999);
                        
                        menuOrder.setCupType(cupType);
                        menuOrder.setCupPrice(cupPrice);
                        
                    	int shotNum = dto.getShotNum();
                        String shotType = mapper.getShotType(shotNum);                    	
                    	Integer shotPriceInteger = mapper.getShotPrice(shotNum);
                    	int shotPrice = Optional.ofNullable(shotPriceInteger).orElse(99999);
                    	int shotCount = dto.getOptShotCount();
                                                
                        menuOrder.setShotType(shotType);
                        menuOrder.setShotPrice(shotPrice);
                        menuOrder.setShotCount(shotCount);

                    	int syrNum = dto.getSyrupNum();
                    	String syrupType = mapper.getSyrupType(syrNum);
                    	Integer syrupPriceInteger = mapper.getSyrupPrice(syrNum);                    	
                    	int syrPrice = Optional.ofNullable(syrupPriceInteger).orElse(99999);
                    	int syrCount = dto.getOptSyrupCount();
                    	
                    	menuOrder.setSyrupType(syrupType);
                    	menuOrder.setSyrupPrice(syrPrice);
                    	menuOrder.setSyrupCount(syrCount);                    	
                    	
                    	int milkNum = dto.getMilkNum();
                    	String milkType = mapper.getMilkType(milkNum);
                    	Integer milkPriceInteger = mapper.getMilkPrice(milkNum);
                    	int milkPrice = Optional.ofNullable(milkPriceInteger).orElse(99999);         
                    	
                    	menuOrder.setMilkType(milkType);
                    	menuOrder.setMilkPrice(milkPrice);

                    	int iceNum = dto.getIceNum();
                    	String iceType = mapper.getIceType(iceNum);
                    	Integer icePriceInteger = mapper.getIcePrice(iceNum);
                    	int icePrice = Optional.ofNullable(icePriceInteger).orElse(99999);
                    	
                    	menuOrder.setIceType(iceType);
                    	menuOrder.setIcePrice(icePrice);
                    	
                    	int whipNum = dto.getWhipNum();
                    	String whipType = mapper.getWhipType(whipNum);
                    	Integer whipPriceInteger = mapper.getWhipPrice(whipNum);
                    	int whipPrice = Optional.ofNullable(whipPriceInteger).orElse(99999);
                    	
                    	menuOrder.setWhipType(whipType);
                    	menuOrder.setWhipPrice(whipPrice);                      
                    }                    
                    // menuOrder객체를 List에 추가
                    updateOrderList.add(menuOrder);  
                }
                // updateOrderList를 List<MenuOrder> 형태로 orderDTO에 setter 사용해서 SET
                orderDTO.setOrderListbyMenuOrder(updateOrderList);
                
            } catch (IOException e) {
                // JSON 파싱 중 에러 처리
                e.printStackTrace();
            }
            
            // 코드 날짜 빼고 SET하기
            try {
            	String orderCode = orderDTO.getOrderCode();
                String updateOrderCode = orderCode.substring(7);
                orderDTO.setOrderCode(updateOrderCode);                
            }catch(Exception e) {
            	e.printStackTrace();
            }
        }
    }
    
    // 주문현황 페이징 처리 메서드
 	public Map<String, Object> paging(int count, int pageNum) {
 		int pageSize = 1; // 한 페이지에 보여질 게시글 수
 		int startRow = (pageNum-1) * pageSize + 1; // 페이지별 시작 넘버
 		int endRow = startRow + pageSize - 1; // 페이지별 끝 넘버
 		if (endRow > count) endRow = count;		
 		int no = count-startRow + 1; // 넘버링		
 		int pageBlock = 1; //페이지별 보여줄 페이징번호 개수
 		int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1); //총 페이징번호 개수		
 		int startPage = (pageNum-1)/pageBlock * pageBlock +1; // 페이지별 시작 페이징번호
 		int endPage = startPage + pageBlock -1;	// 페이지별 끝 페이징번호
 		if(endPage > pageCount) endPage = pageCount;
 		
 		Map<String, Object> pagingMap = new HashMap<>();
 		pagingMap.put("pageSize", pageSize);
 		pagingMap.put("no", no);
 		pagingMap.put("startRow", startRow);
 		pagingMap.put("endRow", endRow);
 		pagingMap.put("pageBlock", pageBlock);
 		pagingMap.put("pageCount", pageCount);
 		pagingMap.put("startPage", startPage);
 		pagingMap.put("endPage", endPage);
 		
 		return pagingMap;
 	}
    
 	
 	
 	
    @Component
    public class OrderScheduler{
    	
		/*
		 * @Scheduled(cron = "3 * * * * *") public void print() { System.out.println(new
		 * Date().toString()); }
		 */
    }
    
}