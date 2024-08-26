package com.project.javabucksStore.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.javabucksStore.dto.BaljooDTO;
import com.project.javabucksStore.mapper.SalesMapper;

@Controller
public class SalesController {
	
	@Autowired
	SalesMapper salesMapper;
	
	@GetMapping("/store_baljooManage.do")
	public String baljooManage(@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size, Model model) {
		String userId = "bucks_0016";
		
		List<BaljooDTO> list = salesMapper.baljooList(userId);
		
		// 총 발주 금액 계산 (전체 리스트의 합계)
	    double totalBaljooPrice = 0;
	    for (BaljooDTO dto : list) {
	        totalBaljooPrice += dto.getBaljooPrice();
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
        System.out.println(updateOrderList);
        
        model.addAttribute("totalBaljooPrice", totalBaljooPrice);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", (total + size - 1) / size);
		return "sales/store_baljooManage";
	}
	
	@RequestMapping("/searchBaljoo.do")
	public String searchBaljoo(@RequestParam("year") int year,
            @RequestParam("month") int month , @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size, Model model) {
			
		System.out.println(year);
		String userId = "bucks_0016";
		Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("year", year);
        params.put("month", month);

		
		List<BaljooDTO> list = salesMapper.searchBaljooList(params);
		
		// 총 발주 금액 계산 (전체 리스트의 합계)
	    double totalBaljooPrice = 0;
	    for (BaljooDTO dto : list) {
	        totalBaljooPrice += dto.getBaljooPrice();
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
       System.out.println(updateOrderList);
       
       model.addAttribute("totalBaljooPrice", totalBaljooPrice);
       
       model.addAttribute("currentPage", page);
       model.addAttribute("totalPages", (total + size - 1) / size);
		
		return "sales/store_baljooManage";
	}
	
	
}
