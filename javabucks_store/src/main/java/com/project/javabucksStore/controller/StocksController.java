package com.project.javabucksStore.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.StockCartDTO;
import com.project.javabucksStore.dto.StoreStocksDTO;
import com.project.javabucksStore.mapper.StocksMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class StocksController {
	
	@Autowired
	StocksMapper mapper;
	
	@GetMapping("/stocks.do")
	public String stocks(HttpServletRequest req,
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum,
			@RequestParam(value = "foo_pageNum", required = false, defaultValue = "1") int foo_pageNum,
			@RequestParam(value = "cup_pageNum", required = false, defaultValue = "1") int cup_pageNum,
			@RequestParam(value = "syr_pageNum", required = false, defaultValue = "1") int syr_pageNum,
			@RequestParam(value = "whi_pageNum", required = false, defaultValue = "1") int whi_pageNum,
			@RequestParam(value = "mil_pageNum", required = false, defaultValue = "1") int mil_pageNum,
			@RequestParam(value = "tum_pageNum", required = false, defaultValue = "1") int tum_pageNum,
			@RequestParam(value = "won_pageNum", required = false, defaultValue = "1") int won_pageNum) {
			
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		// 음료 탭
		int bev_list_count = mapper.bevCount(bucksId);
		Map<String, Object> bev_pagingMap = paging(bev_list_count, pageNum);
		
		Map<String, Object> bev_params = new HashMap<>();
		bev_params.put("startRow", bev_pagingMap.get("startRow"));
		bev_params.put("endRow", bev_pagingMap.get("endRow"));
		bev_params.put("bucksId", bucksId);
		
		
		List<StoreStocksDTO> bev_list = mapper.bevStocksList(bev_params);		
		
		req.setAttribute("bev_startPage", (int)bev_pagingMap.get("startPage"));
		req.setAttribute("bev_endPage", (int)bev_pagingMap.get("endPage"));
		req.setAttribute("bev_pageCount", (int)bev_pagingMap.get("pageCount"));
		req.setAttribute("bev_pageBlock", (int)bev_pagingMap.get("pageBlock"));
		req.setAttribute("bevStocksList", bev_list);
		
		
		// 푸드탭
		int foo_list_count = mapper.fooCount(bucksId);
		Map<String, Object> foo_pagingMap = paging(foo_list_count, foo_pageNum);
		
		Map<String, Object> foo_params = new HashMap<>();
		foo_params.put("startRow", foo_pagingMap.get("startRow"));
		foo_params.put("endRow", foo_pagingMap.get("endRow"));
		foo_params.put("bucksId", bucksId);
		
		List<StoreStocksDTO> foo_list = mapper.fooStocksList(foo_params);		
		
		req.setAttribute("foo_startPage", (int)foo_pagingMap.get("startPage"));
		req.setAttribute("foo_endPage", (int)foo_pagingMap.get("endPage"));
		req.setAttribute("foo_pageCount", (int)foo_pagingMap.get("pageCount"));
		req.setAttribute("foo_pageBlock", (int)foo_pagingMap.get("pageBlock"));
		req.setAttribute("fooStocksList", foo_list);
		
		
		// 컵탭
		int cup_list_count = mapper.cupCount(bucksId);
		Map<String, Object> cup_pagingMap = paging(cup_list_count, cup_pageNum);
		
		Map<String, Object> cup_params = new HashMap<>();
		cup_params.put("startRow", cup_pagingMap.get("startRow"));
		cup_params.put("endRow", cup_pagingMap.get("endRow"));
		cup_params.put("bucksId", bucksId);
		
		List<StoreStocksDTO> cup_list = mapper.cupStocksList(cup_params);		
		
		req.setAttribute("cup_startPage", (int)cup_pagingMap.get("startPage"));
		req.setAttribute("cup_endPage", (int)cup_pagingMap.get("endPage"));
		req.setAttribute("cup_pageCount", (int)cup_pagingMap.get("pageCount"));
		req.setAttribute("cup_pageBlock", (int)cup_pagingMap.get("pageBlock"));
		req.setAttribute("cupStocksList", cup_list);

		
		// 시럽탭
		int syr_list_count = mapper.syrCount(bucksId);
		Map<String, Object> syr_pagingMap = paging(syr_list_count, syr_pageNum);
		
		Map<String, Object> syr_params = new HashMap<>();
		syr_params.put("startRow", syr_pagingMap.get("startRow"));
		syr_params.put("endRow", syr_pagingMap.get("endRow"));
		syr_params.put("bucksId", bucksId);
		
		List<StoreStocksDTO> syr_list = mapper.syrStocksList(syr_params);		
		
		req.setAttribute("syr_startPage", (int)syr_pagingMap.get("startPage"));
		req.setAttribute("syr_endPage", (int)syr_pagingMap.get("endPage"));
		req.setAttribute("syr_pageCount", (int)syr_pagingMap.get("pageCount"));
		req.setAttribute("syr_pageBlock", (int)syr_pagingMap.get("pageBlock"));
		req.setAttribute("syrStocksList", syr_list);
		
		
		// 휘핑크림탭
		int whi_list_count = mapper.whiCount(bucksId);
		Map<String, Object> whi_pagingMap = paging(whi_list_count, whi_pageNum);
		
		Map<String, Object> whi_params = new HashMap<>();
		whi_params.put("startRow", whi_pagingMap.get("startRow"));
		whi_params.put("endRow", whi_pagingMap.get("endRow"));
		whi_params.put("bucksId", bucksId);
		
		List<StoreStocksDTO> whi_list = mapper.whiStocksList(whi_params);		
		
		req.setAttribute("whi_startPage", (int)whi_pagingMap.get("startPage"));
		req.setAttribute("whi_endPage", (int)whi_pagingMap.get("endPage"));
		req.setAttribute("whi_pageCount", (int)whi_pagingMap.get("pageCount"));
		req.setAttribute("whi_pageBlock", (int)whi_pagingMap.get("pageBlock"));
		req.setAttribute("whiStocksList", whi_list);
		
		
		// 우유 탭
		int mil_list_count = mapper.milCount(bucksId);
		Map<String, Object> mil_pagingMap = paging(mil_list_count, mil_pageNum);
		
		Map<String, Object> mil_params = new HashMap<>();
		mil_params.put("startRow", mil_pagingMap.get("startRow"));
		mil_params.put("endRow", mil_pagingMap.get("endRow"));
		mil_params.put("bucksId", bucksId);
		
		List<StoreStocksDTO> mil_list = mapper.milStocksList(mil_params);		
		
		req.setAttribute("mil_startPage", (int)mil_pagingMap.get("startPage"));
		req.setAttribute("mil_endPage", (int)mil_pagingMap.get("endPage"));
		req.setAttribute("mil_pageCount", (int)mil_pagingMap.get("pageCount"));
		req.setAttribute("mil_pageBlock", (int)mil_pagingMap.get("pageBlock"));
		req.setAttribute("milStocksList", mil_list);
				
		
		// 텀블러 탭
		int tum_list_count = mapper.tumCount(bucksId);
		Map<String, Object> tum_pagingMap = paging(tum_list_count, tum_pageNum);
		
		Map<String, Object> tum_params = new HashMap<>();
		tum_params.put("startRow", tum_pagingMap.get("startRow"));
		tum_params.put("endRow", tum_pagingMap.get("endRow"));
		tum_params.put("bucksId", bucksId);
		
		List<StoreStocksDTO> tum_list = mapper.tumStocksList(tum_params);		
		
		req.setAttribute("tum_startPage", (int)tum_pagingMap.get("startPage"));
		req.setAttribute("tum_endPage", (int)tum_pagingMap.get("endPage"));
		req.setAttribute("tum_pageCount", (int)tum_pagingMap.get("pageCount"));
		req.setAttribute("tum_pageBlock", (int)tum_pagingMap.get("pageBlock"));
		req.setAttribute("tumStocksList", tum_list);
				
		
		// 원두 탭
		int won_list_count = mapper.wonCount(bucksId);
		Map<String, Object> won_pagingMap = paging(won_list_count, won_pageNum);
		
		Map<String, Object> won_params = new HashMap<>();
		won_params.put("startRow", won_pagingMap.get("startRow"));
		won_params.put("endRow", won_pagingMap.get("endRow"));
		won_params.put("bucksId", bucksId);
		
		List<StoreStocksDTO> won_list = mapper.wonStocksList(won_params);		
		
		req.setAttribute("won_startPage", (int)won_pagingMap.get("startPage"));
		req.setAttribute("won_endPage", (int)won_pagingMap.get("endPage"));
		req.setAttribute("won_pageCount", (int)won_pagingMap.get("pageCount"));
		req.setAttribute("won_pageBlock", (int)won_pagingMap.get("pageBlock"));
		req.setAttribute("wonStocksList", won_list);		
		
		return "/stocks/store_stocks";
	}	
	
	
	// 페이징 처리 메서드
	public Map<String, Object> paging(int count, int pageNum) {
		int pageSize = 3; // 한 페이지에 보여질 게시글 수
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
	
	
	// 재고 장바구니 추가 AJAX
	@ResponseBody
	@PostMapping("/addStocksCart.ajax")
	public ResponseEntity<Map<String, Object>> addStocksCart(HttpServletRequest req, String stockListCode, int quantity) {	
		
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		List<StockCartDTO> list = mapper.stockCartList(bucksId);
		Map<String, Object> response = new HashMap<>();
		
		boolean tag = false;
		
		// 리스트가 null인 경우
		if(list.isEmpty()) {
			int addCartResult = mapper.addStocksCart(stockListCode, quantity, bucksId);
			response.put("response", addCartResult);
			return ResponseEntity.ok(response);
		} 		
		// 리스트가 null이 아니고 이미 해당 코드가 있는 경우 수량만 update
		for(StockCartDTO cdto : list) {
			if (cdto.getStockListCode().equals(stockListCode)) {
				int updateCartQuantity = mapper.updateCartQuantity(stockListCode, quantity, bucksId);
				response.put("response", updateCartQuantity);
				tag = true;
				break;
			}
		}				
		// 리스트가 null이 아닌데 해당 코드는 없는 경우 코드와 수량 insert
		if(!tag) {
			int addCartResult = mapper.addStocksCart(stockListCode, quantity, bucksId);
			response.put("response", addCartResult);
		}
		
		return ResponseEntity.ok(response);				
	}
	
	
	// 재고 장바구니
	@GetMapping("/stocksCart.do")
	public String stocksCart(HttpServletRequest req) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		// 카트 List 조회
		List<StockCartDTO> list = mapper.stockCartList(bucksId);
		Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, 1);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String tommorow = formatter.format(calendar.getTime());
        
        // 주소꺼내기
        String address = dto.getBucksLocation();
        
        req.setAttribute("address", address);
		req.setAttribute("stockCartList", list);	
		req.setAttribute("tommorow", tommorow);
		
		return "/stocks/store_cart";
	}
		

	// 재고 장바구니 수량 업데이트
	@ResponseBody
	@PostMapping("/updateQuantity.ajax")
	public ResponseEntity<Map<String, Object>> updateQuantity(HttpServletRequest req, String stockListCode, int quantity) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		Map<String, Object> response = new HashMap<>();
		int updateQuantity = mapper.updateQuantity(stockListCode, quantity, bucksId);
		response.put("response", updateQuantity);	
		return ResponseEntity.ok(response);		
	}
	
	// 재고 장바구니 삭제
	@ResponseBody
	@PostMapping("/deleteCart.ajax")
	public ResponseEntity<Map<String, Object>> deleteCart(HttpServletRequest req, String stockListCode) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		Map<String, Object> response = new HashMap<>();
		int deleteCart = mapper.deleteCart(stockListCode, bucksId);
		response.put("response", deleteCart);	
		return ResponseEntity.ok(response);	
	}
	
	// 주문하기
	@PostMapping("/addStoreOrder.do")
	public String addStoreOrder(HttpServletRequest req,
								@RequestParam("stockCartCount") List<Integer> stockCartCount, 
								@RequestParam("stockListPrice") List<Integer> stockListPrice, 
								@RequestParam("stockListCode") List<String> stockListCode,
								@RequestParam("stockCartNum") List<Integer> stockCartNum) throws JsonProcessingException {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		// 총 주문금액
		int price = 0;
		int totPrice = 0;
		for(int i=0; i<stockListCode.size(); i++) {
			price = stockListPrice.get(i) * stockCartCount.get(i);			
			totPrice = totPrice + price;			
		}
		//System.out.println("totPrice : " + totPrice);
		
		// 주문내역
		List<String> orderList = new ArrayList<>();
		for(int i=0; i<stockListCode.size(); i++) {
			String Order = stockListCode.get(i) + ":" + stockCartCount.get(i);
			orderList.add(Order);
		}

		// JSON 문자열로 변환
	    ObjectMapper objectMapper = new ObjectMapper();
	    String jsonOrderList = objectMapper.writeValueAsString(orderList);
	    //System.out.println("JSON Order List: " + jsonOrderList);
	    
		
		// 주문내역 INSERT
		int addStoreOrder = mapper.addStoreOrder(bucksId, jsonOrderList, totPrice);	
		
		
		// 장바구니 상태 UPDATE
		for(int i=0; i<stockCartNum.size(); i++) {
			//System.out.println("cartNum:"+stockCartNum.get(i));
			int updateCartStatus = mapper.updateCartStatus(bucksId, stockCartNum.get(i));
		}		
		
		return "redirect:/store_baljooManage.do";
	}
	
}
