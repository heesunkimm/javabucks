package com.project.javabucksAdmin.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.javabucksAdmin.dto.AdminDTO;
import com.project.javabucksAdmin.dto.BaljooDTO;
import com.project.javabucksAdmin.dto.BaljooOrder;
import com.project.javabucksAdmin.dto.BucksDTO;
import com.project.javabucksAdmin.dto.StockListDTO;
import com.project.javabucksAdmin.mapper.OrderMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminOrderController {
	
	@Autowired
	private OrderMapper mapper;
	
	// 재고현황 조회
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
	
	// 재고현황 검색
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
	
	// 재고확충
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
	
	// 발주막기
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
	
	// 발주풀기
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
	
	// 발주현황 메뉴
	@GetMapping("/adminStoreOrder.do")
	public String adminStoreOrder(HttpServletRequest req,
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
		
		// 검색 년도 설정
		LocalDate date = LocalDate.now(); // 현재날짜		
		int year = date.getYear();
		
		List<Integer> yearList = new ArrayList();
		for(int i=year; i>year-3; i--) {
			yearList.add(i);
		}

		// 검색 월 설정
		int month = date.getMonthValue();
		
		String stringMonth = null;
		if (month < 10) {
			stringMonth = "0"+ String.valueOf(month);
		}else {
			stringMonth = String.valueOf(month);
		}
		
		List<Integer> monthList = new ArrayList();
		for(int i=month; i>=1; i--) {
			monthList.add(i);
		}
		
		// 검색 지점명 설정
		List<BucksDTO> storeNamelist = mapper.getStoreName();

		Map<String, Object> params = new HashMap<>();
		
		// 테이블 데이터 추출
		params.put("selectYear", year);
		params.put("selectMonth", stringMonth);
		
		int baljooListCount = mapper.baljooCount();
		Map<String, Object> pagingMap = paging_baljoo(baljooListCount, pageNum);
				
		params.put("startRow", pagingMap.get("startRow"));
		params.put("endRow", pagingMap.get("endRow"));
		
		List<BaljooDTO> baljooList = mapper.baljooList(params);
		
		// 테이블 발주품목 컬럼 추출
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
				System.out.println("JSON String 변환 과정에서 에러");
				e.printStackTrace();
			}
		}
		
		// 검색 데이터
		req.setAttribute("yearList", yearList);
		req.setAttribute("monthList", monthList);
		req.setAttribute("storeNamelist", storeNamelist);
		
		// 데이터
		req.setAttribute("startPage", (int)pagingMap.get("startPage"));
		req.setAttribute("endPage", (int)pagingMap.get("endPage"));
		req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
		req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
		req.setAttribute("baljooList", baljooList);
		
		return "/order/admin_storeorder";
	}
	
	// 발주현황 검색
	@GetMapping("/searchAdminStoreOrder.do")
	public String searchAdminStoreOrder(HttpServletRequest req, String selectYear, String selectMonth, String unproCheck, String selectStore, String selectNum,
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
		
		// 검색조건 확인
		System.out.println("selectYear : " + selectYear);
		System.out.println("selectMonth : " + selectMonth);
		System.out.println("unproCheck : " + unproCheck); // null, checked
		System.out.println("selectStore : " + selectStore); 
		System.out.println("selectNum : " + selectNum); // ''
		

		
		// 검색 년도 설정
		LocalDate date = LocalDate.now(); // 현재날짜		
		int year = date.getYear();
		
		List<Integer> yearList = new ArrayList();
		for(int i=year; i>year-3; i--) {
			yearList.add(i);
		}

		// 검색 월 설정
		int month = date.getMonthValue();
		
		List<Integer> monthList = new ArrayList();
		for(int i=month; i>=1; i--) {
			monthList.add(i);
		}
		
		// 검색 지점명 설정
		List<BucksDTO> storeNamelist = mapper.getStoreName();
		
		String zeroMonth = null;
		if(Integer.parseInt(selectMonth) < 10) {
			zeroMonth = "0"+selectMonth;
		}
		
		Map<String, Object> params = new HashMap<>();
		params.put("selectYear", selectYear);
		params.put("selectMonth", zeroMonth);
		params.put("unproCheck", unproCheck);
		params.put("selectStore", selectStore);
		params.put("selectNum", selectNum);
		
		// 검색 데이터 추출
		int searchBaljooCount = mapper.searchBaljooCount(params);
		System.out.println("searchBaljooCount:"+searchBaljooCount);
		Map<String, Object> pagingMap = paging_baljoo(searchBaljooCount, pageNum);
				
		
		params.put("startRow", pagingMap.get("startRow"));
		params.put("endRow", pagingMap.get("endRow"));
		
		List<BaljooDTO> searchBaljooList = mapper.searchBaljooList(params);
		
		
		// 테이블 발주품목 컬럼 추출
		
		
		
		
		
		
		
		// 검색 데이터
		req.setAttribute("yearList", yearList);
		req.setAttribute("monthList", monthList);
		req.setAttribute("storeNamelist", storeNamelist);
		
		// 검색 조건
		req.setAttribute("selectYear", selectYear);
		req.setAttribute("selectMonth", selectMonth);
		req.setAttribute("unproCheck", unproCheck);
		req.setAttribute("selectStore", selectStore);
		req.setAttribute("selectNum", selectNum);
		
		// 데이터
		req.setAttribute("startPage", (int)pagingMap.get("startPage"));
		req.setAttribute("endPage", (int)pagingMap.get("endPage"));
		req.setAttribute("pageCount", (int)pagingMap.get("pageCount"));
		req.setAttribute("pageBlock", (int)pagingMap.get("pageBlock"));
		req.setAttribute("searchBaljooList", searchBaljooList);
		
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
