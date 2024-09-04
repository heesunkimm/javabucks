package com.project.javabucksStore.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksStore.dto.BaljooDTO;
import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.PayhistoryDTO;
import com.project.javabucksStore.mapper.SalesMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class SalesController {
	
	@Autowired
	SalesMapper salesMapper;
	
	//발주관리
	@GetMapping("/store_baljooManage.do")
	public String baljooManage(@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size, Model model, HttpServletRequest req) {
		 
		  HttpSession session = req.getSession();
	      BucksDTO bdto = (BucksDTO)session.getAttribute("inBucks");
	      String bucksId = bdto.getBucksId();
	      
		
		List<BaljooDTO> list = salesMapper.baljooList(bucksId);
				
		// 총 발주 금액 계산 (전체 리스트의 합계)
	    double totalBaljooPrice = 0;
	    for (BaljooDTO dto : list) {
	        if ("접수완료".equals(dto.getBaljooStatus()) && dto.getBaljooPrice() != 0) { 
	            totalBaljooPrice += dto.getBaljooPrice();
	        }
	    }
		
		// 페이징 처리
        int total = list.size(); // 전체 데이터 개수
        int start = (page - 1) * size; // 시작 인덱스
        int end = Math.min(start + size, total); // 종료 인덱스

        // 시작 인덱스가 전체 리스트의 크기보다 크면 빈 리스트 반환 (예: 잘못된 페이지 번호 요청 시)
        List<BaljooDTO> paginatedDetails = start > total ? Collections.emptyList() : list.subList(start, end);
		
		List<Map<String, Object>> updateOrderList = new ArrayList<>();
		

        for (BaljooDTO dto : paginatedDetails) {
            Map<String, Object> baljooOrder = new HashMap<>();
            baljooOrder.put("baljooNum", dto.getBaljooNum());  
            baljooOrder.put("baljooDate", dto.getBaljooDate());  
            baljooOrder.put("baljooPrice", dto.getBaljooPrice()); 
            baljooOrder.put("baljooStatus", dto.getBaljooStatus()); 
            baljooOrder.put("stockList", new ArrayList<Map<String, Object>>());  
            

         // 발주 리스트가 null이 아닌지 확인
            if (dto.getBaljooList() != null) {
                String jsonString = dto.getBaljooList().replace("[", "").replace("]", "").replace("\"", "");
                String[] items = jsonString.split(",");

                for (String item : items) {
                    String[] parts = item.split(":");
                    String stockCode = parts[0].trim();
                    int quantity = Integer.parseInt(parts[1].trim());

                    // stockCode가 null 또는 빈 문자열이 아닌지 확인
                    if (stockCode != null && !stockCode.isEmpty()) {
                        Map<String, Object> stockInfo = salesMapper.getStockInfo(stockCode);

                        // stockInfo가 null인 경우 처리
                        if (stockInfo == null) {
                            stockInfo = new HashMap<>();
                            stockInfo.put("error", "해당 상품 정보를 찾을 수 없습니다.");
                        }

                        stockInfo.put("quantity", quantity);

                        ((List<Map<String, Object>>) baljooOrder.get("stockList")).add(stockInfo);
                    }
                }
            }

            updateOrderList.add(baljooOrder);
        }

        model.addAttribute("updateOrderList", updateOrderList);
        model.addAttribute("totalBaljooPrice", totalBaljooPrice);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", (total + size - 1) / size);

        return "sales/store_baljooManage";
    }
	
	
	@RequestMapping("/searchBaljoo.do")
	public String searchBaljoo(@RequestParam("year") int year,
            @RequestParam("month") int month , @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size, Model model, HttpServletRequest req) {
			
		
		HttpSession session = req.getSession();
	      BucksDTO bdto = (BucksDTO)session.getAttribute("inBucks");
	      String bucksId = bdto.getBucksId();
	     // System.out.println(bucksId);
		//System.out.println(year);
		
		Map<String, Object> params = new HashMap<>();
        params.put("userId", bucksId);
        params.put("year", year);
        params.put("month", month);

		
		List<BaljooDTO> list = salesMapper.searchBaljooList(params);
		
		// 총 발주 금액 계산 (전체 리스트의 합계)
	    double totalBaljooPrice = 0;
	    for (BaljooDTO dto : list) {
	    	if ("접수완료".equals(dto.getBaljooStatus())) { 
	            totalBaljooPrice += dto.getBaljooPrice();
	        }
	    }
		
		// 페이징 처리
        int total = list.size(); // 전체 데이터 개수
        int start = (page - 1) * size; // 시작 인덱스
        int end = Math.min(start + size, total); // 종료 인덱스

        // 시작 인덱스가 전체 리스트의 크기보다 크면 빈 리스트 반환 (예: 잘못된 페이지 번호 요청 시)
        List<BaljooDTO> paginatedDetails = start > total ? Collections.emptyList() : list.subList(start, end);

		List<Map<String, Object>> updateOrderList = new ArrayList<>();
		

       for (BaljooDTO dto : paginatedDetails) {
           Map<String, Object> baljooOrder = new HashMap<>();
           baljooOrder.put("baljooNum", dto.getBaljooNum());  
           baljooOrder.put("baljooDate", dto.getBaljooDate());  
           baljooOrder.put("baljooPrice", dto.getBaljooPrice()); 
           baljooOrder.put("baljooStatus", dto.getBaljooStatus()); 
           baljooOrder.put("stockList", new ArrayList<Map<String, Object>>());  
           
           

           String jsonString = dto.getBaljooList().replace("[", "").replace("]", "").replace("\"", "");
           String[] items = jsonString.split(",");

           for (String item : items) {
               String[] parts = item.split(":");
               String stockCode = parts[0].trim();
               int quantity = Integer.parseInt(parts[1].trim());

               Map<String, Object> stockInfo = salesMapper.getStockInfo(stockCode);

               stockInfo.put("quantity", quantity);

               ((List<Map<String, Object>>) baljooOrder.get("stockList")).add(stockInfo);
           }

           updateOrderList.add(baljooOrder);
       }
       model.addAttribute("updateOrderList", updateOrderList);
       //System.out.println(updateOrderList);
       
       model.addAttribute("totalBaljooPrice", totalBaljooPrice);
       
       model.addAttribute("currentPage", page);
       model.addAttribute("totalPages", (total + size - 1) / size);
		
		return "sales/store_baljooManage";
	}
	
	//매출관리 
	
	
	@RequestMapping("/store_sales.do")
	public String allStoreSales(Model model, HttpServletRequest req, 
			@RequestParam(value = "page", required = false, defaultValue = "1") int pageNum) {
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		 // 페이징 처리 변수 설정
		int pageSize = 5; 
	    int startRow = (pageNum - 1) * pageSize + 1;  // 1부터 시작하는 행 번호
	    int endRow = pageNum * pageSize;  // 마지막 행 번호
	    
	    // 총 매출 항목 수 계산
	    int totalSalesCount = salesMapper.getSalesCount(bucksId);
	    int totalSalesAmount = salesMapper.getTotalSalesAmount(bucksId);
	    int totalPageCount = (totalSalesCount / pageSize) + (totalSalesCount % pageSize == 0 ? 0 : 1);
	    int startPage = Math.max(1, pageNum - 2);
	    int endPage = Math.min(totalPageCount, startPage + 2);

	    // 현재 페이지에 해당하는 매출 데이터 조회
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("bucksId", bucksId);
	    searchParams.put("startRow", startRow);
	    searchParams.put("endRow", endRow);
	    
	    List<PayhistoryDTO> salesList = salesMapper.getSalesList(searchParams);
//        System.out.println("StartRow: " + startRow);
//        System.out.println("EndRow: " + endRow);
//        System.out.println("BucksId: " + bucksId);
//        System.out.println("salesList: " + salesList);
        
        if (salesList == null) {
            salesList = new ArrayList<>();
        }

        for (PayhistoryDTO order : salesList) {
            String orderListJson = order.getOrderList();
            int payhistoryPrice = order.getPayhistoryPrice();
            String orderCode = order.getOrderCode();

            // orderCode가 null이 아닌지 확인
            if (orderCode != null && !orderCode.isEmpty()) {
                String[] parts = orderCode.split("_");
                if (parts.length > 1) {
                    String extractedCode = parts[1];
                    order.setExtractedOrderCode(extractedCode); // 추출한 값을 DTO에 설정
                }
            }

            // orderListJson이 null이 아닌지 확인
            if (orderListJson != null && !orderListJson.isEmpty()) {
                orderListJson = orderListJson.substring(1, orderListJson.length() - 1);
                String[] items = orderListJson.split(",");
                StringBuilder menuNames = new StringBuilder();
                for (String item : items) {
                    String[] parts = item.replaceAll("[\\[\\]\"]", "").split(":");
                    if (parts.length >= 3) {
                        String menuCode = parts[0];
                        int quantity = Integer.parseInt(parts[2]);

                        String menuName = salesMapper.getMenuName(menuCode);
                        if (menuName != null && !menuName.isEmpty()) {
                            if (menuNames.length() > 0) {
                                menuNames.append("<br>");
                            }
                            menuNames.append(menuName).append(" x ").append(quantity);
                        }
                    }
                }
                order.setMenuName(menuNames.toString().trim());
            }
        }

        model.addAttribute("salesList", salesList);
        model.addAttribute("totalSalesCount", totalSalesCount);
        model.addAttribute("currentPage", pageNum);
        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalSalesAmount", totalSalesAmount);

        return "sales/store_salesmanage";
    }
	
	@RequestMapping("/store_searchSales.ajax")
	@ResponseBody
	public Map<String, Object> filterStoreSales(HttpServletRequest req, 
            @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate) {
			HttpSession session = req.getSession();
			BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
			String bucksId = dto.getBucksId();
			
//			System.out.println(startDate);
//			System.out.println(endDate);
			
			// 페이징 처리 변수 설정
			int pageSize = 5;
			int startRow = (pageNum - 1) * pageSize + 1;
			int endRow = pageNum * pageSize;
			
			// 총 매출 항목 수 계산 (기간 필터링 추가)
			Map<String, Object> countParams = new HashMap<>();
			countParams.put("bucksId", bucksId);
			countParams.put("startDate", startDate);
			countParams.put("endDate", endDate);
			int totalSalesCount = salesMapper.searchSalesCount(countParams);
			
			// 전체 매출액 합계 계산 (기간 필터링 추가)
			Integer totalSalesAmount = salesMapper.searchTotalSalesAmount(countParams);
			if (totalSalesAmount == null) {
			    totalSalesAmount = 0;  // 기본값 0으로 설정
			}
			//System.out.println("totalSalesAmount : "+totalSalesAmount);
			// 페이징에 필요한 추가 정보 계산
			int totalPageCount = (totalSalesCount / pageSize) + (totalSalesCount % pageSize == 0 ? 0 : 1);
			int startPage = Math.max(1, pageNum - 2);
	        int endPage = Math.min(totalPageCount, startPage + 4);
			
			// 현재 페이지에 해당하는 매출 데이터 조회
			countParams.put("startRow", startRow);
			countParams.put("endRow", endRow);
			List<PayhistoryDTO> salesList = salesMapper.getFilteredSalesList(countParams);
			
			for (PayhistoryDTO order : salesList) {
				String orderListJson = order.getOrderList();
				String orderCode = order.getOrderCode();
				
				
				if (orderCode != null && !orderCode.isEmpty()) {
					String[] parts = orderCode.split("_");
					String extractedCode = parts[1];
					order.setExtractedOrderCode(extractedCode); // 추출한 값을 DTO에 설정
				}
				
		        if (orderListJson != null && !orderListJson.isEmpty()) {
		            orderListJson = orderListJson.substring(1, orderListJson.length() - 1);
		            String[] items = orderListJson.split(",");
		            StringBuilder menuNames = new StringBuilder();
		            for (String item : items) {
		                String[] parts = item.replaceAll("[\\[\\]\"]", "").split(":");
		                String menuCode = parts[0];
		                int quantity = Integer.parseInt(parts[2]);
		                
		                String menuName = salesMapper.getMenuName(menuCode);
		                if (menuNames.length() > 0) {
		                    menuNames.append("<br>");
		                }
		                menuNames.append(menuName).append(" x ").append(quantity);
		            }
		            order.setMenuName(menuNames.toString().trim());
		        } else {
		            order.setMenuName("주문 내역 없음");
		        }
		    }
		    
		    Map<String, Object> result = new HashMap<>();
		    result.put("salesList", salesList);
		    result.put("totalSalesCount", totalSalesCount);
		    result.put("totalSalesAmount", totalSalesAmount);
		    result.put("currentPage", pageNum);
		    result.put("totalPageCount", totalPageCount);
		    result.put("startPage", startPage);
		    result.put("endPage", endPage);
		    //System.out.println("result : " + result);
		    
		    return result;
		}
	
	@RequestMapping("/store_selectCate.ajax")
	@ResponseBody
	public Map<String, Object> selectCateSales(HttpServletRequest req, 
	        @RequestParam(value = "menu_cate", required = false) String menuCate,
	        @RequestParam(value = "disert_cate", required = false) String disertCate,
	        @RequestParam(value = "Md_cate", required = false) String mdCate,
	        @RequestParam(value = "pageNum", defaultValue = "1") int pageNum){

	    String selectedCate = null;
	    if (menuCate != null && !menuCate.trim().isEmpty()) {
	        selectedCate = menuCate;
	    } else if (disertCate != null && !disertCate.trim().isEmpty()) {
	        selectedCate = disertCate;
	    } else if (mdCate != null && !mdCate.trim().isEmpty()) {
	        selectedCate = mdCate;
	    }
	    
	    HttpSession session = req.getSession();
	    BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
	    String bucksId = dto.getBucksId();

	    // 전체 매출 데이터 가져오기
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("bucksId", bucksId);
	    List<PayhistoryDTO> salesList = salesMapper.getselectCateList(searchParams);

	    int totalSalesAmount = 0;
	    List<PayhistoryDTO> filteredSalesList = new ArrayList<>();
	    
	    for (PayhistoryDTO order : salesList) {
	        String orderListJson = order.getOrderList();
	        int payhistoryPrice = order.getPayhistoryPrice(); // 주문의 기본 가격
	        String orderCode = order.getOrderCode();
	        int coupon = order.getCpnListNum();
	        int couponDiscount = 0;
	        boolean couponApplied = false;  // 쿠폰이 적용되었는지 여부 확인 변수
	        
	        // 쿠폰이 있을 경우, 쿠폰 할인 금액을 가져옴
	        if (coupon > 0) {
	            couponDiscount = salesMapper.getCouponPrice(coupon);
	        }

	        if (orderCode != null && !orderCode.isEmpty()) {
	            String[] parts = orderCode.split("_");
	            String extractedCode = parts[1];
	            order.setExtractedOrderCode(extractedCode); // 추출한 값을 DTO에 설정
	        }

	        if (orderListJson != null && !orderListJson.isEmpty()) {
	            orderListJson = orderListJson.substring(1, orderListJson.length() - 1);
	            String[] items = orderListJson.split(",");
	            StringBuilder menuNames = new StringBuilder();
	            int totalItemPrice = 0;
	            
	            for (String item : items) {
	                String[] parts = item.replaceAll("[\\[\\]\"]", "").split(":");
	                String menucode = parts[0];
	                String optioncode = parts[1]; 
	                int quantity = Integer.parseInt(parts[2]);

	                // menucode에서 카테고리와 서브코드 추출
	                char category = menucode.charAt(0); // 첫 번째 문자로 카테고리 구분
	                String subcode = menucode.substring(1, 3); // 2번째와 3번째 코드

	                // selectedCate의 길이에 따라 다르게 처리
	                if (selectedCate != null) {
	                    if ((selectedCate.length() == 1 && selectedCate.charAt(0) == category) || 
	                        (selectedCate.length() == 2 && selectedCate.equals(subcode))) {
	                        PayhistoryDTO menuDTO = salesMapper.getMenuNameByCode(menucode); // 메뉴 이름 가져오기
	                        String menuName = menuDTO.getMenuName(); 
	                        int menuPrice = menuDTO.getMenuPrice();
	                        int optionPrice = salesMapper.getOptionPriceByCode(optioncode); // 옵션 가격 가져오기

	                        // 쿠폰을 아직 적용하지 않았고, 적용 가능 항목이라면
	                        if (!couponApplied && category == 'B') {  // 'B'는 음료 카테고리라고 가정
	                            menuPrice -= couponDiscount; // 쿠폰 할인 적용
	                            couponApplied = true;  // 쿠폰이 한 번만 적용되도록 설정
	                        }

	                        if (menuNames.length() > 0) {
	                            menuNames.append("<br>"); 
	                        }
	                        menuNames.append(menuName).append(" x ").append(quantity);

	                        // 메뉴 가격과 옵션 가격의 합에 수량을 곱하여 총 금액 계산
	                        totalItemPrice += (menuPrice + optionPrice) * quantity;
	                    }
	                }
	            }
	            
	            // 최종적으로 한번만 리스트에 추가
	            if (totalItemPrice > 0) {
	                order.setMenuName(menuNames.toString().trim());
	                totalSalesAmount += totalItemPrice;
	                order.setTotalItemPrice(totalItemPrice);
	                filteredSalesList.add(order);
	            }
	        }
	    }

	    Map<String, Object> result = new HashMap<>();
	    result.put("salesList", filteredSalesList); // 모든 필터링된 데이터 반환
	    result.put("totalSalesAmount", totalSalesAmount); // 총 매출 금액
	    return result;
	}

				
				
}
