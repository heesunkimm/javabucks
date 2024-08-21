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

import com.project.javabucksAdmin.dto.BaljooDTO;
import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.dto.OrderDTO;
import com.project.javabucksAdmin.dto.OrderItem;
import com.project.javabucksAdmin.dto.PayhistoryDTO;
import com.project.javabucksAdmin.mapper.SalesMapper;

@Controller
public class SalesController {
	
	@Autowired
	private SalesMapper salesMapper;
	
	//시작
	@RequestMapping("/")
	public String index() {
		return "account/admin_index";
	}
	
	//지점 계정 관리 페이지로 이동 
		@RequestMapping("/storemanage.do")
		public String storemanage(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
			
			int itemsPerPage = 5; // 한 페이지에 보여질 리뷰 수
		    int startIndex = (page - 1) * itemsPerPage; // 시작 인덱스 수정
		    int endIndex = page * itemsPerPage; // 끝 인덱스 수정
		    
		    // 파라미터 설정
		    Map<String, Object> params = new HashMap<>();
		    params.put("startIndex", startIndex);
		    params.put("endIndex", endIndex);
		    System.out.println(startIndex);
		    System.out.println(endIndex);
		    
			List<BucksDTO> list = salesMapper.bucksList(params);
			int totalCount = salesMapper.bucksListCount();
		    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산
		    
			model.addAttribute("bucksList", list);
			model.addAttribute("currentPage", page);
			model.addAttribute("pageCount", pageCount);
			
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
            @RequestParam("bucksEmail2") String bucksEmail2) {
       
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

        
        salesMapper.addBucks(dto);

        return "account/admin_storemanage"; // 성공 시 이동할 페이지
    }
	
	//특정 검색 지점 리스트 
		@ResponseBody
		@PostMapping("/searchBucks.do")
		public Map<String, Object> searchBucks(
		        @RequestParam(value = "bucksName", required = false) String bucksName,
		        @RequestParam(value = "bucksId", required = false) String bucksId,
		        @RequestParam(value = "bucksLocation", required = false) String bucksLocation,
		        @RequestParam(value = "startDate", required = false) String startDate,
		        @RequestParam(value = "endDate", required = false) String endDate,
		        @RequestParam(value = "page", defaultValue = "1") int page) {

		    int itemsPerPage = 5; // 한 페이지에 보여줄 항목 수
		    int startIndex = (page - 1) * itemsPerPage + 1;
		    int endIndex = page * itemsPerPage;

		    Map<String, Object> params = new HashMap<>();
		    params.put("bucksName", bucksName);
		    params.put("bucksId", bucksId);
		    params.put("bucksLocation", bucksLocation);
		    params.put("startDate", startDate);
		    params.put("endDate", endDate);
		    params.put("startIndex", startIndex);
		    params.put("endIndex", endIndex);
		    System.out.println(startIndex);
		    System.out.println(endIndex);

		    // 검색 결과와 총 카운트 가져오기
		    List<BucksDTO> list = salesMapper.searchBucks(params);
		    int totalCount = salesMapper.searchBucksCount(params);
		    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage);

		    // 결과를 JSON 형태로 반환
		    Map<String, Object> response = new HashMap<>();
		    response.put("bucksList", list);
		    response.put("currentPage", page);
		    response.put("pageCount", pageCount);
		    System.out.println(pageCount);

