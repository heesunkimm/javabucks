package com.project.javabucksAdmin.controller;

import java.util.ArrayList;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.javabucksAdmin.dto.BaljooDTO;
import com.project.javabucksAdmin.dto.BaljooOrder;
import com.project.javabucksAdmin.dto.StockListDTO;
import com.project.javabucksAdmin.mapper.OrderMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminOrderController {
	
	@Autowired
	private OrderMapper mapper;
	
	
	@GetMapping("/adminStockList.do")
	public String stockList(HttpServletRequest req,
							@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
		
		int stockListCount = mapper.adminStockListCount();
		Map<String, Object> pagingMap = paging(stockListCount, pageNum);
		
		Map<String, Object> params = new HashMap<>();
		params.put("startRow", pagingMap.get("startRow"));
		params.put("endRow", pagingMap.get("endRow"));		
		
		List<StockListDTO> list = mapper.adminStockList(params);		
		
		req.setAttribute("startPage", (int)pagingMap.get("startPage"));
		req.setAttribute("endPage", (int)pagingMap.get("endPage"));
		req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
		req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
		req.setAttribute("adminStockList", list);
		
		return "/order/admin_stocklist";
	}
	
	
	@GetMapping("/findAdminStockList.do")
	public String stockList(HttpServletRequest req,
							@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum,
							String searchCate, String searchStockListName) {
		
		//System.out.println("searchCate:"+searchCate);
		//System.out.println("searchStockListName:"+searchStockListName);
		
		int stockListCount = 0;
		if(searchCate.equals("ALL")) {
			stockListCount = mapper.searchAdminStockListCountAll(searchStockListName);
		} else {
			stockListCount = mapper.searchAdminStockListCount(searchCate, searchStockListName);
		}		
		
		Map<String, Object> pagingMap = paging(stockListCount, pageNum);
		
		Map<String, Object> params = new HashMap<>();
		params.put("startRow", pagingMap.get("startRow"));
		params.put("endRow", pagingMap.get("endRow"));
		params.put("searchCate", searchCate);
		params.put("searchStockListName", searchStockListName);
		
		List<StockListDTO> list = null;
		if(searchCate.equals("ALL")) {	
			list = mapper.findAdminStockListAll(params);
		}else {
			list = mapper.findAdminStockList(params);
		}		 	
		
		req.setAttribute("startPage", (int)pagingMap.get("startPage"));
		req.setAttribute("endPage", (int)pagingMap.get("endPage"));
		req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
		req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
		req.setAttribute("findAdminStockList", list);
		req.setAttribute("searchStockListName", searchStockListName);
		req.setAttribute("searchCate", searchCate);
		
		return "/order/admin_stocklist";
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
	
	
	@ResponseBody
	@PostMapping("/stockPlus.ajax")
	public Map<String, Object> stockPlus(String stockListCode, String stockCount) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("stockListCode", stockListCode);
		params.put("stockCount", Integer.parseInt(stockCount));
		
		// 수량 업데이트
		int updateResult = mapper.stockPlus(params);
		
		// 업데이트된 수량 가져오기
		int updateCount = mapper.stockCountUpdated(params);
		
		Map<String, Object> response = new HashMap<>();
		response.put("updateCount", updateCount);
		
		return response;
	}
	

	@ResponseBody
	@PostMapping("/adminOrderBlock.ajax")
	public Map<String, Object> adminOrderBlock(String stockListCode){
		
		Map<String, Object> response = new HashMap<>();
		try {
			int updateResult = mapper.stockStatusUpdateN(stockListCode);
			if(updateResult > 0) {
				response.put("result", "success");
			} else {
				response.put("result", "fail");
			}
			
		} catch (Exception e) {
			
			response.put("result", "error");
		}
		return response;
	}
	
	@ResponseBody
	@PostMapping("/adminOrderRelease.ajax")
	public Map<String, Object> adminOrderRelease(String stockListCode){
		
		Map<String, Object> response = new HashMap<>();
		try {
			int updateResult = mapper.stockStatusUpdateY(stockListCode);
			if(updateResult > 0) {
				response.put("result", "success");
			} else {
				response.put("result", "fail");
			}
			
		} catch (Exception e) {
			
			response.put("result", "error");
		}
		return response;
	}
	
	
	@GetMapping("/adminStoreOrder.do")
	public String adminStoreOrder(HttpServletRequest req,
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
		
		int baljooListCount = mapper.baljooCount();
		Map<String, Object> pagingMap = paging_baljoo(baljooListCount, pageNum);
				
		Map<String, Object> params = new HashMap<>();
		params.put("startRow", pagingMap.get("startRow"));
		params.put("endRow", pagingMap.get("endRow"));
		
		List<BaljooDTO> baljooList = mapper.baljooList(params);
		
		ObjectMapper objectMapper = new ObjectMapper();
		for(BaljooDTO baljooDTO : baljooList) {
			try {
				// baljooList 컬럼의 JSON 문자열을 List<String>으로 변환
				List<String> baljooItems = objectMapper.readValue(baljooDTO.getBaljooList(), 
                        					objectMapper.getTypeFactory().constructCollectionType(List.class, String.class));
				
				// 재고명까지 들어간 baljooList 업데이트용
				List<BaljooOrder> updateBaljooList = new ArrayList<>();
				
				for(String items : baljooItems) {
					String[] item = items.split(":");
					
					if(item.length == 2) {
						String stockCode = item[0];
						String quantity = item[1];
						
						// BaljooOrder 객체 생성
						BaljooOrder baljooOrder = new BaljooOrder(stockCode, Integer.parseInt(quantity));
						
						// stockCode가지고 stockName 가져오기
						String stockListName = mapper.getStcokName(stockCode);
						
						// BaljooOrder 객체에 재고명 set
						baljooOrder.setStockListName(stockListName);
						
						// BaljooOrder객체를 updateBaljooList에 add
						updateBaljooList.add(baljooOrder);
						
					} else {
						System.out.println("Code:Quantity 형태가 아님");
					}
				}
				// updateBaljooList를 baljooDTO에 set
				baljooDTO.setBaljooListbyBaljooOrder(updateBaljooList);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}		
		req.setAttribute("startPage", (int)pagingMap.get("startPage"));
		req.setAttribute("endPage", (int)pagingMap.get("endPage"));
		req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
		req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
		req.setAttribute("baljooList", baljooList);
		
		return "/order/admin_storeorder";
	}
	
	
	// 페이징 처리 메서드
	public Map<String, Object> paging_baljoo(int count, int pageNum) {
		int pageSize = 5; // 한 페이지에 보여질 게시글 수
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
	
	
	
	
	


	
	
}
