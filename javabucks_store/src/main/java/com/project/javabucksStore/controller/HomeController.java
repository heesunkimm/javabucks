package com.project.javabucksStore.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.javabucksStore.dto.BaljooDTO;
import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.MenuDTO;
import com.project.javabucksStore.dto.PayhistoryDTO;
import com.project.javabucksStore.mapper.HomeMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	@Autowired
	HomeMapper homeMapper;

	@GetMapping("/store_index.do")
	public String topMenu(HttpServletRequest req, Model model) {
		 HttpSession session = req.getSession();
	      BucksDTO bdto = (BucksDTO)session.getAttribute("inBucks");
	      String bucksId = bdto.getBucksId();
	      
	      List<PayhistoryDTO> orderList = homeMapper.topMenuOrderList(bucksId);
	      
	      Map<String, Integer> menuCountMap = new HashMap<>();
	      
	      if (orderList != null) {
	      for (PayhistoryDTO order : orderList) {
		        String orderListJson = order.getOrderList();
		        String branchId = order.getBucksId(); // 지점 등록번호
		        
		     // Null 값 체크
                if (orderListJson == null || orderListJson.isEmpty()) {
                    continue;  // null 또는 빈 문자열인 경우 해당 주문은 건너뜁니다.
                }
		        
		        orderListJson = orderListJson.substring(1, orderListJson.length() - 1);
		        String[] items = orderListJson.split(",");

		        // 각 아이템 처리
		        for (String item : items) {
		            // 아이템을 ":"로 분리하여 메뉴 코드, 옵션 ID, 수량 추출
		            String[] parts = item.replaceAll("[\\[\\]\"]", "").split(":");
		            if (parts.length < 3) {
                        continue;  // 필요한 데이터가 없으면 건너뜁니다.
                    }
		            String menuCode = parts[0];
		            String optionId = parts[1];
		            int quantity = Integer.parseInt(parts[2]);

		            //System.out.println("menuCode : " + menuCode);
		            
		            // 메뉴 코드별로 수량을 집계
	                menuCountMap.put(menuCode, menuCountMap.getOrDefault(menuCode, 0) + quantity);
	                //System.out.println(menuCountMap);
	            }
	        }
	      }
	      
	      

	        // 메뉴별 수량을 내림차순으로 정렬하여 상위 3개 추출
	        List<Map.Entry<String, Integer>> sortedMenuList = new ArrayList<>(menuCountMap.entrySet());
	        sortedMenuList.sort((e1, e2) -> e2.getValue().compareTo(e1.getValue()));
	        


	        List<String> top3MenuCodes = new ArrayList<>();
	        for (int i = 0; i < Math.min(3, sortedMenuList.size()); i++) {
	            top3MenuCodes.add(sortedMenuList.get(i).getKey());
	        }
	        

	        // DB에서 상위 3개의 메뉴 코드에 대한 정보를 가져옴
	        List<MenuDTO> top3MenuDetails = new ArrayList<>();
	        if (!top3MenuCodes.isEmpty()) {
	            top3MenuDetails = homeMapper.getMenuDetails(top3MenuCodes);
	        }
	        
	        
	        // 상위 3개 메뉴 정보를 원래 순서대로 정렬
	        Map<String, MenuDTO> menuMap = new LinkedHashMap<>();
	        for (MenuDTO menu : top3MenuDetails) {
	        	if (menu != null) {
	                menu.setOrderCount(menuCountMap.get(menu.getMenuCode()));
	                menuMap.put(menu.getMenuCode(), menu);
	            }
	        }
	        

	        List<MenuDTO> orderedMenuDetails = new ArrayList<>();
	        for (String code : top3MenuCodes) {
	            orderedMenuDetails.add(menuMap.get(code));
	        }
	        
	        // 신규 이미지 추가했을 때 뒤에꺼만 짤라서 SET
		    for(int i=0; i<orderedMenuDetails.size(); i++) {
		    	String imageName = orderedMenuDetails.get(i).getMenuImages();;
		    	if(imageName.length() != 12) {
		    		String imageName2 = imageName.substring(9, 21);
		    		orderedMenuDetails.get(i).setMenuImages(imageName2);
		    	}
		    }
	        
	        model.addAttribute("top3MenuDetails", orderedMenuDetails);
	       // System.out.println(orderedMenuDetails);
///////////////////
	        
	        int currentYear = LocalDate.now().getYear();
	        
	        List<Map<String, Object>> monthlySales = homeMapper.MonthlySales(bucksId, Integer.toString(currentYear));
	        //System.out.println(monthlySales);
	    
	        List<Integer> salesData = new ArrayList<>();
	        for (int i = 1; i <= 12; i++) {
	            salesData.add(0); // 초기값으로 0을 설정
	        }

	        if (monthlySales != null) {
	        for (Map<String, Object> entry : monthlySales) {
	            String monthStr = (String) entry.get("MONTH");
	           // System.out.println("monthStr: " + monthStr);  // 로그 추가
	            if (monthStr != null) {
	                int month = Integer.parseInt(monthStr);
	                int totalSales = ((Number) entry.get("TOTALSALES")).intValue();
	               // System.out.println("Month: " + month + ", Total Sales: " + totalSales);  // 로그 추가
	                salesData.set(month - 1, totalSales);
	            }
	        }
	        } 

	        // Max 값을 계산
	        int maxSales = salesData.stream().mapToInt(v -> v).max().orElse(0);

	        // JSP에 데이터 전달
	        model.addAttribute("salesData", salesData);
	        model.addAttribute("maxSales", maxSales);
	        model.addAttribute("currentYear", currentYear);  
	        //System.out.println("salesData : "+ salesData);
	        //System.out.println("maxSales : "+ maxSales);
	        
	        
		return "store_index";
	}
}