		    return response;
		}

	
	//지점 상세보기 
	
	@GetMapping("/editbucks.do")
	public String editStore(@RequestParam(value = "id", required = false) String bucksId, Model model) {
		System.out.println(bucksId);
		BucksDTO bucks = salesMapper.editbucks(bucksId);
		model.addAttribute("jbucks", bucks);
		System.out.println(bucks);
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
		            @RequestParam("bucksEmail2") String bucksEmail2) {
		       
		        BucksDTO dto = new BucksDTO();
		        dto.setBucksId(bucksId);
		        dto.setBucksName(bucksName);
		        dto.setBucksOwner(bucksOwner);
		        dto.setBucksTel1(bucksTel1);
		        dto.setBucksTel2(bucksTel2);
		        dto.setBucksTel3(bucksTel3);
		        dto.setBucksEmail1(bucksEmail1);
		        dto.setBucksEmail2(bucksEmail2);

		        
		        salesMapper.editBucks(dto);

		        return "redirect:/storemanage.do"; // 성공 시 이동할 페이지
		    }
			
			//지점 삭제
			@RequestMapping(value = "/deleteBucks.do", method = RequestMethod.POST)
			public String deleteBucks(@RequestParam("bucksId") String bucksId) {
			    salesMapper.deleteBucks(bucksId);
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
			    System.out.println(bucksName);
			    System.out.println(orderDate);
				
			    Map<String, Object> params = new HashMap<>();
			    params.put("bucksName", bucksName);
			    params.put("baljooDate", orderDate);
			    
			    List<BaljooDTO> list = salesMapper.selectOrderSum(params);
			    model.addAttribute("bucksBal", list);
			    System.out.println(list);			    

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

			    	
//			        String baljooListStr = dto.getBaljooList();
//			        int orderNum = dto.getBaljooNum(); // 발주 넘버 가져오기 (int)
//
//			        // 대괄호와 따옴표를 제거하여 순수한 문자열 목록으로 변환
//			        baljooListStr = baljooListStr.replaceAll("[\\[\\]\"]", "");
//			        String[] items = baljooListStr.split(",");
//
//			        // 발주 넘버별 코드 리스트 관리
//			        orderCodeMap.putIfAbsent(orderNum, new ArrayList<>());
//			        List<String> codes = orderCodeMap.get(orderNum);
//
//			        for (String item : items) {
//			            // 항목을 :로 나누어 코드와 수량을 추출
//			            String[] parts = item.split(":");
//			            if (parts.length == 2) {
//			                // parts[0]는 코드, parts[1]는 수량
//			                String code = parts[0].trim();
//			                codes.add(code);
//			            } else {
//			                System.err.println("Invalid item format: " + item);
//			            }
//			        }
//
//			        // 디버깅용: 각 발주 넘버별로 수집된 코드를 출력
//			        System.out.println("Order Number: " + orderNum + ", Codes Collected: " + codes);
//			    
//
//			    if (codes != null && !codes.isEmpty()) {
//		            // 매퍼 호출은 각 발주 번호마다 개별적으로 수행
//		            List<String> stockNames = salesMapper.baljooNamesByCodes(codes);
//
//		            // 디버깅용: 매퍼에서 가져온 결과를 출력
//		            System.out.println("Mapper Console for Order Number: " + orderNum + " : " + stockNames);
//
//		            String baljooListStr1 = dto.getBaljooList();
//		            baljooListStr1 = baljooListStr1.replaceAll("[\\[\\]\"]", "");
//		            String[] items1 = baljooListStr1.split(",");
//
//		            StringBuilder updatedList = new StringBuilder();
//
//		            for (int i = 0; i < items1.length; i++) {
//		                String[] parts = items1[i].split(":");
//		                if (parts.length == 2) {
//		                    String stockName = stockNames.get(i);
//		                    int quantity = Integer.parseInt(parts[1].trim());
//
//		                    if (updatedList.length() > 0) {
//		                        updatedList.append(","); // 이전 항목과 쉼표로 구분
//		                    }
//		                    updatedList.append(stockName).append(":").append(quantity);
//		                }
//		            }
//
//		            // 변경된 발주 리스트를 DTO에 다시 설정
//		            dto.setBaljooList(updatedList.toString());
//		        }
//		    }
//
//		    // 모델에 수정된 데이터 추가
//		    model.addAttribute("details", details);
//
//		    return "sales/admin_storeordersales";
//		}
			
			
			
			
//			
//			//발주 상세리스트 ......ㅋㅋㅋㅋㅋㅋ너무 멀리간코드 포함,,,,,,, //S 이부분분터 월별매출 카테고리별로 묶을떄 참고,,,,,
//			@ResponseBody
//			@PostMapping("/viewOrderDetails.do")
//			public String viewOrderDetails(@RequestParam("bucksId") String bucksId, @RequestParam("orderDate") String orderDate, Model model) {
//			    Map<String, Object> params = new HashMap<>();
//			    params.put("bucksId", bucksId);
//			    params.put("baljooDate", orderDate);
//			    System.out.println(bucksId);
//			    System.out.println(orderDate);
//			    
//			    List<BaljooDTO> details = salesMapper.selectDetails(params);
//			    
//			 // 디버깅: 조회된 발주 상세 리스트 확인
//			    System.out.println("Retrieved Details: " + details);
//
//			 // 코드별로 총 수량을 합산하기 위한 Map
//			    Map<String, Integer> codeQuantityMap = new HashMap<>();
//
//			    for (BaljooDTO detail : details) {
//			        System.out.println("Processing detail: " + detail);
//
//			        // 발주 리스트를 ,로 나누어 각 항목을 추출
//			        String[] items = detail.getTotaljooList().replaceAll("[\\[\\]\"]", "").split(",");
//			        System.out.println("Parsed items: " + Arrays.toString(items));
//
//			        for (String item : items) {
//			            // 항목을 :로 나누어 코드와 수량을 추출
//			            String[] parts = item.split(":");
//			            String code = parts[0];
//			            int quantity = Integer.parseInt(parts[1]);
//
//			            System.out.println("Code: " + code + ", Quantity: " + quantity);
//
//			            // 같은 코드가 이미 존재하면 수량을 합산
//			            if (codeQuantityMap.containsKey(code)) {
//			                codeQuantityMap.put(code, codeQuantityMap.get(code) + quantity);
//			            } else {
//			                codeQuantityMap.put(code, quantity);
//			            }
//			        }
//			    }
//
//			    // 디버깅: 합산된 코드별 총 수량 확인
//			    for (Map.Entry<String, Integer> entry : codeQuantityMap.entrySet()) {
//			        System.out.println("Code: " + entry.getKey() + ", Total Quantity: " + entry.getValue());
//			    }
//			    
//			 // 합산된 코드 목록을 사용하여 가격 정보 조회
//			    List<String> codes = new ArrayList<>(codeQuantityMap.keySet());
//			    System.out.println("Codes: " + codes);
//			    List<Map<String, Object>> rawResults = salesMapper.selectPricesByCodes(codes); // 결과를 List<Map<String, Object>> 형태로 받음
//			    System.out.println("rawResults : " + rawResults);
//
//			    // 1. HashMap을 BaljooSubDTO로 수동 매핑
//			    List<BaljooSubDTO> priceDetails = new ArrayList<>();
//			   
//
//			    for (Map<String, Object> rawResult : rawResults) {
//			        BaljooSubDTO dto = new BaljooSubDTO();
//
//			        // 키 이름을 모두 대문자로 변경하여 사용해보세요
//			        String code = (String) rawResult.get("CODE");  // 'code' 대신 'CODE'로 접근
//			        Object priceObj = rawResult.get("PRICE");  // 'price' 대신 'PRICE'로 접근
//
//			        if (code == null || priceObj == null) {
//			            System.out.println("Null value encountered: Code=" + code + ", Price=" + priceObj);
//			            continue;  // null 값이 있는 경우를 건너뜁니다.
//			        }
//
//			        // DTO에 값 설정
//			        dto.setCode(code);
//			        dto.setPrice(new BigDecimal(priceObj.toString()));
//
//			        // DTO를 리스트에 추가하기 전에 출력해보기
//			        System.out.println("Adding DTO: " + dto);
//			        
//			        // DTO를 리스트에 추가
//			        priceDetails.add(dto);
//			    }
//
//			    // 최종 리스트 출력
//			    System.out.println("Mapped priceDetails: " + priceDetails);
//
//			    // 2. 코드별로 totalQuantity와 totalPrice를 누적 계산하기 위한 Map 생성
//			    Map<String, BaljooSubDTO> codeSummaryMap = new HashMap<>();
//
//			    for (BaljooSubDTO item : priceDetails) {  // priceDetails 리스트의 각 항목을 순회
//			        String code = item.getCode();  // 현재 항목의 코드를 가져옴
//			        BigDecimal price = item.getPrice();  // 현재 항목의 가격을 가져옴
//			        
//			        // Map에서 해당 코드의 누적 정보를 가져옴 (없으면 초기화)
//			        BaljooSubDTO summary = codeSummaryMap.getOrDefault(code, new BaljooSubDTO(code, BigDecimal.ZERO, 0, BigDecimal.ZERO));
//			        
//			        // 누적 수량과 금액 계산
//			        int newTotalQuantity = summary.getTotalQuantity() + codeQuantityMap.get(code);  // 실제 수량 반영
//			        BigDecimal newTotalPrice = summary.getTotalPrice().add(price.multiply(new BigDecimal(codeQuantityMap.get(code))));  // 총 금액 계산
//			        
//			        // 새로운 값을 다시 Map에 저장
//			        summary.setTotalQuantity(newTotalQuantity);
//			        summary.setTotalPrice(newTotalPrice);
//			        
//			        codeSummaryMap.put(code, summary);
//			    }
//
//			    // 3. 결과 출력
//			    List<BaljooSubDTO> summaryList = new ArrayList<>();
//
//			    for (Map.Entry<String, BaljooSubDTO> entry : codeSummaryMap.entrySet()) {
//			        BaljooSubDTO summary = entry.getValue();
//			        System.out.println("Code: " + summary.getCode() + 
//			                           ", Total Quantity: " + summary.getTotalQuantity() + 
//			                           ", Total Price: " + summary.getTotalPrice());
//
//			        // 리스트에 summary 추가
//			        summaryList.add(summary);
//			    }
//
//			    // 모델에 리스트 추가
//			    model.addAttribute("orderSummary", summaryList);
//
//			    
//			        return "sales/admin_storeordersales";
//			}
			


//Sales-Monthly			
			
			@GetMapping("/bucksSalesM.do")
			public String monthlyBucksSales(Model model) {
				List<PayhistoryDTO> orderList = salesMapper.monthlyBucksSales();
				model.addAttribute("list",orderList);
				return "sales/admin_monthlysales";
			}
			
			//검색한 지점과 날짜로 월별매출
			@PostMapping("/searchMonthSales.do")
			public String searchMonthSales(@RequestParam("orderDate") String orderDate, @RequestParam("bucksName") String bucksName, Model model) {
			    System.out.println(bucksName);
			    System.out.println(orderDate);
				
			    Map<String, Object> params = new HashMap<>();
			    params.put("bucksName", bucksName);
			    params.put("monthDate", orderDate);
			    
			    List<PayhistoryDTO> monthSal = salesMapper.searchMonth(params);
			    model.addAttribute("list", monthSal);
			    System.out.println(monthSal);			    

			    //model.addAttribute("bucksBal", result);
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
			        
			      //쿠폰 들고 오기 
		            int coupon = detail.getCpnlistnum();
		            System.out.println(coupon);
		            int couponDiscount = 0;
		            
		            // 쿠폰이 있을 경우, 음료에만 쿠폰 할인을 적용
		            if (coupon > 0) {
		                couponDiscount = salesMapper.getCouponPrice(coupon);
		                System.out.println("couponDiscount:" + couponDiscount);
		            }

			        for (String item : items) {
			            item = item.replace("\"", ""); // 큰따옴표 제거
			            String[] parts = item.split(":");

			            String menuCode = parts[0];
			            String optionId = parts[1];
			            int quantity = Integer.parseInt(parts[2]);
			            
			            // 매퍼를 통해 메뉴가격 가져오기
			            int price = salesMapper.getMenuPrice(menuCode);
			            System.out.println("price:" + price);
			            int optPrice = salesMapper.getOptPrice(optionId);
			           //System.out.println("optPrice:" + optPrice);
			            
			         // 음료에만 쿠폰 할인을 적용
			            if (menuCode.startsWith("B") && couponDiscount > 0) {
			                price -= couponDiscount; // 쿠폰 할인 적용
			                couponDiscount = 0; // 한 주문에 하나의 쿠폰만 적용하므로, 적용 후 초기화
			            }
			            
			            int totalPrice = (price + optPrice) * quantity;
			            System.out.println("totalPrice : " + totalPrice);
			            
			            String category = "";
			            if (menuCode.startsWith("B")) {
			                category = "음료";
			            } else if (menuCode.startsWith("C")) {
			                category = "디저트";
			            } else if (menuCode.startsWith("M")) {
			                category = "MD상품";
			            }

			            categoryTotals.put(category, categoryTotals.getOrDefault(category, 0) + totalPrice);
			            totalSales += totalPrice;
			        }
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
			public String dailyBucksSales(Model model) {
				List<PayhistoryDTO> orderList = salesMapper.dailyBucksSales();
				model.addAttribute("list",orderList);
				System.out.println(orderList);
				return "sales/admin_dailysales";
			}
			
			//검색한 지점과 날짜로 일별매출
			@PostMapping("/searchDailySales.do")
			public String searchDailySales(@RequestParam("startDate") String startDate,
		            						@RequestParam("endDate") String endDate,
		            						@RequestParam("bucksName") String bucksName,
		            						@RequestParam("category") String category, Model model) {
				
				Map<String, Object> params = new HashMap<>();
			    params.put("startDate", startDate);
			    params.put("endDate", endDate);
			    params.put("bucksName", bucksName);
			    params.put("category", category);
				
				
				
			    return "sales/admin_dailysales";
			}
			
            
            
			
	
}
	
	
	
	

