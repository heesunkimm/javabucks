package com.project.javabucksAdmin.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.javabucksAdmin.dto.BaljooDTO;
import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.dto.OrderDTO;
import com.project.javabucksAdmin.dto.OrderItem;
import com.project.javabucksAdmin.dto.PayhistoryDTO;
import com.project.javabucksAdmin.mapper.SalesMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class SalesController {
	
	@Autowired
	private SalesMapper salesMapper;
	
	
	
	//지점 계정 관리 페이지로 이동 
		@RequestMapping("/storemanage.do")
		public String storemanage(HttpServletRequest req, @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
			
			int totalCount = salesMapper.bucksListCount();
			Map<String, Object> pagingMap = paging(totalCount, pageNum);
		    // 파라미터 설정
		    Map<String, Object> params = new HashMap<>();
		    params.put("startIndex", pagingMap.get("startRow"));
			params.put("endIndex", pagingMap.get("endRow"));
		    
			List<BucksDTO> list = salesMapper.bucksList(params);
			
		    
			req.setAttribute("bucksList", list);
			req.setAttribute("startPage", (int)pagingMap.get("startPage"));
			req.setAttribute("endPage", (int)pagingMap.get("endPage"));
			req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
			req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
			
			return "account/admin_storemanage";
		}

		
	//지점 등록페이지로 이동
	@RequestMapping("/inputstore.do")
	public String inputstore() {
		return "account/admin_addstore";
	}
	
	//랜덤id생성
	@GetMapping("/generateUserId")
    @ResponseBody
    public String generateUserId() {
        return salesMapper.generateUniqueBucksId();
    }
	
	//이메일 중복 확인
	@ResponseBody
	@GetMapping("/checkEmail")
	public String checkEmail(@RequestParam("email1") String email1, @RequestParam("email2") String email2) {
		BucksDTO dto = new BucksDTO();
		dto.setBucksEmail1(email1);
		dto.setBucksEmail2(email2);
		if (salesMapper.checkEmail(dto)) {
			return "ok";
		} else {
			return "nok";
				}
	    }

	//지점 등록
	@RequestMapping(value = "/addStore.do", method = RequestMethod.POST )
	public String addBucks( @RequestParam("bucksId") String bucksId,
            @RequestParam("bucksPasswd") String bucksPasswd,
            @RequestParam("bucksName") String bucksName,
            @RequestParam("bucksOwner") String bucksOwner,
            @RequestParam("postcode") String postcode,
            @RequestParam("location") String location,
            @RequestParam("detailaddress") String detailaddress,
            @RequestParam("bucksTel1") String bucksTel1,
            @RequestParam("bucksTel2") String bucksTel2,
            @RequestParam("bucksTel3") String bucksTel3,
            @RequestParam("bucksEmail1") String bucksEmail1,
            @RequestParam("bucksEmail2") String bucksEmail2,
		@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime, RedirectAttributes redirectAttributes) {
		try {
        BucksDTO dto = new BucksDTO();
        dto.setBucksId(bucksId);
        dto.setBucksPasswd(bucksPasswd);
        dto.setBucksName(bucksName);
        dto.setBucksOwner(bucksOwner);
        dto.setBucksLocation(postcode + " " + location + " " + detailaddress);
        dto.setBucksTel1(bucksTel1);
        dto.setBucksTel2(bucksTel2);
        dto.setBucksTel3(bucksTel3);
        dto.setBucksEmail1(bucksEmail1);
        dto.setBucksEmail2(bucksEmail2);
        dto.setBucksStart(startTime);
        dto.setBucksEnd(endTime);

        
        salesMapper.addBucks(dto);
        redirectAttributes.addFlashAttribute("message", "지점이 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "등록 중 오류가 발생했습니다.");
        }

        return "redirect:/storemanage.do";
    }
	
	//특정 검색 지점 리스트 
		@ResponseBody
		@PostMapping("/searchBucks.do")
		public Map<String, Object> searchBucks(
		        @RequestParam(value = "bucksName", required = false) String bucksName,
		        @RequestParam(value = "bucksId", required = false) String bucksId,
		        @RequestParam(value = "startDate", required = false) String startDate,
		        @RequestParam(value = "endDate", required = false) String endDate,
		        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum){      


		    Map<String, Object> params = new HashMap<>();
		    params.put("bucksName", bucksName != null ? bucksName : ""); // 널값이면 빈 문자열로 처리
		    params.put("bucksId", bucksId != null ? bucksId : ""); // 널값이면 빈 문자열로 처리
		    params.put("startDate", startDate != null ? startDate : ""); // 널값이면 빈 문자열로 처리
		    params.put("endDate", endDate != null ? endDate : ""); // 널값이면 빈 문자열로 처리
		    
		    int totalCount = salesMapper.searchBucksCount(params);
		    Map<String, Object> pagingMap = paging(totalCount, pageNum);
		    
		    params.put("startIndex", pagingMap.get("startRow"));
			params.put("endIndex", pagingMap.get("endRow"));

		    // 검색 결과와 총 카운트 가져오기
		    List<BucksDTO> list = salesMapper.searchBucks(params);
		   

		    // 결과를 JSON 형태로 반환
		    Map<String, Object> response = new HashMap<>();
		    response.put("bucksList", list);
		    response.put("startPage", (int)pagingMap.get("startPage"));
		    response.put("endPage", (int)pagingMap.get("endPage"));
		    response.put("pageCount", (int)pagingMap.get("pageCount"));
		    response.put("pageBlock", (int)pagingMap.get("pageBlock"));
		    //System.out.println(pageCount);

		    return response;
		}
		
		// 페이징 처리 메서드
					public Map<String, Object> paging(int count, int pageNum) {
						int pageSize = 4; // 한 페이지에 보여질 게시글 수
						int startRow = (pageNum-1) * pageSize + 1; // 페이지별 시작 넘버
						int endRow = startRow + pageSize - 1; // 페이지별 끝 넘버
						if (endRow > count) endRow = count;		
						int no = count-startRow + 1; // 넘버링		
						int pageBlock = 3; //페이지별 보여줄 페이징번호 개수
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

	
	//지점 상세보기 
	
	@GetMapping("/editbucks.do")
	public String editStore(@RequestParam(value = "id", required = false) String bucksId, Model model) {
		//System.out.println(bucksId);
		BucksDTO bucks = salesMapper.editbucks(bucksId);
		model.addAttribute("jbucks", bucks);
		//System.out.println(bucks);
		return "account/admin_editstore";
	}
	
	
	//수정 이메일 중복 확인
			@ResponseBody
			@GetMapping("/editCheckEmail")
			public String editCheckEmail(@RequestParam("email1") String email1, @RequestParam("email2") String email2,  @RequestParam("bucksId") String bucksId) {
				BucksDTO dto = new BucksDTO();
				dto.setBucksEmail1(email1);
				dto.setBucksEmail2(email2);
				dto.setBucksId(bucksId);
				if (salesMapper.editCheckEmail(dto)) {
					return "ok";
				} else {
					return "nok";
						}
			    }
			
			//지점 수정
			@RequestMapping(value = "/editStore.do", method = RequestMethod.POST )
			public String editBucks( @RequestParam("bucksId") String bucksId,
		            @RequestParam("bucksName") String bucksName,
		            @RequestParam("bucksOwner") String bucksOwner,
		            @RequestParam("bucksTel1") String bucksTel1,
		            @RequestParam("bucksTel2") String bucksTel2,
		            @RequestParam("bucksTel3") String bucksTel3,
		            @RequestParam("bucksEmail1") String bucksEmail1,
		            @RequestParam("bucksEmail2") String bucksEmail2,
		            @RequestParam("startTime") String startTime,
					@RequestParam("endTime") String endTime,
					RedirectAttributes redirectAttributes) {
				try {
		        BucksDTO dto = new BucksDTO();
		        dto.setBucksId(bucksId);
		        dto.setBucksName(bucksName);
		        dto.setBucksOwner(bucksOwner);
		        dto.setBucksTel1(bucksTel1);
		        dto.setBucksTel2(bucksTel2);
		        dto.setBucksTel3(bucksTel3);
		        dto.setBucksEmail1(bucksEmail1);
		        dto.setBucksEmail2(bucksEmail2);
		        dto.setBucksStart(startTime);
		        dto.setBucksEnd(endTime);

		        
		        salesMapper.editBucks(dto);
		        redirectAttributes.addFlashAttribute("message", "지점정보를 업데이트했습니다.");
		        } catch (Exception e) {
		            redirectAttributes.addFlashAttribute("errorMessage", "오류가 발생했습니다.");
		        }

		        return "redirect:/storemanage.do"; // 성공 시 이동할 페이지
		    }
			
			//지점 삭제
			@RequestMapping(value = "/deleteBucks.do", method = RequestMethod.POST)
			public String deleteBucks(@RequestParam("bucksId") String bucksId,
					RedirectAttributes redirectAttributes) {
				try {
			    salesMapper.deleteBucks(bucksId);
			    redirectAttributes.addFlashAttribute("message", "지점을 삭제했습니다.");
		        } catch (Exception e) {
		            redirectAttributes.addFlashAttribute("errorMessage", "오류가 발생했습니다.");
		        }
			    return "redirect:/storemanage.do";  // 삭제 후 리다이렉트할 페이지
			}

//Sales		 
			
			//"bucksOrderSales.do" : 발주 정산관리
			@GetMapping("/bucksOrderSales.do")
			public String bucksOrderSales(Model model) {
				//List<BucksDTO> bucks = salesMapper.selectBucksName();
				List<BaljooDTO> baljooB = salesMapper.selectBaljoo();
				//model.addAttribute("bucksN", bucks);
				model.addAttribute("bucksBal", baljooB);
				
				return "sales/admin_storeordersales";
			}
			
			//검색한 지점과 날짜로 발주정산
			@PostMapping("/searchOrderSales.do")
			public String searchOrderSales(@RequestParam("orderDate") String orderDate, @RequestParam("bucksName") String bucksName, Model model) {
//			    System.out.println(bucksName);
//			    System.out.println(orderDate);
				
			    Map<String, Object> params = new HashMap<>();
			    params.put("bucksName", bucksName);
			    params.put("baljooDate", orderDate);
			    
			    List<BaljooDTO> list = salesMapper.selectOrderSum(params);
			    model.addAttribute("bucksBal", list);
			  //  System.out.println(list);			    

			    //model.addAttribute("bucksBal", result);
			    return "sales/admin_storeordersales";
			}
			
			//발주 상세리스트 수정
			@PostMapping("/viewOrderDetails.do")
			@ResponseBody
			public List<Map<String, Object>> viewOrderDetails(@RequestParam("bucksId") String bucksId, @RequestParam("orderDate") String orderDate) {
			    Map<String, Object> params = new HashMap<>();
			    params.put("bucksId", bucksId);
			    params.put("baljooDate", orderDate);

			    List<BaljooDTO> details = salesMapper.selectDetails(params);

			    // 발주 번호별로 데이터를 그룹화하여 저장할 리스트
			    List<Map<String, Object>> updateOrderList = new ArrayList<>();
			    Map<Integer, Map<String, Object>> groupedOrders = new HashMap<>();

			    // 각 발주 번호에 대한 코드 수집 및 그룹화
			    for (BaljooDTO dto : details) {
			        int baljooNum = dto.getBaljooNum();

			        // 발주 번호에 해당하는 그룹이 이미 있는지 확인
			        if (!groupedOrders.containsKey(baljooNum)) {
			            // 새로운 발주 번호 그룹 생성 및 기본 정보 추가
			            Map<String, Object> baljooOrder = new HashMap<>();
			            baljooOrder.put("baljooNum", baljooNum);  // 발주 번호
			            baljooOrder.put("baljooDate", dto.getBaljooDate());  // 발주 날짜
			            baljooOrder.put("baljooPrice", dto.getBaljooPrice());  // 발주 금액
			            baljooOrder.put("stockList", new ArrayList<Map<String, Object>>());  // 발주 품목 리스트

			            groupedOrders.put(baljooNum, baljooOrder);  // 그룹에 추가
			        }

			        // 기존 그룹에서 발주 품목 리스트를 가져옴
			        Map<String, Object> baljooOrder = groupedOrders.get(baljooNum);
			        List<Map<String, Object>> stockList = (List<Map<String, Object>>) baljooOrder.get("stockList");

			        // JSON 문자열을 파싱하여 발주 품목 정보를 추가
			        String jsonString = dto.getBaljooList().replace("[", "").replace("]", "").replace("\"", "");
			        String[] items = jsonString.split(",");

			        for (String item : items) {
			            String[] parts = item.split(":");
			            String stockCode = parts[0].trim();
			            int quantity = Integer.parseInt(parts[1].trim());

			            Map<String, Object> stockInfo = new HashMap<>();
			            stockInfo.put("stockCode", stockCode);
			            stockInfo.put("quantity", quantity);

			            // 데이터베이스에서 메뉴 이름을 조회하여 설정
			            List<Object> listName = salesMapper.getlistName(stockCode);
			            stockInfo.put("stockListName", listName);

			            stockList.add(stockInfo);
			        }
			    }

			    // 그룹화된 발주 정보를 최종 리스트에 추가
			    updateOrderList.addAll(groupedOrders.values());

			    // JSON 형식으로 반환
			    return updateOrderList;
			}

			    	


//Sales-Monthly			
			
			@GetMapping("/bucksSalesM.do")
			public String monthlyBucksSales(Model model) {
				List<PayhistoryDTO> orderList = salesMapper.monthlyBucksSales();
				model.addAttribute("list",orderList);
				return "sales/admin_monthlysales";
			}
			
			//검색한 지점과 날짜로 월별매출
			@PostMapping("/searchMonthSales.do")
			public String searchMonthSales(@RequestParam("orderDate") String orderDate, 
                    @RequestParam("bucksName") String bucksName, 
                    Model model) {

				// 검색 조건을 로그로 출력 (디버깅 용도)
//				System.out.println("검색한 지점명: " + bucksName);
//				System.out.println("검색한 날짜: " + orderDate);
				
				// 검색 조건을 Map에 추가하여 검색 수행
				Map<String, Object> params = new HashMap<>();
				params.put("bucksName", bucksName);
				params.put("monthDate", orderDate);
				
				// 검색 결과를 가져옴
				List<PayhistoryDTO> monthSal = salesMapper.searchMonth(params);
				
				// 검색 결과를 Model에 추가
				model.addAttribute("list", monthSal);
				
				// 사용자가 입력한 검색 조건을 Model에 추가하여 JSP로 전달
				model.addAttribute("orderDate", orderDate);
				model.addAttribute("bucksName", bucksName);
				
				// 결과를 보여줄 JSP 페이지로 이동
			return "sales/admin_monthlysales";
				}
							
			//월별 매출 상세보기 
			@PostMapping("/MonthlyDetails.do")
			@ResponseBody
			public Map<String, Object> MonthlyDetails(@RequestParam("bucksId") String bucksId, @RequestParam("orderDate") String orderDate, Model model) {
				Map<String, Object> params = new HashMap<>();
			    params.put("bucksId", bucksId);
			    params.put("payhistoryDate", orderDate);
			    
			    //1단계 쿼리 - 조인 해서 oredercode에 해당하는 orderList받기
			    List<OrderDTO> details = salesMapper.monthlyDetails(params);
			    //System.out.println("details : " + details);
			    
			    Map<String, Integer> categoryTotals = new HashMap<>();
			    categoryTotals.put("음료", 0);
			    categoryTotals.put("디저트", 0);
			    categoryTotals.put("MD상품", 0);
			    
			    int totalSales = 0; // 전체 매출 금액을 저장할 변수
			    
			    
			 // 2단계: orderList를 파싱
			    for (OrderDTO detail : details) {
			        String orderListJson = detail.getOrderList();

			        // 1. 대괄호 제거
			        orderListJson = orderListJson.substring(1, orderListJson.length() - 1);

			        // 2. 쉼표로 구분하여 요소 분리
			        String[] items = orderListJson.split(",");
			        
			        // 쿠폰 가져오기
			        int coupon = detail.getCpnlistnum();
			      //  System.out.println("coupon: " + coupon);
			        int couponDiscount = 0;
			        
			        // 쿠폰이 있을 경우, 쿠폰 할인 금액을 가져옴
			        if (coupon > 0) {
			            couponDiscount = salesMapper.getCouponPrice(coupon);
			       //     System.out.println("couponDiscount: " + couponDiscount);
			        }

			        int beverageTotal = 0; // 음료에 해당하는 금액의 총합
			        int dessertTotal = 0; // 디저트에 해당하는 금액의 총합
			        int mdTotal = 0; // MD상품에 해당하는 금액의 총합

			        for (String item : items) {
			            item = item.replace("\"", ""); // 큰따옴표 제거
			            String[] parts = item.split(":");

			            String menuCode = parts[0];
			            String optionId = parts[1];
			            int quantity = Integer.parseInt(parts[2]);

			            // 메뉴와 옵션 가격을 각각 가져오기
			            int price = salesMapper.getMenuPrice(menuCode);
			          //  System.out.println("price: " + price);
			            int optPrice = salesMapper.getOptPrice(optionId);
			          //  System.out.println("optPrice: " + optPrice);

			            // 메뉴 가격과 옵션 가격을 합산한 후 수량을 곱하여 금액 계산
			            int itemTotalPrice = (price + optPrice) * quantity;

			            // 카테고리별로 금액 합산
			            if (menuCode.startsWith("B")) {
			                beverageTotal += itemTotalPrice; // 음료 금액에 합산
			            } else if (menuCode.startsWith("C")) {
			                dessertTotal += itemTotalPrice; // 디저트 금액에 합산
			            } else if (menuCode.startsWith("M")) {
			                mdTotal += itemTotalPrice; // MD상품 금액에 합산
			            }
			        }

			        // 음료 총액에 쿠폰 할인을 마지막에 한 번만 적용
			        if (couponDiscount > 0) {
			            beverageTotal -= couponDiscount;
			            if (beverageTotal < 0) {
			                beverageTotal = 0; // 할인으로 인해 음수가 되지 않도록 조정
			            }
			        }

			        // 전체 매출에 합산
			        int subtotal = beverageTotal + dessertTotal + mdTotal;
			        totalSales += subtotal;

			        // 카테고리별로 금액을 categoryTotals에 추가
			        categoryTotals.put("음료", categoryTotals.getOrDefault("음료", 0) + beverageTotal);
			        categoryTotals.put("디저트", categoryTotals.getOrDefault("디저트", 0) + dessertTotal);
			        categoryTotals.put("MD상품", categoryTotals.getOrDefault("MD상품", 0) + mdTotal);
			    }
			    
			    //비중 계산
			    Map<String, Object> result = new HashMap<>();
			    
			    if (totalSales == 0) {
			        // 매출 내역이 없는 경우
			        result.put("hasSalesData", false);
			    } else {
			        // 매출 내역이 있는 경우
			        result.put("hasSalesData", true);
			        
			    for (Map.Entry<String, Integer> entry : categoryTotals.entrySet()) {
			        String category = entry.getKey();
			        int sales = entry.getValue();
			        double percentage = (double) sales / totalSales * 100; // 비중 계산 (백분율)
			        Map<String, Object> categoryData = new HashMap<>();
			        categoryData.put("totalSales", sales); // 카테고리별 총 매출
			        categoryData.put("percentage", percentage); // 카테고리별 비중
			        result.put(category, categoryData); // 결과에 추가
			    }
			    
			    result.put("totalSales", totalSales); // 전체 매출 금액도 결과에 포함
			    }
			    
			    return result;  // JSON 형식으로 반환

			}

	
//Sales-Daily	
			
			//일별 매출관리 
			@GetMapping("/bucksSalesD.do")
			public String dailyBucksSales(@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum,
					HttpServletRequest req) {
				
				int totalCount = salesMapper.dailySalesCount();
				
				
				Map<String, Object> pagingMap = paging(totalCount, pageNum);
				Map<String, Object> params = new HashMap<>();
			    params.put("startRow", pagingMap.get("startRow"));
				params.put("endRow", pagingMap.get("endRow"));
				
				List<PayhistoryDTO> orderList = salesMapper.dailyBucksSales(params);
				Integer priceList = salesMapper.dailyBucksSalesPrice();
			    if (priceList == null) {
			        priceList = 0;  // null일 경우 기본값 0 설정
			    }
				

				// 지점별로 카테고리별 매출을 저장할 Map 생성
			    Map<String, Map<String, Integer>> branchSalesMap = new HashMap<>();
			    Map<String, Integer> branchTotalSalesMap = new HashMap<>(); // 지점별 총 매출을 저장하는 맵
			    int totalSalesSum = 0;  // 전체 총 매출액
			    
			    for (PayhistoryDTO order : orderList) {
			        String orderListJson = order.getOrderList();
			        String branchName = order.getBranchName(); // 지점명
			        String branchId = order.getBucksId(); // 지점 등록번호
			        String branchOwner = order.getBucksOwner(); // 점주명
			        String payhistoryDate = order.getPayhistoryDate(); // 일자
			        int coupon = order.getCpnListNum();
			        //System.out.println("coupon: " + coupon);

			     // 지점과 날짜별 매출 데이터를 초기화
			        String branchDateKey = branchId + "_" + payhistoryDate; // 지점 ID와 날짜를 조합하여 키 생성
			       
			        branchSalesMap.putIfAbsent(branchDateKey, new HashMap<>());
			        //System.out.println(branchSalesMap);
			        Map<String, Integer> totalSalesByCategory = branchSalesMap.get(branchDateKey);
			        
			        
			        totalSalesByCategory.putIfAbsent("음료", 0);
			        totalSalesByCategory.putIfAbsent("디저트", 0);
			        totalSalesByCategory.putIfAbsent("MD상품", 0);

			        // 1. 대괄호 제거 및 쉼표로 분리
			        orderListJson = orderListJson.substring(1, orderListJson.length() - 1);
			        String[] items = orderListJson.split(",");
			        
			     // 쿠폰 가져오기
			        
			       
			        int couponDiscount = 0;

			        
			     // 쿠폰이 있을 경우, 쿠폰 할인 금액을 가져옴
			        if (coupon > 0) {
			            couponDiscount = salesMapper.getCouponPrice(coupon);
			       //     System.out.println("couponDiscount: " + couponDiscount);
			        }

			        boolean isCouponApplied = false; // 쿠폰 적용 여부를 확인하는 변수

			        // 각 아이템 처리
			        for (String item : items) {
			            // 아이템을 ":"로 분리하여 메뉴 코드, 옵션 ID, 수량 추출
			            String[] parts = item.replaceAll("[\\[\\]\"]", "").split(":");
			            String menuCode = parts[0];
			            String optionId = parts[1];
			            int quantity = Integer.parseInt(parts[2]);

			            // 카테고리 분류
			            String category = salesMapper.categorizeMenu(menuCode);

			            // 메뉴 가격 조회
			            int menuPrice = salesMapper.getMenuPrice(menuCode);
//			            System.out.println(menuPrice);
			            // 옵션 가격 조회
			            int optionPrice = salesMapper.getOptPrice(optionId);
//			            System.out.println(optionPrice);

			            // 총 가격 계산 (메뉴 가격 + 옵션 가격) * 수량
			            int totalPrice = (menuPrice + optionPrice) * quantity;
//			            System.out.println(totalPrice);
			         // 음료 카테고리에 쿠폰을 적용
			            if (!isCouponApplied && couponDiscount > 0 && category.equals("음료")) {
			                totalPrice -= couponDiscount;
			                // 쿠폰 적용 후 음수가 되지 않도록 체크
			                totalPrice = Math.max(totalPrice, 0);
			                isCouponApplied = true; // 쿠폰이 적용되었음을 표시
			            }

			         // 매출 합산 시 null 체크 후 처리
			            int currentTotal = totalSalesByCategory.getOrDefault(category, 0);
			            totalSalesByCategory.put(category, currentTotal + totalPrice);

			            // 지점별 총 매출 합산 시 null 체크 후 처리
			            branchTotalSalesMap.put(branchId, branchTotalSalesMap.getOrDefault(branchId, 0) + totalPrice);
			            
			            
			            // 각 주문 항목에 카테고리와 계산된 가격을 추가
			            order.setCategory(category); // 카테고리 설정
			            order.setTotalSales(totalPrice); // 매출액 설정
			            totalSalesSum += totalPrice;  // 총 매출액 합산
			        }
			    }

			    // 지점별 카테고리별 총 매출 데이터를 모델에 추가
			    req.setAttribute("branchSalesMap", branchSalesMap);
			    req.setAttribute("branchTotalSalesMap", branchTotalSalesMap); // 지점별 총 매출액 추가
			    //System.out.println(branchSalesMap);

			    
			 // 주문 내역 리스트를 모델에 추가
			    req.setAttribute("list", orderList);
			    //System.out.println(orderList);
			    
			  //  req.setAttribute("total", totalSalesSum);
			    req.setAttribute("total", priceList);

			    req.setAttribute("startPage", (int)pagingMap.get("startPage"));
				req.setAttribute("endPage", (int)pagingMap.get("endPage"));
				req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
				req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
			    // 결과 페이지로 이동
			    return "sales/admin_dailysales";
			}
			
			
			
			
			//검색한 지점과 날짜로 일별매출
			@RequestMapping("/searchDailySales.do")
			public String searchDailySales(@RequestParam("startDate") String startDate,
		            						@RequestParam("endDate") String endDate,
		            						@RequestParam("bucksName") String bucksName,
		            						@RequestParam("category") String category,
		            						@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum,
		            						HttpServletRequest req) {
			
				Map<String, Object> params = new HashMap<>();
			    params.put("startDate", startDate);
			    params.put("endDate", endDate);
			    params.put("bucksName", bucksName);
				
			    int totalCount = salesMapper.searchDSalesCount(params);
			   // System.out.println(totalCount);
			    Map<String, Object> pagingMap = paging(totalCount, pageNum);
			    params.put("startRow", pagingMap.get("startRow"));
				params.put("endRow", pagingMap.get("endRow"));
			    
			    List<PayhistoryDTO> orderList = salesMapper.searchDailySales(params);
				//System.out.println(orderList);
			    
			 /// 지점별로 일자별 매출을 저장할 Map 생성
			    Map<String, Map<String, Integer>> branchSalesMap = new HashMap<>();
			    Map<String, Integer> branchTotalSalesMap = new HashMap<>(); // 지점별 총 매출을 저장하는 맵
			    int totalSalesSum = 0;  // 전체 총 매출액
			    
			    for (PayhistoryDTO order : orderList) {
			        String orderListJson = order.getOrderList();
			        String branchName = order.getBranchName(); // 지점명
			        String branchId = order.getBucksId(); // 지점 등록번호
			        String branchOwner = order.getBucksOwner(); // 점주명
			        String payhistoryDate = order.getPayhistoryDate(); // 일자
			        int coupon = order.getCpnListNum();
			        //System.out.println("coupon: " + coupon);
			        int couponDiscount = 0;


			     // 지점과 날짜별 매출 데이터를 초기화
			        String branchDateKey = branchId + "_" + payhistoryDate; // 지점 ID와 날짜를 조합하여 키 생성
			        branchSalesMap.putIfAbsent(branchDateKey, new HashMap<>());
			        Map<String, Integer> totalSalesByCategory = branchSalesMap.get(branchDateKey);
			        
			     // 카테고리별 초기화
			        if ("음료".equals(category) || "".equals(category)) {
			            totalSalesByCategory.putIfAbsent("음료", 0);
			        }
			        if ("디저트".equals(category) || "".equals(category)) {
			            totalSalesByCategory.putIfAbsent("디저트", 0);
			        }
			        if ("MD상품".equals(category) || "".equals(category)) {
			            totalSalesByCategory.putIfAbsent("MD상품", 0);
			        }
			        
			     // 쿠폰이 있을 경우, 쿠폰 할인 금액을 가져옴
			        if (coupon > 0) {
			            couponDiscount = salesMapper.getCouponPrice(coupon);
			        }

			        boolean isCouponApplied = false; // 쿠폰이 적용되었는지 확인하는 변수

			        // 1. 대괄호 제거 및 쉼표로 분리
			        orderListJson = orderListJson.substring(1, orderListJson.length() - 1);
			        String[] items = orderListJson.split(",");

			        // 각 아이템 처리
			        for (String item : items) {
			            // 아이템을 ":"로 분리하여 메뉴 코드, 옵션 ID, 수량 추출
			            String[] parts = item.replaceAll("[\\[\\]\"]", "").split(":");
			            String menuCode = parts[0];
			            String optionId = parts[1];
			            int quantity = Integer.parseInt(parts[2]);

			            // 카테고리 분류
			            String cate = salesMapper.categorizeMenu(menuCode);

			            int menuPrice = salesMapper.getMenuPrice(menuCode);
			            int optionPrice = salesMapper.getOptPrice(optionId);
			            int totalPrice = (menuPrice + optionPrice) * quantity;
			            
			         // 카테고리 코드에 따라 이름 매핑
			            if ("B".equals(cate)) {
			                cate = "음료";
			            } else if ("C".equals(cate)) {
			                cate = "디저트";
			            } else if ("M".equals(cate)) {
			                cate = "MD상품";
			            }
			            
			         // 디버깅용 출력
			            //System.out.println("카테고리 코드: " + cate + ", 선택된 카테고리: " + category);

			            // 선택된 카테고리와 비교 (코드와 매핑된 이름 비교)
			            if (!"".equals(category) && !cate.equals(category)) {
			                continue; // 선택된 카테고리에 맞지 않으면 스킵
			            }
			            
			         // 쿠폰을 음료 카테고리에만 적용
			            if (!isCouponApplied && couponDiscount > 0 && "음료".equals(cate)) {
			                totalPrice -= couponDiscount;
			                totalPrice = Math.max(totalPrice, 0); // 할인 후 가격이 음수일 경우 0으로 설정
			                isCouponApplied = true; // 쿠폰이 적용되었음을 표시
			            }

			            // 해당 카테고리의 매출 합산
			            totalSalesByCategory.put(cate, totalSalesByCategory.get(cate) + totalPrice);

			            // 각 주문 항목에 카테고리와 계산된 가격을 추가
			            order.setCategory(cate); // 카테고리 설정
			            order.setTotalSales(totalPrice); // 매출액 설정
			            
			            totalSalesSum += totalPrice;  // 총 매출액 합산
			            
			            branchTotalSalesMap.put(branchId, branchTotalSalesMap.getOrDefault(branchId, 0) + totalPrice);
			            
			         // 정상적으로 매핑되었을 때 출력
			            //System.out.println("cate after mapping: " + cate);
			        }
			    }
			    
			    try {
			        int startPage2 = (int) pagingMap.get("startPage");
			        req.setAttribute("startPage2", startPage2);
			    } catch (NullPointerException e) {
			        //System.err.println("startPage is null");
			        req.setAttribute("startPage2", 0); // 기본값 설정
			    }
			    
			    for (Map.Entry<String, Object> entry : pagingMap.entrySet()) {
			       // System.out.println("Key: " + entry.getKey() + ", Value: " + entry.getValue());
			    }

			    // 지점별 카테고리별 총 매출 데이터를 모델에 추가
			    req.setAttribute("branchSalesMap", branchSalesMap);
			    req.setAttribute("branchTotalSalesMap", branchTotalSalesMap); // 지점별 총 매출액 추가
			    //System.out.println(branchSalesMap);

			    // 주문 내역 리스트를 모델에 추가
			    req.setAttribute("list", orderList);
			   // System.out.println(orderList);
			    
			    req.setAttribute("total", totalSalesSum);
			    
			 // 검색 조건을 모델에 추가
			    req.setAttribute("startDate", startDate);
			    req.setAttribute("endDate", endDate);
			    req.setAttribute("bucksName", bucksName);
			    req.setAttribute("category", category);
			    
				req.setAttribute("startPage2", (int)pagingMap.get("startPage"));
				req.setAttribute("endPage2", (int)pagingMap.get("endPage"));
				req.setAttribute("pageCount2", (int)pagingMap.get("pageCount"));
				req.setAttribute("pageBlock2", (int)pagingMap.get("pageBlock"));
				
				// NullPointerException 방지용 null 체크 및 기본값 설정
			    req.setAttribute("startPage2", pagingMap.getOrDefault("startPage", 0));
			    req.setAttribute("endPage2", pagingMap.getOrDefault("endPage", 0));
			    req.setAttribute("pageCount2", pagingMap.getOrDefault("pageCount", 0));
			    req.setAttribute("pageBlock2", pagingMap.getOrDefault("pageBlock", 0));

			    // 결과 페이지로 이동
			    return "sales/admin_dailysales";
			}
			
            
			

			
	
}
	
	
	
	

