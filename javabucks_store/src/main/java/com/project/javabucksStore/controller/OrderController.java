package com.project.javabucksStore.controller;

import java.io.IOException;
import java.sql.SQLRecoverableException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.MenuOrder;
import com.project.javabucksStore.dto.OrderDTO;
import com.project.javabucksStore.dto.OrderOptDTO;
import com.project.javabucksStore.dto.StockUseDTO;
import com.project.javabucksStore.dto.StoreMenuDTO;
import com.project.javabucksStore.mapper.OrderMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {

	@Autowired
	OrderMapper mapper;
	
	private HttpSession session;

	@GetMapping("/orderHistory.do")
	public String orderHistory(HttpServletRequest req) {
		// 주문일 검색조건 세팅
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = dateFormat.format(date);
		// System.out.println("today : " + today);

		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

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
		// System.out.println("searchOpt_orderDate :" + searchOpt_orderDate);
		// System.out.println("searchOpt_orderCode :" + searchOpt_orderCode);

		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

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
		// System.out.println("today : " + today);

		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

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
		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

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
			@RequestParam(value = "deliverOrder_pageNum", required = false, defaultValue = "1") int deliverOrder_pageNum,
			@RequestParam(value = "making_pageNum", required = false, defaultValue = "1") int making_pageNum,
			Model model) {

		// 세션에서 ID꺼내기
		this.session = req.getSession();
		
		// 주문 패치
		fetchOrder();
		
		// 주문 처리 로직
		orderProcess(req, storeOrder_pageNum, deliverOrder_pageNum, making_pageNum, model);

		return "/order/store_orderManage";
	}
	
	// 주문처리 로직 메서드
	private void orderProcess(HttpServletRequest req, int storeOrder_pageNum, int deliverOrder_pageNum, 
								int making_pageNum, Model model) {
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

		// 오늘 날짜 꺼내기
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = dateFormat.format(date);

		// 매장 신규주문
		int storeOrderListCount = mapper.getStoreOrderListCount(bucksId, today);
		Map<String, Object> storeOrder_pagingMap = paging(storeOrderListCount, storeOrder_pageNum);

		Map<String, Object> storeOrder_params = new HashMap<>();
		storeOrder_params.put("bucksId", bucksId);
		storeOrder_params.put("startRow", storeOrder_pagingMap.get("startRow"));
		storeOrder_params.put("endRow", storeOrder_pagingMap.get("endRow"));
		storeOrder_params.put("today", today);

		List<OrderDTO> storeOrderList = mapper.getStoreOrderList(storeOrder_params);
		// order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
		orderListMethod(storeOrderList);

		model.addAttribute("storeOrder_startPage", (int) storeOrder_pagingMap.get("startPage"));
		model.addAttribute("storeOrder_endPage", (int) storeOrder_pagingMap.get("endPage"));
		model.addAttribute("storeOrder_pageCount", (int) storeOrder_pagingMap.get("pageCount"));
		model.addAttribute("storeOrder_pageBlock", (int) storeOrder_pagingMap.get("pageBlock"));
		model.addAttribute("storeOrderList", storeOrderList);

		// 배달 신규주문
		int deliverOrderListCount = mapper.getDeliverOrderListCount(bucksId, today);
		Map<String, Object> deliverOrder_pagingMap = paging(deliverOrderListCount, deliverOrder_pageNum);

		Map<String, Object> deliverOrder_params = new HashMap<>();
		deliverOrder_params.put("bucksId", bucksId);
		deliverOrder_params.put("startRow", deliverOrder_pagingMap.get("startRow"));
		deliverOrder_params.put("endRow", deliverOrder_pagingMap.get("endRow"));
		deliverOrder_params.put("today", today);

		List<OrderDTO> deliverOrderList = mapper.getDeliverOrderList(deliverOrder_params);
		// order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
		orderListMethod(deliverOrderList);

		model.addAttribute("deliverOrder_startPage", (int) deliverOrder_pagingMap.get("startPage"));
		model.addAttribute("deliverOrder_endPage", (int) deliverOrder_pagingMap.get("endPage"));
		model.addAttribute("deliverOrder_pageCount", (int) deliverOrder_pagingMap.get("pageCount"));
		model.addAttribute("deliverOrder_pageBlock", (int) deliverOrder_pagingMap.get("pageBlock"));
		model.addAttribute("deliverOrderList", deliverOrderList);

		// 제조중
		int makingListCount = mapper.getMakingListCount(bucksId, today);
		Map<String, Object> making_pagingMap = paging_making(makingListCount, making_pageNum);

		Map<String, Object> making_params = new HashMap<>();
		making_params.put("bucksId", bucksId);
		making_params.put("startRow", making_pagingMap.get("startRow"));
		making_params.put("endRow", making_pagingMap.get("endRow"));
		making_params.put("today", today);

		List<OrderDTO> makingList = mapper.getMakingList(making_params);
		// order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
		orderListMethod(makingList);
		
		model.addAttribute("making_startPage", (int) making_pagingMap.get("startPage"));
		model.addAttribute("making_endPage", (int) making_pagingMap.get("endPage"));
		model.addAttribute("making_pageCount", (int) making_pagingMap.get("pageCount"));
		model.addAttribute("making_pageBlock", (int) making_pagingMap.get("pageBlock"));
		model.addAttribute("makingList", makingList);
		
		// 신규 주문 막기 CHECK = 모든 스토어 메뉴가 주문 막기 되어있는지 확인
		Boolean orderStopCheck = false;

		String storeOrderStatus = mapper.getStoreOrderStatus(bucksId);
		if(storeOrderStatus.equals("N")) {
			orderStopCheck = true;
		}
		
		model.addAttribute("orderStopCheck", orderStopCheck);
	}
	
	// 주문내역 패치 메서드
	private void fetchOrder() {
		if(this.session != null) {
			BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
			String bucksId = dto.getBucksId();
			
			// 오늘 날짜 가져오기
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String today = dateFormat.format(date);

            // 매장 신규주문 리스트 불러오기
            int storeOrderListCount = mapper.getStoreOrderListCount(bucksId, today);
            Map<String, Object> storeOrder_pagingMap = paging(storeOrderListCount, 1);

            Map<String, Object> storeOrder_params = new HashMap<>();
            storeOrder_params.put("bucksId", bucksId);
            storeOrder_params.put("startRow", storeOrder_pagingMap.get("startRow"));
            storeOrder_params.put("endRow", storeOrder_pagingMap.get("endRow"));
            storeOrder_params.put("today", today);

            List<OrderDTO> storeOrderList = mapper.getStoreOrderList(storeOrder_params);

            // 패치 확인
            //System.out.println("매장주문 Fetched: " + date.toString());
            
            
            // 배달 신규주문 불러오기
    		int deliverOrderListCount = mapper.getDeliverOrderListCount(bucksId, today);
    		Map<String, Object> deliverOrder_pagingMap = paging(deliverOrderListCount, 1);

    		Map<String, Object> deliverOrder_params = new HashMap<>();
    		deliverOrder_params.put("bucksId", bucksId);
    		deliverOrder_params.put("startRow", deliverOrder_pagingMap.get("startRow"));
    		deliverOrder_params.put("endRow", deliverOrder_pagingMap.get("endRow"));
    		deliverOrder_params.put("today", today);

    		List<OrderDTO> deliverOrderList = mapper.getDeliverOrderList(deliverOrder_params);
            
    		// 패치 확인
    		//System.out.println("배달주문 Fetched: " + date.toString());
		}
	}
	
	// 주문현황 화면에서의 신규 주문 체크
	@GetMapping("/checkNewOrder.ajax")
	public ResponseEntity<Map<String, Boolean>> checkNewOrder() {
		// 신규주문 있는지 확인
		Boolean newOrder = false;
		
		Map<String, Boolean> response = new HashMap<>();
		
		if(this.session != null	) {
			BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
			String bucksId = dto.getBucksId();
			
			// 오늘 날짜 가져오기
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String today = dateFormat.format(date);
            
            int newOrderListCount = mapper.getNewOrderListCount(bucksId, today);
            if (newOrderListCount > 0) {
            	newOrder = true;
            }
		}
		
		response.put("newOrder", newOrder);
		
		//System.out.println(response);
		
		return ResponseEntity.ok(response);
	}
	

	// 주문접수 처리
	@PostMapping("/orderStart.ajax")
	public ResponseEntity<Map<Object, Object>> startOrder(HttpServletRequest req, String orderCode) {
		// 파라미터 확인
		//System.out.println("orderCode:" + orderCode);

		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

		// 코드 앞에 붙일 날짜_ 만들기
		int intYear = LocalDate.now().getYear();
		String StringYear = String.valueOf(intYear);
		String year = StringYear.substring(2, 4);
		// System.out.println(year); // 24

		int intMonth = LocalDate.now().getMonthValue();
		String StringMonth = String.valueOf(intMonth);
		String month = null;
		if (intMonth < 10) {
			month = "0" + StringMonth;
		} else {
			month = StringMonth;
		}
		// System.out.println(month); // 08

		int intDay = LocalDate.now().getDayOfMonth();
		String StringDay = String.valueOf(intDay);
		String day = null;
		if (intDay < 10) {
			day = "0" + StringDay;
		} else {
			day = StringDay;
		}
		//System.out.println(day); // 25

		String orderDate = year + month + day + "_";
		//System.out.println(orderDate); // 240825_

		String realOrderCode = orderDate + orderCode;
		//System.out.println(realOrderCode);

		Map<String, Object> params = new HashMap<>();
		params.put("bucksId", bucksId);
		params.put("orderCode", realOrderCode);

		// orderCode로 주문 리스트 뽑아오기
		List<OrderDTO> allOrderList = mapper.getAllOrderList(params);
		// order테이블 orderlist 컬럼 String 변환 및 메뉴명 매핑, 코드 날짜 제외 통합 메서드
		orderListMethod(allOrderList);

		// 기본재료 + 옵션재료 수량 저장
		Map<String, Integer> mater = new HashMap<>();

		// 1. 차감해야하는 재료, 수량 확인
		for (int i = 0; i < allOrderList.size(); i++) {

			// 주문리스트의 orderList컬럼 뽑기
			List<MenuOrder> orderList = allOrderList.get(i).getOrderListbyMenuOrder();

			for (MenuOrder order : orderList) {
				String menuCode = order.getMenuCode();
				//System.out.println("menuCode:"+menuCode); // BESWHAMC
				String optionId = order.getOptionId();
				// System.out.println("optionId:"+optionId); // 6
				int quantity = order.getQuantity();
				// System.out.println("quantity:"+quantity);
				String menuName = order.getMenuName();
				// System.out.println(menuName);

				// 메뉴선택 수량
				int materCount = quantity;

				// 메뉴코드의 앞글자가 B로 시작하면
				if (menuCode.startsWith("B")) {

					// 음료 1) 메뉴옵션코드 뽑아서 차감해야하는 기본 재료 뽑기
					String menuOptCode = menuCode.substring(1, 4);
					// System.out.println(menuOptCode); // ESW

					List<StockUseDTO> useList = mapper.getUseList(menuOptCode);

					for (StockUseDTO useItem : useList) {
						String stockListCode = useItem.getStockListCode();
						// System.out.println("stockListCode:"+stockListCode); // BEV01, BEV03
						if (mater.containsKey(stockListCode)) {
							int originCnt = mater.get(stockListCode);
							int changeCnt = originCnt + materCount;
							mater.put(stockListCode, changeCnt);
						} else {
							mater.put(stockListCode, materCount); // BEV01 - 수량
						}

					}

					// 음료 2) 옵션아이디로 차감해야하는 컵, 샷(추가), 시럽(추가), 우유(변경), 휘핑(추가) 재료 뽑기
					String cupType = order.getCupType(); // Tall
					String shotType = order.getShotType(); // 기본 >> BEV01에서 까야함
					int shotCount = order.getShotCount(); // 1
					String syrupType = order.getSyrupType(); // 바닐라 시럽
					int syrupCount = order.getSyrupCount(); // 1
					String milkType = order.getMilkType(); // 일반
					String whipType = order.getWhipType(); // 보통 >> WHI01에서 까야함

					// 컵
					if (mater.containsKey(cupType)) {
						int originCnt = mater.get(cupType);
						int changeCnt = originCnt + 1;
						mater.put(cupType, changeCnt);
					} else {
						mater.put(cupType, 1);
					}

					// 샷
					if (shotType != null) {
						if (mater.containsKey("BEV01")) {
							int originCnt = mater.get("BEV01");
							int changeCnt = originCnt + shotCount;
							mater.put("BEV01", changeCnt);
						} else {
							mater.put("BEV01", shotCount);
						}
					}

					// 시럽
					if (syrupType != null) {
						String syrupCode = mapper.getSyrupCode(syrupType);
						if (mater.containsKey(syrupCode)) {
							int originCnt = mater.get(syrupCode);
							int changeCnt = originCnt + syrupCount;
							mater.put(syrupCode, changeCnt);
						} else {
							mater.put(syrupCode, syrupCount);
						}
					}

					// 우유
					if (milkType != null) {
						String milkCode = mapper.getMilkCode(milkType);
						if (mater.containsKey(milkCode)) {
							int originCnt = mater.get(milkCode);
							int changeCnt = originCnt + 1;
							mater.put(milkCode, changeCnt);
						} else {
							mater.put(milkCode, 1);
						}
					}

					// 휘핑크림
					if (whipType != null) {
						if (mater.containsKey("WHI01")) {
							int originCnt = mater.get("WHI01");
							int changeCnt = 0;
							if (whipType.equals("보통")) {
								changeCnt = originCnt + 1;
							} else if (whipType.equals("많이")) {
								changeCnt = originCnt + 2;
							}
							mater.put("WHI01", changeCnt);
						} else {
							if (whipType.equals("보통")) {
								mater.put("WHI01", 1);
							} else if (whipType.equals("많이")) {
								mater.put("WHI01", 2);
							}
						}
					}
				} else { // 메뉴코드의 앞글자가 B가 아니면(C 또는 M)
					// 메뉴코드로 재고코드 뽑아오기
					String code = mapper.getStockListCode(menuName);
					// 음료 외 메뉴코드 뽑아서 차감해야하는 기본재료 뽑기
					if (mater.containsKey(code)) {
						int originCnt = mater.get(code);
						int changeCnt = originCnt + quantity;
						mater.put(code, changeCnt);
					} else {
						mater.put(code, quantity);
					}
				}
				//System.out.println("최종 재료:" + mater);
				// {WHI01=2, BEV03=2, Grande=1, SYR02=1, BEV01=4, Tall=1, MIL05=1, MIL01=1}
			}
		}

		// 2. 차감해야하는 재료를 바탕으로 스토어 재고 확인
		// 지점 재고 수량 저장용
		Map<String, Integer> storeStocksCountMap = new HashMap<>();

		Iterator<String> keyIterator = mater.keySet().iterator();
		while (keyIterator.hasNext()) {
			String code = keyIterator.next();

			// 파라미터 저장용
			Map<String, Object> stocksParams = new HashMap<>();
			stocksParams.put("bucksId", bucksId);
			stocksParams.put("stockListCode", code);
			int storeStocksCount = mapper.getStoreStocksCount(stocksParams);

			storeStocksCountMap.put(code, storeStocksCount);
		}

		//System.out.println("지점재고:" + storeStocksCountMap);
		// 지점재고:{SAN03=10, BEV03=10, SYR03=10, BEV01=10, MIL04=10, Venti=10}

		// 3. 결과 처리
		boolean orderResult = false;
		
		// 부족한 재고
		Map<String, Object> notEnoughStocksMap = new HashMap<>();
		
		Iterator<String> resultIterator = mater.keySet().iterator();
		while (resultIterator.hasNext()) {
			String code = resultIterator.next();
			int needCount = mater.get(code);
			int remainCount = storeStocksCountMap.get(code);
			//System.out.println("확인:" + code + "(" + needCount + "/" + remainCount + ")");
			// 재고 수량 비교
			if (needCount <= remainCount) {
				orderResult = true;
			} else {
				int notEnoughQuantity = needCount - remainCount;
				String stockListName = mapper.getStocksName(code);
				notEnoughStocksMap.put("stockListName", stockListName);
				notEnoughStocksMap.put("notEnoughQuantity", notEnoughQuantity);
			}
			
			if(!notEnoughStocksMap.isEmpty()) {
				orderResult = false;
			}
		}
		//System.out.println(notEnoughStocksMap);
		//System.out.println("재고수량 비교 결과:" + orderResult); // true 또는 false
		
		boolean minusResult = false;
		boolean updateResult = false;
		boolean alarmResult = false;
		// 4. 재고 차감 및 상태업데이트
		// 재고 수량 비교한 결과가 true인 경우
		if(orderResult) {
			Iterator<String> countMinusIterator = mater.keySet().iterator();
			if (orderResult) {
				while (countMinusIterator.hasNext()) {
					String code = countMinusIterator.next();
					int value = mater.get(code);
					Map<String, Object> paramsCountMinus = new HashMap<>();
					paramsCountMinus.put("bucksId", bucksId);
					paramsCountMinus.put("stockListCode", code);
					paramsCountMinus.put("value", value);
					// 재고 차감
					int countMinusResult = mapper.updateCountMinus(paramsCountMinus);
					if (countMinusResult > 0) {
						minusResult = true;
					} else {
						minusResult = false;
					}
				}
				// 상태 업데이트
				int OrderStatusUpdateResult = mapper.updateOrderStatus(realOrderCode);
				if (OrderStatusUpdateResult > 0) {
					updateResult = true;
				} else {
					updateResult = false;
				}
			}
			
			// 5. 주문접수 알람 인서트
			Map<String, Object> paramsUserId = new HashMap<>();
			paramsUserId.put("orderCode", realOrderCode);
			paramsUserId.put("bucksId", bucksId);
			String userId = mapper.getUserId(paramsUserId);
			
			Map<String, Object> paramsAlarm = new HashMap<>();
			paramsAlarm.put("userId", userId);
			String alarmCont = orderCode +"번 주문이 접수되었습니다. 잠시만 기다려주세요!";
			paramsAlarm.put("alarmCont", alarmCont);
			int alarmInsertResult = mapper.insertOrderAlarm(paramsAlarm);
			
			if(alarmInsertResult > 0) {
				alarmResult = true;
			}else {
				alarmResult = false;
			}
		}
		
		Map<Object, Object> response = new HashMap<>();
		response.put("notEnoughStocksMap", notEnoughStocksMap);

		if (orderResult && minusResult && updateResult && alarmResult) {
			response.put("response", "success");
		} else if (!orderResult) {
			response.put("response", "notEnough");
		} else if (!minusResult) {
			response.put("response", "stockMinusFail");
		} else if (!updateResult) {
			response.put("response", "orderStatusFail");
		} else if (!alarmResult) {
			response.put("response", "alarmInsertFail");
		} else {
			response.put("response", "fail");
		}

		return ResponseEntity.ok(response);

	}

	@PostMapping("/orderCancel.ajax")
	public ResponseEntity<Map<String, Object>> orderCancel(HttpServletRequest req, String orderCode) {
		//System.out.println("orderCode :" + orderCode);

		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
		String today = dateFormat.format(date);

		String realOrderCode = today + "_" + orderCode;
		//System.out.println(realOrderCode); // 240826_A-005

		Map<String, Object> params = new HashMap<>();
		params.put("bucksId", bucksId);
		params.put("orderCode", realOrderCode);
		
		// 상태 취소 업데이트
		boolean cancelUpdate = false;
		int cancelResult = mapper.orderStatusUpdateCancel(params);
		if(cancelResult > 0) {
			cancelUpdate = true;
		} else {
			cancelUpdate = false;
		}
		
		// 주문 취소 알람 인서트
		boolean alarmResult = false;
		Map<String, Object> paramsUserId = new HashMap<>();
		paramsUserId.put("orderCode", realOrderCode);
		paramsUserId.put("bucksId", bucksId);
		String userId = mapper.getUserId(paramsUserId);
		
		Map<String, Object> paramsAlarm = new HashMap<>();
		paramsAlarm.put("userId", userId);
		String alarmCont = orderCode +"번 주문이 취소되었습니다.";
		paramsAlarm.put("alarmCont", alarmCont);
		int alarmInsertResult = mapper.insertOrderAlarm(paramsAlarm);
		
		if(alarmInsertResult > 0) {
			alarmResult = true;
		}else {
			alarmResult = false;
		}
		
		Map<String, Object> response = new HashMap<>();
		
		if(cancelUpdate && alarmResult) {
			response.put("response", "success");
		} else if(!cancelUpdate) {
			response.put("response", "cancelUpdateFail");
		} else {
			response.put("response", "alarmInsertFail");
		}
		
		return ResponseEntity.ok(response);
	}

	@PostMapping("/orderFinish.ajax")
	public ResponseEntity<Map<String, Object>> orderFinish(HttpServletRequest req, String orderCode) {
		// System.out.println("orderCode :" + orderCode);

		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
		String today = dateFormat.format(date);

		String realOrderCode = today + "_" + orderCode;
		// System.out.println(realOrderCode); // 240826_A-005
		
		// 제조완료 상태 업데이트
		boolean orderFinish = false;
		//System.out.println("orderCode : "+orderCode);
		
		// 매장주문, togo 주문인 경우
		if(orderCode.substring(0, 1).equals("A") || orderCode.substring(0, 1).equals("B")) {
			Map<String, Object> params = new HashMap<>();
			params.put("bucksId", bucksId);
			params.put("orderCode", realOrderCode);
			int finishResult = mapper.orderStatusUpdateFinish(params);
			if(finishResult > 0) {
				orderFinish = true;
			} else {
				orderFinish = false;
			}
		// 배달주문인 경우
		}else {
			Map<String, Object> params = new HashMap<>();
			params.put("bucksId", bucksId);
			params.put("orderCode", realOrderCode);
			int finishResult = mapper.deliverStatusUpdateFinish(params);
			if(finishResult > 0) {
				orderFinish = true;
			} else {
				orderFinish = false;
			}
		}
		
		// 제조 완료 알람 인서트
		boolean alarmResult = false;
		Map<String, Object> paramsUserId = new HashMap<>();
		paramsUserId.put("orderCode", realOrderCode);
		paramsUserId.put("bucksId", bucksId);
		String userId = mapper.getUserId(paramsUserId);
		
		Map<String, Object> paramsAlarm = new HashMap<>();
		paramsAlarm.put("userId", userId);
		
		// 매장주문, togo 주문인 경우
		String alarmCont = null;
		if(orderCode.substring(0, 1).equals("A") || orderCode.substring(0, 1).equals("B")) {
			alarmCont = orderCode +"번 메뉴가 준비되었습니다. 픽업대에서 메뉴를 픽업해주세요!";
			paramsAlarm.put("alarmCont", alarmCont);
		}
		// 배달주문인 경우
		else {
			alarmCont = orderCode +"번 주문의 제조가 완료되어 배달 대기중입니다.";
			paramsAlarm.put("alarmCont", alarmCont);
		}
		
		int alarmInsertResult = mapper.insertOrderAlarm(paramsAlarm);
		if(alarmInsertResult > 0) {
			alarmResult = true;
		}else {
			alarmResult = false;
		}
		
		// 결과 처리
		Map<String, Object> response = new HashMap<>();
		if(orderFinish && alarmResult) {
			response.put("response", "success");
		} else if(!orderFinish) {
			response.put("response", "finishUpdateFail");
		} else if(!alarmResult) {
			response.put("response", "alarmInsertFail");	
		} else {
			response.put("response", "Fail");
		}

		return ResponseEntity.ok(response);
	}
	
	// 신규주문 막기
	@PostMapping("/orderStop.ajax")
	public ResponseEntity<Map<String, Object>> orderStop(HttpServletRequest req) {
		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

		int orderStopResult = mapper.storemenuStatusStop(bucksId);

		Map<String, Object> response = new HashMap<>();

		if (orderStopResult > 0) {
			response.put("response", "success");
		} else {
			response.put("response", "fail");
		}

		return ResponseEntity.ok(response);
	}
	
	// 신규주문 재시작
	@PostMapping("/orderRestart.ajax")
	public ResponseEntity<Map<String, Object>> orderRestart(HttpServletRequest req) {
		// 세션에서 ID꺼내기
		this.session = req.getSession();
		BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();

		int restartResult = mapper.storemenuStatusRestart(bucksId);

		Map<String, Object> response = new HashMap<>();

		if (restartResult > 0) {
			response.put("response", "success");
		} else {
			response.put("response", "fail");
		}

		return ResponseEntity.ok(response);
	}
	
	// 배달준비 상태인 주문건 배달완료로 상태 업데이트 메서드
	private void fetchDeliversFinish() {
		if(this.session != null) {
			BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
			String bucksId = dto.getBucksId();
			
			// 오늘 날짜 가져오기
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String today = dateFormat.format(date);
            
			// 알람 인서트
			Map<String, Object> paramsAlarm = new HashMap<>();
			// 배달준비 orderCode 가져오기
			List<OrderDTO> deliversReady = mapper.getDeliversReady();
			if(!deliversReady.isEmpty()) {
				for(int i=0; i<deliversReady.size(); i++) {
					String orginOrderCode = deliversReady.get(i).getOrderCode();
					String alarmOrderCode = orginOrderCode.substring(7, 12); 
					String alarmCont = alarmOrderCode +"번 배달이 완료되었습니다.";
					paramsAlarm.put("alarmCont", alarmCont);
					paramsAlarm.put("userId", deliversReady.get(i).getUserId());
					int insertDeliversFinishAlarm = mapper.insertDeliversFinishAlarm(paramsAlarm);
					//System.out.println("배달완료 알람 인서트 완료");
				}
			}
			
			// 배달완료 업데이트
			int updateStatusDeliversFinish = mapper.deliverStatusUpdateDeliversFinish();
			
			// 패치 확인
            //System.out.println("배달완료 Fetched: " + date.toString());
		}
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

					for (OrderOptDTO dto : optList) {
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// 주문현황 페이징 처리 메서드
	public Map<String, Object> paging(int count, int pageNum) {
		int pageSize = 1; // 한 페이지에 보여질 게시글 수
		int startRow = (pageNum - 1) * pageSize + 1; // 페이지별 시작 넘버
		int endRow = startRow + pageSize - 1; // 페이지별 끝 넘버
		if (endRow > count)
			endRow = count;
		int no = count - startRow + 1; // 넘버링
		int pageBlock = 1; // 페이지별 보여줄 페이징번호 개수
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); // 총 페이징번호 개수
		int startPage = (pageNum - 1) / pageBlock * pageBlock + 1; // 페이지별 시작 페이징번호
		int endPage = startPage + pageBlock - 1; // 페이지별 끝 페이징번호
		if (endPage > pageCount)
			endPage = pageCount;

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
	
	// 주문현황 제조중 페이징 처리 메서드
	public Map<String, Object> paging_making(int count, int pageNum) {
		int pageSize = 2; // 한 페이지에 보여질 게시글 수
		int startRow = (pageNum - 1) * pageSize + 1; // 페이지별 시작 넘버
		int endRow = startRow + pageSize - 1; // 페이지별 끝 넘버
		if (endRow > count)
			endRow = count;
		int no = count - startRow + 1; // 넘버링
		int pageBlock = 1; // 페이지별 보여줄 페이징번호 개수
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); // 총 페이징번호 개수
		int startPage = (pageNum - 1) / pageBlock * pageBlock + 1; // 페이지별 시작 페이징번호
		int endPage = startPage + pageBlock - 1; // 페이지별 끝 페이징번호
		if (endPage > pageCount)
			endPage = pageCount;

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

	@Scheduled(cron = "3 * * * * *") 
	public void ScheduledFetchOrder(){
		fetchOrder();
	}
	
	@Scheduled(cron = "3 * * * * *") 
	public void ScheduledFetchDeliverFinishOrder(){
		fetchDeliversFinish();
	}
}