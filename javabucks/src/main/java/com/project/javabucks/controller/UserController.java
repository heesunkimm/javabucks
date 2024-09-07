package com.project.javabucks.controller;

import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.javabucks.dto.AlarmDTO;
import com.project.javabucks.dto.BucksDTO;
import com.project.javabucks.dto.CardDTO;
import com.project.javabucks.dto.CardListDTO;
import com.project.javabucks.dto.CartDTO;
import com.project.javabucks.dto.CartToPay;
import com.project.javabucks.dto.CartToPay2;
import com.project.javabucks.dto.CouponListDTO;
import com.project.javabucks.dto.FrequencyDTO;
import com.project.javabucks.dto.MenuDTO;
import com.project.javabucks.dto.MenuOptCupDTO;
import com.project.javabucks.dto.MenuOptIceDTO;
import com.project.javabucks.dto.MenuOptMilkDTO;
import com.project.javabucks.dto.MenuOptShotDTO;
import com.project.javabucks.dto.MenuOptSyrupDTO;
import com.project.javabucks.dto.MenuOptWhipDTO;
import com.project.javabucks.dto.MenuOrder;
import com.project.javabucks.dto.MymenuDTO;
import com.project.javabucks.dto.OrderDTO;
import com.project.javabucks.dto.OrderOptDTO;
import com.project.javabucks.dto.PayhistoryDTO;
import com.project.javabucks.dto.UserDTO;
import com.project.javabucks.mapper.UserMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	UserMapper userMapper;

	// 읽지않은 알림갯수 보여주기
	@GetMapping("/noReadAlarmCheck.ajax")
	@ResponseBody
	public int noReadAlarmCheck(@RequestParam String userId) {
		List<AlarmDTO> alarmCheck = userMapper.noReadAlarm(userId);
		if (alarmCheck != null) {
			return alarmCheck.size();
		}
		return 0;
	}

	// 알람 상태 업데이트
	@PostMapping("/readAllAlarms.ajax")
	@ResponseBody
	public void readAllAlarms(@RequestParam String userId) {
		userMapper.readAlarmUpdate(userId);
	}

	// 채성진 작업-------------------------------------------------------------------
	@RequestMapping("/user_index")
	public String userIndex(HttpSession session, HttpServletRequest req, String mode) {
		// 등급(리워드)
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();

		UserDTO userDTO = userMapper.getInfoById(userId);
		// 등급 업그레이드 전 별 갯수
		int tot = 0;
		int nowStar = 0;
		int realStar = 0;
		int untilStar = 0;
		int updateCount = 0;
		int gage = 0;
		int nextGrade = 0;
		Map<String, Object> params = new HashMap<>();
		Map<String, String> params2 = new HashMap<>();
		params.put("userId", userId);
		params2.put("userId", userId);
		// 현재 등급을 가져오기
		if (userDTO.getGradeCode().equals("welcome")) {
			// 등급 업글된 이후 모아온 별 갯수
			List<FrequencyDTO> frqDTO = userMapper.getFrequencyById(userId);

			for (FrequencyDTO fdt : frqDTO) {
				// 업그레이드 이후 적립된 별 갯수 합
				tot += fdt.getFrequencyCount();
			}
			// 현재 별 갯수
			nowStar = tot;
			// green 가려면 5개
			gage = (int) ((nowStar / 5.0) * 100);
			untilStar = 5 - nowStar;
			req.setAttribute("untilStar", untilStar);
			req.setAttribute("maxStar", "5");
			req.setAttribute("frequency", nowStar);
			req.setAttribute("until", "Green Level");
			req.setAttribute("progress_bar", gage);

			// 별 모은 갯수 5개 넘으면 업그레이드
			if (nowStar >= 5) {
				updateCount = nowStar - 5;
				// 남은 별 session에 저장
				udto.setReaminStar(updateCount);
				session.setAttribute("inUser", udto);
				// 별이 일정갯수보다 많으면 알아서 업그레이드!
				int res = userMapper.updateGreen(userId);
				// 업그레이드 시 알람 추가
				params2.put("grade", "Green");
				params2.put("coupon", "[GREEN 등급 업그레이드]");
				int cpup = userMapper.cpnInsertGreen(userId);
				int upres = userMapper.insertAlamUpgrade(params2);
				int cpres = userMapper.insertAlamCoupon(params2);
				nowStar = updateCount;
				// gold 가려면 15
				gage = (int) ((nowStar / 15.0) * 100);
				untilStar = 15 - nowStar;
				req.setAttribute("untilStar", untilStar);
				req.setAttribute("maxStar", "15");
				req.setAttribute("frequency", nowStar);
				req.setAttribute("until", "Gold Level");
				req.setAttribute("progress_bar", gage);	
			}

		} else if (userDTO.getGradeCode().equals("green")) {
			// 업글 전 모아온 갯수
			List<FrequencyDTO> frqDTO = userMapper.getFrequencyById(userId);

			for (FrequencyDTO fdt : frqDTO) {
				// 업그레이드 이후 적립된 별 갯수 합
				tot += fdt.getFrequencyCount();
			}
			// 남은 별 + 업그레이드 이후 적립한 별
			realStar = udto.getReaminStar() + tot;
			nowStar = realStar;

			// gold 가려면 15
			gage = (int) ((nowStar / 15.0) * 100);
			untilStar = 15 - nowStar;
			req.setAttribute("untilStar", untilStar);
			req.setAttribute("maxStar", "15");
			req.setAttribute("frequency", nowStar);
			req.setAttribute("until", "Gold Level");

			req.setAttribute("progress_bar", gage);

			// 등급 업그레이드 후 별 갯수 업데이트
			if (realStar >= 15) {
				updateCount = realStar - 15;
				// 남은 별 session에 저장
				udto.setReaminStar(updateCount);
				session.setAttribute("inUser", udto);
				// 별이 일정갯수보다 많으면 알아서 업그레이드!
				int res = userMapper.updateGold(userId);
				// 업그레이드 시 알람 추가
				params2.put("grade", "Gold");
				params2.put("coupon", "[GOLD 등급 업그레이드]");
				int cpup = userMapper.cpnInsertGold(userId);
				int upres = userMapper.insertAlamUpgrade(params2);
				int cpres = userMapper.insertAlamCoupon(params2);
				nowStar = updateCount;

				gage = (int) ((nowStar / 30.0) * 100);
				untilStar = 30 - nowStar;
				req.setAttribute("untilStar", untilStar);
				req.setAttribute("maxStar", "30");
				req.setAttribute("frequency", nowStar);
				req.setAttribute("until", "next Reward");
				req.setAttribute("progress_bar", gage);
			}

		} else {
			List<FrequencyDTO> frqDTO = userMapper.getFrequencyById(userId);

			// 업그레이드 이후 적립된 별 갯수 합
			for (FrequencyDTO fdt : frqDTO) {

				tot += fdt.getFrequencyCount();
			}
			// 남은 별 + 업그레이드 이후 적립한 별
			// nowStar 진짜 현재 갯수(초과된 별 갯수 + 쌓은 별 갯수)
			nowStar = udto.getReaminStar() + tot;
			// 다음 등급 위해 필요한 갯수
			nextGrade = 30 - nowStar;

			if (nowStar >= 30) {
				// updateCount 초과된 별 저장
				updateCount = nowStar - 30;

				// 남은 별 session에 저장
				udto.setReaminStar(updateCount);
				session.setAttribute("inUser", udto);
				// 등급 업그레이드
				int res = userMapper.updateGoldAfter(userId);
				// 업그레이드 시 알람 추가
				params2.put("coupon", "[무료 음료 1잔]");
				int cpdr = userMapper.cpnInsertDrink(userId);
				int cpres = userMapper.insertAlamCoupon(params2);

				// goldaward 가려면 30개
				gage = (int) ((updateCount / 30.0) * 100);
				nextGrade = 30 - updateCount;
				req.setAttribute("untilStar", nextGrade);
				req.setAttribute("maxStar", "30");
				req.setAttribute("frequency", updateCount);
				req.setAttribute("until", "next Reward");
				req.setAttribute("progress_bar", gage);

			} else {
				gage = (int) ((nowStar / 30.0) * 100);
				req.setAttribute("untilStar", nextGrade);
				req.setAttribute("maxStar", "30");
				req.setAttribute("frequency", nowStar);
				req.setAttribute("until", "next Reward");
				req.setAttribute("progress_bar", gage);
			}
		}
		req.getSession().setAttribute("inUser", udto);

		// s: 핑복코드 - 메인 top3 추천메뉴
		List<OrderDTO> orderInfoList = userMapper.getOrderList(userId);
		ObjectMapper objectMapper = new ObjectMapper();

		Map<String, Integer> menuCountMap = new HashMap<>();

		if (!orderInfoList.isEmpty()) {
			// 결제 내역이 있을 경우
			for (OrderDTO order : orderInfoList) {
				try {
					List<String> orderList = objectMapper.readValue(order.getOrderList(),
							objectMapper.getTypeFactory().constructCollectionType(ArrayList.class, String.class));

					List<MenuOrder> updateOrderHistory = new ArrayList<>();

					for (String orderItem : orderList) {
						String[] s = orderItem.split(":");
						String menuCode = s[0];
						String optId = s[1];
						int quantity = Integer.parseInt(s[2]);

						MenuOrder menuOrder = new MenuOrder(menuCode, optId, quantity);
						String menuName = userMapper.getMenuName(menuCode);
						menuOrder.setMenuName(menuName);

						updateOrderHistory.add(menuOrder);
						menuCountMap.merge(menuCode, quantity, Integer::sum);
					}

					order.setOrderListbyMenuOrder(updateOrderHistory);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			// value 값을 기준으로 정렬한 후, 상위 3개의 키를 추출
			List<Map.Entry<String, Integer>> entryList = new ArrayList<>(menuCountMap.entrySet());
			entryList.sort((entry1, entry2) -> entry2.getValue().compareTo(entry1.getValue()));

			List<String> top3MenuCodes = new ArrayList<>();
			for (int i = 0; i < Math.min(3, entryList.size()); i++) {
				top3MenuCodes.add(entryList.get(i).getKey());
			}

			// 상위 3개의 메뉴 정보를 DB에서 조회
			List<MenuDTO> top3MenuNames = userMapper.top3MenuNames(top3MenuCodes);
			
			// 신규 이미지 추가했을 때 뒤에꺼만 짤라서 SET
		    for(int i=0; i<top3MenuNames.size(); i++) {
		    	//System.out.println(top3MenuNames.get(i).getMenuImages()); // eefadab4_BESMIPIS.jpg
		    	String imageName = top3MenuNames.get(i).getMenuImages();;
		    	//System.out.println(imageName.length());
		    	if(imageName.length() != 12) {
		    		String imageName2 = imageName.substring(9, 21);
		    		top3MenuNames.get(i).setMenuImages(imageName2);
		    	}
		    }
			req.setAttribute("top3MenuNames", top3MenuNames);
			
		} else {
			// 결제 내역이 없을 경우 최신 메뉴 3개를 가져옴
			List<MenuDTO> top3MenuNames = userMapper.getLatestMenus();
			
			// 신규 이미지 추가했을 때 뒤에꺼만 짤라서 SET
		    for(int i=0; i<top3MenuNames.size(); i++) {
		    	System.out.println(top3MenuNames.get(i).getMenuImages()); // eefadab4_BESMIPIS.jpg
		    	String imageName = top3MenuNames.get(i).getMenuImages();;
		    	System.out.println(imageName.length());
		    	if(imageName.length() != 12) {
		    		String imageName2 = imageName.substring(9, 21);
		    		top3MenuNames.get(i).setMenuImages(imageName2);
		    	}
		    }
			
			req.setAttribute("top3MenuNames", top3MenuNames);
		}
		// e: 핑복코드
		return "/user/user_index";
	}

	@RequestMapping("/user_cpnhistory")
	public String ListCpnhistory(HttpSession session, HttpServletRequest req) {
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		List<CouponListDTO> list = userMapper.getCouponListById(userId);
		for (CouponListDTO tt : list) {
			String endDate = tt.getCpnListEndDate().substring(0, 10);
			tt.setCpnListEndDate(endDate);
		}
		req.setAttribute("couponlist", list);
		return "/user/user_cpnhistory";
	}

	@RequestMapping("/user_delivers")
	public String userDelivers(HttpServletRequest req, @RequestParam Map<String, String> params, String mode,
			String storeSearch) {
		// 매장 검색하기
		if (mode != null) {
			if (storeSearch != null && !storeSearch.trim().isEmpty()) {
				// 공백을 기준으로 문자열을 분리하여 List로 저장
				List<String> searchTerms = Arrays.asList(storeSearch.split("\\s+"));
				List<BucksDTO> list = userMapper.getStoreList2(searchTerms);
				for (BucksDTO dto : list) {
					String orderEnalbe = userMapper.getOrderEnableBybucksId(dto.getBucksId());
					dto.setOrderEnalbe(orderEnalbe);
					
					// 시간가져와서 00:00식으로 변환
					String startTime = dto.getBucksStart();
					String st = startTime.substring(11, 16);
					String endTime = dto.getBucksEnd();
					String ed = endTime.substring(11, 16);
					
					// 시간을 비교하기 위해 LocalTime으로 변환
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
					LocalTime start = LocalTime.parse(st, formatter);
					LocalTime end = LocalTime.parse(ed, formatter);
					LocalTime now = LocalTime.now();
					
					// 현재 시간과 비교
					if (now.isBefore(start) || now.isAfter(end)) {
						dto.setOrderEnalbe("N");
					}
					dto.setBucksStart(st);
					dto.setBucksEnd(ed);
					
				}
				req.setAttribute("storeSearch", storeSearch);
				req.setAttribute("storeList", list);

			} else {
				List<BucksDTO> list = userMapper.getStoreList(storeSearch);
				for (BucksDTO dto : list) {
					String orderEnalbe = userMapper.getOrderEnableBybucksId(dto.getBucksId());
					dto.setOrderEnalbe(orderEnalbe);
					
					// 시간가져와서 00:00식으로 변환
					String startTime = dto.getBucksStart();
					String st = startTime.substring(11, 16);
					String endTime = dto.getBucksEnd();
					String ed = endTime.substring(11, 16);
					
					// 시간을 비교하기 위해 LocalTime으로 변환
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
					LocalTime start = LocalTime.parse(st, formatter);
					LocalTime end = LocalTime.parse(ed, formatter);
					LocalTime now = LocalTime.now();
					
					// 현재 시간과 비교
					if (now.isBefore(start) || now.isAfter(end)) {
						dto.setOrderEnalbe("N");
					}
					dto.setBucksStart(st);
					dto.setBucksEnd(ed);
				}
				req.setAttribute("storeSearch", storeSearch);
				req.setAttribute("storeList", list);
			}
		}
		return "/user/user_delivers";
	}

	@RequestMapping("/user_order")
	public String orderMenu(HttpSession session, HttpServletRequest req, String storeName, String pickup, String bucksId) {

		// [음료] 정보, 주문가능한지
		List<MenuDTO> list = userMapper.getStoreDrinkList(storeName);
		
		// 신규 이미지 추가했을 때 뒤에꺼만 짤라서 SET
	    for(int i=0; i<list.size(); i++) {
	    	//System.out.println(top3MenuNames.get(i).getMenuImages()); // eefadab4_BESMIPIS.jpg
	    	String imageName = list.get(i).getMenuImages();;
	    	//System.out.println(imageName.length());
	    	if(imageName.length() != 12) {
	    		String imageName2 = imageName.substring(9, 21);
	    		list.get(i).setMenuImages(imageName2);
	    	}
	    }
		
		Map<String, String> params = new HashMap<>();
		for (MenuDTO md : list) {
			
			params.put("menuCode", md.getMenuCode());
			params.put("bucksId", bucksId);
			String storeEnable = userMapper.getStoreEnable(params);
			String storemenuStatus = userMapper.getMenuStatus(params);
			String menuStatus = userMapper.getMenuStatus2(params);
			md.setStoremenuStatus(storemenuStatus);
			md.setMenuStatus(menuStatus); 
			md.setStoreEnable(storeEnable); 
		} 

		// [음식] 정보, 주문가능한지
		List<MenuDTO> list2 = userMapper.getStoreFoodList(storeName);
		for (MenuDTO md : list2) {
			
			params.put("menuCode", md.getMenuCode());
			params.put("bucksId", bucksId);
			String storeEnable = userMapper.getStoreEnable(params);
			String storemenuStatus = userMapper.getMenuStatus(params);
			String menuStatus = userMapper.getMenuStatus2(params);
			md.setStoremenuStatus(storemenuStatus);
			md.setMenuStatus(menuStatus);
			md.setStoreEnable(storeEnable);
		}
		// [상품] 정보, 주문가능한지
		List<MenuDTO> list3 = userMapper.getStoreProdcutList(storeName);
		for (MenuDTO md : list3) {
			
			params.put("menuCode", md.getMenuCode());
			params.put("bucksId", bucksId);
			String storeEnable = userMapper.getStoreEnable(params);
			String storemenuStatus = userMapper.getMenuStatus(params);
			String menuStatus = userMapper.getMenuStatus2(params);
			md.setStoremenuStatus(storemenuStatus);
			md.setMenuStatus(menuStatus);
			md.setStoreEnable(storeEnable);
		}
		Map<String, String> params2 = new HashMap<>();
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		params2.put("userId", userId);
		
		if("매장이용".equals(pickup)) {
			params2.put("cartType", "order");
		}else if("To-go".equals(pickup)) {
			params2.put("cartType", "togo");
		}else {
			params2.put("cartType", "delivers");
		}
		int totCnt = 0;
		List<CartDTO> cartList = userMapper.CartManyByUserid(params2);
		for(CartDTO tt : cartList) {
			totCnt += tt.getcartCnt();
		}
		req.setAttribute("cartCount", totCnt);
		req.setAttribute("drinkList", list);
		req.setAttribute("foodList", list2);
		req.setAttribute("productList", list3);
		req.setAttribute("storeName", storeName);
		req.setAttribute("pickup", pickup);
		req.setAttribute("bucksId", bucksId);

		return "/user/user_order";
	}

	@RequestMapping("/user_menudetail")
	public String menudetail(HttpSession session, HttpServletRequest req, @RequestParam Map<String, String> params) {

		// 메뉴코드로 메뉴정보 꺼내오기
		String menuCode = params.get("menuCode");
		String menuoptCode;
		// order페이지에서 넘어왔는지
		if ("origin".equals(params.get("mode"))) {
			menuoptCode = params.get("menuoptCode");
			// mymenu에서 넘어왔는지
		} else {
			menuoptCode = userMapper.getMenuOptCode(menuCode);
			if (menuCode.startsWith("B")) {
				params.put("menuCode", menuCode);
				params.put("drink", "drink");
			}
		}

		// mymenu에 담겨있으면 하트 표시
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		params.put("userId", userId);
		MymenuDTO mm = userMapper.SearchMyMenu(params);
		if (mm != null) {
			req.setAttribute("mymenuCheck", "mymenuCheck");
		}
		
		// mymenu페이지에서 넘어왔으면
        if(params.get("storeName") == null) {
        	BucksDTO bk = userMapper.getBucksinfoById(params.get("bucksId"));
        	String storeName = bk.getBucksName();
        	params.put("storeName", storeName);
        }

		MenuDTO dto = userMapper.getMenuInfoByCode(menuCode);
		req.setAttribute("menu", dto);
		req.setAttribute("drink", params.get("drink"));
		req.setAttribute("bucksId", params.get("bucksId"));
		req.setAttribute("storeName", params.get("storeName"));
		req.setAttribute("pickup", params.get("pickup"));

		// 음료메뉴 퍼스널옵션값 가져오기
		if ("drink".equals(params.get("drink"))) {
			MenuOptShotDTO dto2 = userMapper.ShotByCode(menuoptCode);
			req.setAttribute("shot", dto2);
		}
		List<MenuOptCupDTO> list1 = userMapper.CupSizeByCode(menuoptCode);
		List<MenuOptIceDTO> list2 = userMapper.IceByCode(menuoptCode);
		List<MenuOptWhipDTO> list3 = userMapper.WhipByCode(menuoptCode);
		List<MenuOptSyrupDTO> list4 = userMapper.SyrupByCode(menuoptCode);
		List<MenuOptMilkDTO> list5 = userMapper.MilkByCode(menuoptCode);
		req.setAttribute("cup", list1);
		req.setAttribute("ice", list2);
		req.setAttribute("whip", list3);
		req.setAttribute("syrup", list4);
		req.setAttribute("milk", list5);

		if (list2 == null || list2.isEmpty())
			req.setAttribute("isIce", "not");
		else
			req.setAttribute("isIce", "ok");
		if (list5 == null || list5.isEmpty())
			req.setAttribute("isMilk", "not");
		else
			req.setAttribute("isMilk", "ok");

		return "/user/user_menudetail";
	}

	@ResponseBody
	@PostMapping("/AddMyMenu.ajax")
	public int AddMyMenu(HttpSession session, HttpServletRequest req, @RequestBody Map<String, String> params) {

		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		params.put("userId", userId);
		MymenuDTO tt = userMapper.SearchMyMenu(params);
		if (tt != null) {
			int res2 = userMapper.DeleteMyMenu(params);
			return -1;
		}
		int res = userMapper.AddMyMenu(params);

		return res;
	}

	@RequestMapping("/user_starhistory")
	public String userStarhistory(HttpSession session, HttpServletRequest req,
			@RequestParam Map<String, String> params) {

		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		params.put("userId", userId);
		int star = 0;

		// 날짜 형식을 설정합니다.
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		// 현재 날짜를 가져옵니다.
		LocalDate today = LocalDate.now();
		// 한 달 전의 날짜를 계산합니다.
		LocalDate oneMonthAgo = today.minusMonths(1);
		// 세 달 전의 날짜를 계산합니다.
		LocalDate threeMonthAgo = today.minusMonths(3);
		// 날짜를 문자열로 변환합니다.
		String endDate = today.format(formatter);

		// 기간을 설정하고 확인눌렀다면
		if (params.get("mode") != null) {
			// 1개월 선택 시
			if (params.get("period_startdate").equals("1month")) {
				String startDate = oneMonthAgo.format(formatter);
				String period_setting = startDate + " ~ " + endDate;
				req.setAttribute("period_setting", period_setting);
				// 1개월 별 히스토리 조회
				params.put("startDate", startDate);
				params.put("endDate", endDate);
				List<FrequencyDTO> list = userMapper.StarHistoryByUserid(params);

				// 별 갯수, 유효기간
				for (FrequencyDTO freq : list) {
					LocalDate regDate = LocalDate.parse(freq.getFrequencyRegDate(), dateTimeFormatter);
					LocalDate validityDate = regDate.plusYears(1);
					freq.setFrequencyEndDate(validityDate.format(formatter));
					star += freq.getFrequencyCount();
				}
				req.setAttribute("star", star);
				req.setAttribute("starHistory", list);

				// 3개월 선택 시
			} else if (params.get("period_startdate").equals("3months")) {
				String startDate = threeMonthAgo.format(formatter);
				String period_setting = startDate + " ~ " + endDate;
				req.setAttribute("period_setting", period_setting);

				// 3개월 별 히스토리 조회
				params.put("startDate", startDate);
				params.put("endDate", endDate);
				List<FrequencyDTO> list = userMapper.StarHistoryByUserid(params);

				// 별 갯수
				for (FrequencyDTO freq : list) {
					LocalDate regDate = LocalDate.parse(freq.getFrequencyRegDate(), dateTimeFormatter);
					LocalDate validityDate = regDate.plusYears(1);
					freq.setFrequencyEndDate(validityDate.format(formatter));
					star += freq.getFrequencyCount();
				}
				req.setAttribute("star", star);
				req.setAttribute("starHistory", list);

				// 기간설정 버튼눌렀을때
			} else {
				String period_setting = params.get("startDate") + " ~ " + params.get("endDate");
				req.setAttribute("period_setting", period_setting);
				List<FrequencyDTO> list = userMapper.StarHistoryByUserid(params);

				// 별 갯수
				for (FrequencyDTO freq : list) {
					LocalDate regDate = LocalDate.parse(freq.getFrequencyRegDate(), dateTimeFormatter);
					LocalDate validityDate = regDate.plusYears(1);
					freq.setFrequencyEndDate(validityDate.format(formatter));
					star += freq.getFrequencyCount();
				}
				req.setAttribute("star", star);
				req.setAttribute("starHistory", list);
			}

		} else {
			String startDate = oneMonthAgo.format(formatter);
			// period_setting 문자열을 생성합니다.
			String period_setting = startDate + " ~ " + endDate;
			// 요청 속성에 설정합니다.
			req.setAttribute("period_setting", period_setting);

			params.put("startDate", startDate);
			params.put("endDate", endDate);
			List<FrequencyDTO> list = userMapper.StarHistoryByUserid(params);

			// 유효기간을 계산하여 DTO에 추가
			for (FrequencyDTO freq : list) {
				LocalDate regDate = LocalDate.parse(freq.getFrequencyRegDate(), dateTimeFormatter);
				LocalDate validityDate = regDate.plusYears(1);
				freq.setFrequencyEndDate(validityDate.format(formatter));
				star += freq.getFrequencyCount();
			}
			req.setAttribute("starHistory", list);
			req.setAttribute("star", star);
		}
		return "/user/user_starhistory";
	}

	@RequestMapping("/user_mymenu")
	public String userMymenu(HttpSession session, HttpServletRequest req, String mode,
			@RequestParam Map<String, String> params) {
		
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();

		// 나만의메뉴 X 눌렀을때
		if (mode != null) {
			params.put("userId", userId);
			int mymenuNum = userMapper.MyMenuNumByUserid(params);
			int res = userMapper.MyMenuDeleteByMenuNum(mymenuNum);
			if (res > 0) {
				req.setAttribute("msg", "나만의메뉴가 삭제되었습니다.");
				req.setAttribute("url", "user_mymenu");
				return "message";
			} else {
				req.setAttribute("msg", "나만의메뉴 삭제 중 오류가 발생하였습니다.");
				req.setAttribute("url", "user_mymenu");
				return "message";
			}
		}
		
		params.put("userId", userId);
		List<MenuDTO> list = userMapper.MyMenuByUserid(userId);
		for(MenuDTO tt : list) {
			
			// 메뉴코드랑 id 넣어서 mymenu 조회
			params.put("menuCode", tt.getMenuCode());
			MymenuDTO mm =  userMapper.SearchMyMenu(params);
			// 조회한 mymenu 매장 id를 list에 넣어주기
			tt.setBucksId(mm.getBucksId());
		}
		// 벅스id 가져와서 마이메뉴 페이지에 넣어주기
		
		req.setAttribute("mymenu", list);

		return "/user/user_mymenu";
	}

	@RequestMapping("/user_recepit")
	public String userRecepit(HttpSession session, HttpServletRequest req, @RequestParam Map<String, String> params,
			String mode) {

		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();

		params.put("userId", userId);
		int totalPrice = 0;
		int number = 0;

		// 날짜 형식을 설정합니다.
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// 현재 날짜를 가져옵니다.
		LocalDate today = LocalDate.now();
		// 한 달 전의 날짜를 계산합니다.
		LocalDate oneMonthAgo = today.minusMonths(1);
		// 현재 날짜를 기준으로 1년 전 날짜를 구합니다.
		LocalDate oneYearAgo = LocalDate.now().minusYears(1);
		// 날짜를 문자열로 변환합니다.
		String endDate = today.format(formatter);
		params.put("endDate", endDate);
		// 기간을 설정하고 확인눌렀다면
		if (params.get("mode") != null) {

			// 토글 기본 날짜 세팅
			String basicEndDate = today.format(outputFormatter);
			String basicStartDate = oneMonthAgo.format(outputFormatter);
			req.setAttribute("startDate", basicStartDate);
			req.setAttribute("endDate", basicEndDate);

			// 결제유형
			if ("charge".equals(params.get("paytype"))) {
				params.put("payhistoryPayType", "충전");
			} else if ("pay".equals(params.get("paytype"))) {
				params.put("payhistoryPayType", "주문결제");
			}

			// 결제수단
			if ("card".equals(params.get("payway"))) {
				params.put("payhistoryPayWay", "자바벅스카드");
			} else {
				params.put("payhistoryPayWay", "카카오페이");
			}

			// 1개월 선택 시
			if ("1month".equals(params.get("period"))) {
				String startDate = oneMonthAgo.format(formatter);
				String period_setting = startDate + " ~ " + endDate;
				req.setAttribute("period_setting", period_setting);
				params.put("startDate", startDate);

				// 1년 선택 시
			} else if ("1year".equals(params.get("period"))) {
				String startDate = oneYearAgo.format(formatter);
				String period_setting = startDate + " ~ " + endDate;
				req.setAttribute("period_setting", period_setting);
				params.put("startDate", startDate);

				// 기간설정 버튼눌렀을때/기간 설정 안했을때
			} else {
				// 기간 선택 안했을 시
				if (params.get("startDate") == null) {
					String startDate = oneMonthAgo.format(formatter);
					params.put("startDate", startDate);
				} else {
					String startDate = params.get("startDate");
					params.put("startDate", startDate);
					String period_setting = params.get("startDate") + " ~ " + params.get("endDate");
				}
			}
			// 기간 내 영수증 조회
			List<PayhistoryDTO> list = userMapper.RecepitByUserid(params);
			for (PayhistoryDTO phis : list) {
				totalPrice += phis.getPayhistoryPrice();
				number = number + 1;
			}
			req.setAttribute("recepitList", list);
			req.setAttribute("totalPrice", totalPrice);
			req.setAttribute("number", number);
		// 페이지 들어오자마자 초기 내역들	
		} else {

			String startDate = oneMonthAgo.format(formatter);
			// period_setting 문자열을 생성합니다.
			String period_setting = startDate + " ~ " + endDate;
			// 초기화면 기간 데이터
			req.setAttribute("period_setting", period_setting);

			params.put("startDate", startDate);
			params.put("endDate", endDate);

			// 날짜를 문자열로 변환합니다.
			String basicEndDate = today.format(outputFormatter);
			String basicStartDate = oneMonthAgo.format(outputFormatter);
			req.setAttribute("startDate", basicStartDate);
			req.setAttribute("endDate", basicEndDate);
			List<PayhistoryDTO> list = userMapper.RecepitByUserid(params);
			for (PayhistoryDTO phis : list) {
				totalPrice += phis.getPayhistoryPrice();
				number = number + 1;
			}
			req.setAttribute("recepitList", list);
			req.setAttribute("totalPrice", totalPrice);
			req.setAttribute("number", number);
		}

		return "/user/user_recepit";
	}

	// 영수증 팝업창 데이터 ajax
	@ResponseBody
	@PostMapping("/user_recepit.ajax")
	public Map<String, Object> userRecepit(@RequestBody Map<String, Object> params) {
		  try {
		        String bucksId = (String) params.get("bucksId");

		        // 안전한 타입 변환
		        Integer payhistoryNum = null;
		        Object payhistoryObj = params.get("payhistoryNum");
		        payhistoryNum = Integer.valueOf((String) payhistoryObj);

		        // bucksId에 해당하는 데이터를 조회합니다.
		        BucksDTO dto = userMapper.StoreInfoByBucksId(bucksId);
		        PayhistoryDTO dto2 = userMapper.PayInfoByHistoryNum(payhistoryNum);
		        String userNickname = userMapper.NicknameByHistoryNum(payhistoryNum);
		        CardDTO dto3 = userMapper.CardInfoByHistoryNum(payhistoryNum);
		        OrderDTO dto4 = userMapper.OrderInfoByHistoryNum(payhistoryNum);
		        String order = dto4.getOrderList();
		        String order2 = order.replace("[", "").replace("]", "").replace("\"", "").trim();

		        // 문자열을 ','를 기준으로 나누어 각 메뉴들을 배열에 저장
		        String[] splitOrder = order2.split(",");
		        // 배열을 리스트로 변환
		        List<String> orderList = Arrays.asList(splitOrder);
		        // 나누어진 값을 저장할 리스트
		        List<List<String>> splitList = new ArrayList<>();
		        // 조회한 메뉴정보 담을 리스트
		        List<CartDTO> menuList = new ArrayList<>();
		        Set<String> addedMenuCodes = new HashSet<>(); // 메뉴 코드에 기반한 중복 체크용 Set

		        // orderList의 각 요소를 ':'로 나누기
		        for (String order_L : orderList) {
		            // ':'를 기준으로 문자열 나누기
		            String[] parts = order_L.split(":");
		            List<String> orderList2 = Arrays.asList(parts);
		            // 나누어진 부분들을 splitList에 추가
		            splitList.add(orderList2);
		        }

		        for (List<String> tt : splitList) {
		            String menuCode = null;
		            int optId = 0;
		            int quantity = 0;

		            // 메뉴, 옵션id, 수량 꺼내기
		            if (tt.size() >= 3) {
		                menuCode = tt.get(0); // 첫 번째 값
		                optId = Integer.parseInt(tt.get(1)); // 두 번째 값
		                quantity = Integer.parseInt(tt.get(2)); // 세 번째 값
		            }

		            // 중복된 메뉴 코드가 있는지 확인
		            if (!addedMenuCodes.contains(menuCode)) {
		                // 새로운 CartDTO 객체 생성
		                CartDTO cartDTO = new CartDTO();

		                // 꺼낸 메뉴코드로 메뉴 정보 조회
		                MenuDTO mdto = userMapper.getMenuInfoByCode(menuCode);
		                cartDTO.setMenuname(mdto.getMenuName());
		                cartDTO.setMenuprice(mdto.getMenuPrice());
		                cartDTO.setcartCnt(quantity);

		                // 카드 정보 조회
		                CardDTO cd = userMapper.CardInfoByHistoryNum(payhistoryNum);
		                cartDTO.setCardPrice(cd.getCardPrice());
		                cartDTO.setCardRegNum(cd.getCardRegNum());

		                // DTO 초기화
		                OrderOptDTO optdto = userMapper.findOrderOpt(optId);
		                MenuOptCupDTO cupdto = null;
		                MenuOptIceDTO icedto = null;
		                MenuOptShotDTO shotdto = null;
		                MenuOptWhipDTO whipdto = null;
		                MenuOptSyrupDTO syrupdto = null;
		                MenuOptMilkDTO milkdto = null;

		                // 받은 optId 로 optDTO 만들기
		                if (optdto.getCupNum() != 0) {
		                    cupdto = userMapper.getCupInfo(optId);
		                    cartDTO.setCupType(cupdto.getCupType());
		                    cartDTO.setCupPrice(cupdto.getCupPrice());
		                }
		                if (optdto.getIceNum() != 0) {
		                    icedto = userMapper.getIceInfo(optId);
		                    cartDTO.setIceType(icedto.getIceType());
		                    cartDTO.setIcePrice(icedto.getIcePrice());
		                }
		                if (optdto.getShotNum() != 0) {
		                    shotdto = userMapper.getShotInfo(optId);
		                    cartDTO.setShotPrice(shotdto.getShotPrice());
		                    cartDTO.setShotType(shotdto.getShotType());
		                    cartDTO.setShotCount(optdto.getOptShotCount());
		                }
		                if (optdto.getWhipNum() != 0) {
		                    whipdto = userMapper.getWhipInfo(optId);
		                    cartDTO.setWhipPrice(whipdto.getWhipPrice());
		                    cartDTO.setWhipType(whipdto.getWhipType());
		                }
		                if (optdto.getSyrupNum() != 0) {
		                    syrupdto = userMapper.getSyrupInfo(optId);
		                    cartDTO.setSyrupType(syrupdto.getSyrupType());
		                    cartDTO.setSyrupPrice(syrupdto.getSyrupPrice());
		                    cartDTO.setSyrupCount(optdto.getOptSyrupCount());
		                }
		                if (optdto.getMilkNum() != 0) {
		                    milkdto = userMapper.getMilkInfo(optId);
		                    cartDTO.setMilkType(milkdto.getMilkType());
		                    cartDTO.setMilkPrice(milkdto.getMilkPrice());
		                }

		                // 중복된 메뉴가 아니면 메뉴 리스트에 추가
		                menuList.add(cartDTO);
		                addedMenuCodes.add(menuCode); // 메뉴 코드 추가
		            }
		        }

		        // 조회된 데이터를 JSON 형식으로 반환합니다.
		        Map<String, Object> response = new HashMap<>();

		        // 지점 정보
		        response.put("bucksName", dto.getBucksName());
		        response.put("bucksTel1", dto.getBucksTel1());
		        response.put("bucksTel2", dto.getBucksTel2());
		        response.put("bucksTel3", dto.getBucksTel3());
		        response.put("bucksLocation", dto.getBucksLocation());
		        response.put("bucksOwner", dto.getBucksOwner());
		        response.put("bucksCode", bucksId);
		        response.put("payhistoryDate", dto2.getPayhistoryDate());
		        response.put("payhistoryPayWay", dto2.getPayhistoryPayWay());            

		        // 닉네임, 주문번호
		        response.put("userNickname", userNickname);
		        String ordercode = dto2.getOrderCode().substring(7);
		        response.put("orderCode", ordercode);
		        // 주문내역
		        response.put("items", menuList);
		        // 결제금액
		        response.put("payhistoryPrice", dto2.getPayhistoryPrice());
		        // 결제카드
		        response.put("cardRegNum", dto3.getCardRegNum());
		        response.put("cardPrice", dto3.getCardPrice());

		        return response;
		    } catch (Exception e) {
		        e.printStackTrace(); // 예외 발생 시 스택 트레이스를 로그에 출력합니다.
		        return Collections.singletonMap("error", "서버 오류가 발생했습니다.");
		    }
		}

	@RequestMapping("/user_cart")
	public String userCart(HttpSession session, HttpServletRequest req, @RequestParam Map<String, String> params) {

		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		http://localhost:8887/user_cart?pickup=To-go
		// 주문인지 배달인지 구분위해 other 페이지 구분.
		if (params.get("modeInput") != null) {
			req.setAttribute("modeInput", params.get("modeInput"));
		}

		if ("매장이용".equals(params.get("pickup")) || "To-go".equals(params.get("pickup"))) {
			params.put("modeInput", "ordercart");
		} else if ("Delivers".equals(params.get("pickup"))) {
			params.put("modeInput", "deliverscart");
		}

		List<CartDTO> list = new ArrayList<>();
		if ("ordercart".equals(params.get("modeInput"))) {
			list = userMapper.OrderCartByUserid(userId);
			CartDTO maxcart = userMapper.findCartByMaxCartNumForNonDelivers(userId);
			if (maxcart != null) {
				req.setAttribute("pickup", maxcart.getCartType());
			} else
				req.setAttribute("pickup", "ordercart");
		} else if ("deliverscart".equals(params.get("modeInput"))) {
			list = userMapper.DeliversCartByUserid(userId);
			CartDTO maxcart = userMapper.findCartByMaxCartNumForDelivers(userId);
			if (maxcart != null) {
				req.setAttribute("pickup", maxcart.getCartType());
			} else
				req.setAttribute("pickup", "deliverscart");
		}
		// 장바구니 담긴 메뉴코드로 메뉴 정보 조회
		for (CartDTO CartDTO : list) {
			String menuCode = CartDTO.getMenuCode();
			// 메뉴코드로 메뉴 정보 조회
			MenuDTO mdto = userMapper.getMenuInfoByCode(menuCode);
			CartDTO.setMenuname(mdto.getMenuName());
			CartDTO.setMenuimages(mdto.getMenuImages());
			CartDTO.setMenuprice(mdto.getMenuPrice());
			int optId = CartDTO.getOptId();

			// DTO 초기화
			OrderOptDTO optdto = userMapper.findOrderOpt(optId);
			MenuOptCupDTO cupdto = null;
			MenuOptIceDTO icedto = null;
			MenuOptShotDTO shotdto = null;
			MenuOptWhipDTO whipdto = null;
			MenuOptSyrupDTO syrupdto = null;
			MenuOptMilkDTO milkdto = null;

			// 받은 optId 로 optDTO 만들기
			if (optdto.getCupNum() != 0) {
				cupdto = userMapper.getCupInfo(optId);
				CartDTO.setCupType(cupdto.getCupType());
				CartDTO.setCupPrice(cupdto.getCupPrice());
			}
			if (optdto.getIceNum() != 0) {
				icedto = userMapper.getIceInfo(optId);
				CartDTO.setIceType(icedto.getIceType());
				CartDTO.setIcePrice(icedto.getIcePrice());
			}
			if (optdto.getShotNum() != 0) {
				shotdto = userMapper.getShotInfo(optId);
				CartDTO.setShotPrice(shotdto.getShotPrice());
				CartDTO.setShotType(shotdto.getShotType());
				CartDTO.setShotCount(optdto.getOptShotCount());
			}
			if (optdto.getWhipNum() != 0) {
				whipdto = userMapper.getWhipInfo(optId);
				CartDTO.setWhipPrice(whipdto.getWhipPrice());
				CartDTO.setWhipType(whipdto.getWhipType());
			}
			if (optdto.getSyrupNum() != 0) {
				syrupdto = userMapper.getSyrupInfo(optId);
				CartDTO.setSyrupType(syrupdto.getSyrupType());
				CartDTO.setSyrupPrice(syrupdto.getSyrupPrice());
				CartDTO.setSyrupCount(optdto.getOptSyrupCount());
			}
			if (optdto.getMilkNum() != 0) {
				milkdto = userMapper.getMilkInfo(optId);
				CartDTO.setMilkType(milkdto.getMilkType());
				CartDTO.setMilkPrice(milkdto.getMilkPrice());
			}

			int oneprice = mdto.getMenuPrice();
			if (cupdto != null) {
				oneprice += cupdto.getCupPrice();
			}
			if (icedto != null) {
				oneprice += icedto.getIcePrice();
			}
			if (shotdto != null) {
				oneprice += shotdto.getShotPrice() * optdto.getOptShotCount();
			}
			if (whipdto != null) {
				oneprice += whipdto.getWhipPrice();
			}
			if (syrupdto != null) {
				oneprice += syrupdto.getSyrupPrice() * optdto.getOptSyrupCount();
			}
			if (milkdto != null) {
				oneprice += milkdto.getMilkPrice();
			}

			int totprice = oneprice * CartDTO.getcartCnt();
			CartDTO.setEachPrice(oneprice);
			CartDTO.setTotPrice(totprice);
			String bucksId = CartDTO.getBucksId();
			req.setAttribute("bucksId", bucksId);
		}
		req.setAttribute("cart", list);

		return "/user/user_cart";
	}

	// 메뉴 상세에서 장바구니 담기
	@ResponseBody
	@RequestMapping("/user_cart2")
	public int userCart2(HttpSession session, HttpServletRequest req, @RequestParam Map<String, Object> params) {
		// params에 데이터 담기
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		params.put("userId", userId);
		int optId = Integer.parseInt((String) params.get("optId"));
		params.put("optId", optId);
		int quantity = Integer.parseInt((String) params.get("quantity"));
		params.put("cartCount", quantity);

		if ("매장이용".equals(params.get("pickup"))) {
			params.put("cartType", "order");
		} else if ("To-go".equals(params.get("pickup"))) {
			params.put("cartType", "togo");
		} else {
			params.put("cartType", "delivers");
		}

		int totCnt = 0;
		// 장바구니에 다른 지점 메뉴 담을때 처리
		// 카트에서 오더만 조회
		if ("매장이용".equals(params.get("pickup")) || "To-go".equals(params.get("pickup"))) {
			List<CartDTO> dto = userMapper.CartinfoOdByUserId(params);
			for (CartDTO tt : dto) {
				if (!params.get("bucksId").equals(tt.getBucksId())) {
					return -1;
				}
				totCnt += tt.getcartCnt();
			}
		} else {
			// 카드에서 배달만 조회
			List<CartDTO> dto2 = userMapper.CartinfoDlvByUserId(params);
			for (CartDTO tt : dto2) {
				if (!params.get("bucksId").equals(tt.getBucksId())) {
					return -1;
				}
				totCnt += tt.getcartCnt();
			}
		}
		// 장바구니 수량 20개 넘으면 못담게하기
		if (quantity + totCnt > 20) {
			return -2;
		}
		params.get(userId);
		int res = userMapper.insertCart(params);

		return res;
	}
	
	@ResponseBody
	@PostMapping("/cartCountUpdate.ajax")
	public int cartCountUpdate(@RequestBody Map<String, Integer> params) {
	
		int cardCount = userMapper.updateCartCount(params);
		return cardCount;
	}

	@ResponseBody
	@PostMapping("/afterdeleteCart")
	public Map<String, Object> afterdeleteCart(HttpSession session, @RequestBody Map<String, List<String>> cartlist) {

		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		Map<String, Object> resultMap = new HashMap<>();

		// 삭제할 장바구니 리스트들(cartNum으로 받은 리스트들)
		List<Integer> list = new ArrayList<>();
		// String인 cartNum 꺼내서 int로 변환 시킨 후 다시 리스트에 담기
		try {
			List<String> cartNumStrings = (List<String>) cartlist.get("cartNum");
			if (cartNumStrings != null) {
				for (String cartNumStr : cartNumStrings) {
					list.add(Integer.parseInt(cartNumStr));
				}
			}
		} catch (NumberFormatException e) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid cartNum format", e);
		}
		if (list == null || list.size() == 0) {
			resultMap.put("success", true);
			return resultMap;
		}

		for (Integer cartNum : list) {
			try {
				Map<String, Object> params = new HashMap<>();
				params.put("userId", userId);
				params.put("cartNum", cartNum);

				int res = userMapper.deleteCart(params);
				if (res > 0) {
					// 장바구니 삭제
					resultMap.put("success", true);
				} else {
					resultMap.put("success", false);
				}
			} catch (DataIntegrityViolationException e) {
				// 데이터 무결성 예외 처리
				resultMap.put("success", false);
			} catch (Exception e) {
				// 그 외 예외 처리
				resultMap.put("success", false);
			}
		}
		return resultMap;
	}

	@ResponseBody
	@PostMapping("/deleteCart")
	public Map<String, Object> deleteCart(HttpSession session, @RequestBody Map<String, Object> cartlist) {

		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();

		// 삭제할 장바구니 리스트들(cartNum으로 받은 리스트들)
		List<Integer> list = new ArrayList<>();
		// String인 cartNum 꺼내서 int로 변환 시킨 후 다시 리스트에 담기
		try {
			List<String> cartNumStrings = (List<String>) cartlist.get("cartNum");
			if (cartNumStrings != null) {
				for (String cartNumStr : cartNumStrings) {
					list.add(Integer.parseInt(cartNumStr));
				}
			}
		} catch (NumberFormatException e) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid cartNum format", e);
		}

		String mode = (String) cartlist.get("eachOrAll");
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("modeInput", cartlist.get("modeInput"));
		// 선택삭제일 경우
		if ("each".equals(mode)) {
			for (Integer cartNum : list) {
				try {
					Map<String, Object> params = new HashMap<>();
					params.put("userId", userId);
					params.put("cartNum", cartNum);

					int res = userMapper.deleteCart(params);
					if (res > 0) {
						// 장바구니 삭제
						resultMap.put("success", true);
					} else {
						resultMap.put("success", false);
					}
				} catch (DataIntegrityViolationException e) {
					// 데이터 무결성 예외 처리
					resultMap.put("success", false);
				} catch (Exception e) {
					// 그 외 예외 처리
					resultMap.put("success", false);
				}
			}
			return resultMap;

			// x박스 체크로 삭제 시
		} else if ("xbox".equals(mode)) {
			for (Integer cartNum : list) {
				try {
					Map<String, Object> params = new HashMap<>();
					params.put("userId", userId);
					params.put("cartNum", cartNum);

					int res = userMapper.deleteCart(params);
					if (res > 0) {
						// 장바구니 삭제
						resultMap.put("success", true);
					} else {
						resultMap.put("success", false);
					}
				} catch (DataIntegrityViolationException e) {
					// 데이터 무결성 예외 처리
					resultMap.put("success", false);
				} catch (Exception e) {
					// 그 외 예외 처리
					resultMap.put("success", false);
				}
			}
			return resultMap;

			// 전체 삭제시
		} else {
			try {
				int res = 0;
				if ("deliverscart".equals(cartlist.get("pickup"))) {
					res = userMapper.deleteAllCartDelivers(userId);
				} else {
					res = userMapper.deleteAllCartOrder(userId);
				}
				if (res > 0) {
					// 장바구니 삭제
					resultMap.put("success", true);
				} else {
					resultMap.put("success", false);
				}
			} catch (DataIntegrityViolationException e) {
				// 데이터 무결성 예외 처리
				resultMap.put("success", false);
			} catch (Exception e) {
				// 그 외 예외 처리
				resultMap.put("success", false);
			}
		}
		return resultMap;
	}

	// ------------------------------------------------------------------------------------
	@RequestMapping("/user_pay")

	public String userPay(Model model, HttpSession session) {
		UserDTO dto = (UserDTO) session.getAttribute("inUser");
		String userId = dto.getUserId();
		List<CardDTO> list = userMapper.listRegCardById(userId);
		for(CardDTO tt : list) {
			System.out.println(tt.getCardName());
		}
		
		model.addAttribute("listCard", list);
		model.addAttribute("listCardSize", list.size());
		return "/user/user_pay";
	}

	@GetMapping("/user_addcard")
	public String userAddcard() {
		return "/user/user_addcard";
	}

	@ResponseBody
	@PostMapping("/cardCount.ajax")
	public int getCardCount(@RequestParam String userId) {
		int cardCount = userMapper.getCardCountByUserId(userId);
		return cardCount;
	}

	@PostMapping("/uesr_addcard")
	public String userAddcardOK(Model model, HttpSession session, @ModelAttribute CardDTO dto) {
		// 인서트 할 CardDTO 완성시킴
		String defaultName = "JavaBucks e카드";
		String user_id = ((UserDTO) session.getAttribute("inUser")).getUserId();
		dto.setUserId(user_id);
		if (dto.getCardName().equals("")) {
			dto.setCardName(defaultName);
		}

		// cardList 에서 등록한 카드와 같은 번호있는지 확인
		CardListDTO cldto = userMapper.compareCardNum(dto.getCardRegNum());

		if (cldto == null) {
			model.addAttribute("msg", "존재하지 않는 카드번호 입니다. 확인 후 다시 등록해주세요.");
			model.addAttribute("url", "user_addcard");
			return "message";
		}

		// card 에 중복된 카드 등록안됨
		CardDTO checkdto = userMapper.checkCardDupl(dto.getCardRegNum());
		if (checkdto != null) {
			model.addAttribute("msg", "이미 등록된 카드번호 입니다.");
			model.addAttribute("url", "user_addcard");
			return "message";
		} else {
			int res = userMapper.addNewCard(dto);
			if (res > 0) {
				model.addAttribute("msg", "카드가 등록되었습니다. 충전 후 사용가능합니다.");
				// 등록된 카드와 같은 cardList의 status 사용중으로 변경
				int modifyCardStatus = userMapper.modifyCardStatus(dto.getCardRegNum());
			} else {
				model.addAttribute("msg", "카드 등록 실패. 관리자에게 문의해주세요.");
			}
			model.addAttribute("url", "user_pay");
			return "message";
		}
	}

	@PostMapping("/modifyCardName")
	public String modifyCardName(String cardName, String modicardRegNum, Model model) {
		Map<String, String> params = new HashMap<>();
		params.put("cardName", cardName);
		params.put("cardRegNum", modicardRegNum);
		int res = userMapper.updateCardName(params);
		if (res > 0) {
			model.addAttribute("msg", "카드이름이 변경되었습니다.");
		} else {
			model.addAttribute("msg", "이름수정에 실패했습니다.");
		}
		model.addAttribute("url", "user_pay");
		return "message";
	}

	@PostMapping("/user_paycharge")
	public String userPaycharge(Model model, String cardRegNum) {
		CardDTO dto = userMapper.checkCardDupl(cardRegNum);
		model.addAttribute("card", dto);
		return "/user/user_paycharge";
	}

	@ResponseBody
	@PostMapping("/user_paycharge.ajax")
	public ResponseEntity<Map<String, String>> insertReserve(HttpSession session, @RequestBody PayhistoryDTO dto) {
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		if (udto == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}
		dto.setUserId(udto.getUserId());
		Map<String, String> response = new HashMap<>();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/json; charset=UTF-8");
		Map<String, Object> params = new HashMap<>();
		params.put("cardRegNum", dto.getCardRegNum());
		params.put("payhistoryPrice", dto.getPayhistoryPrice());
		dto.setBucksId("charge");
		CardDTO cdto = userMapper.checkCardDupl(dto.getCardRegNum());
		try {
			int res = userMapper.paychargeCard(dto);
			if (res > 0) {
				int price = userMapper.plusCardPrice(params);
				AlarmDTO adto = new AlarmDTO();
				adto.setUserId(udto.getUserId());
				adto.setAlarmCate("charge");

				// 천 단위 구분 기호 추가
				NumberFormat formatter = NumberFormat.getNumberInstance(Locale.KOREA);
				String formattedPrice = formatter.format(dto.getPayhistoryPrice());

				adto.setAlarmCont(cdto.getCardName() + "에 " + formattedPrice + "원 충전되었습니다.");
				userMapper.insertOrderAlarm(adto);
				response.put("status", "success");
				response.put("message", "카드 충전이 완료되었습니다.");
				return ResponseEntity.ok().headers(headers).body(response);
			} else {
				response.put("status", "error");
				response.put("message", "카드 충전에 실패하였습니다. 관리자에게 문의 바랍니다.");
				return ResponseEntity.ok().headers(headers).body(response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "서버 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).headers(headers).body(response);
		}

	}

	@GetMapping("/user_alarm")
	public String userAlarm(Model model, HttpSession session) {
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		List<AlarmDTO> listAlarm = userMapper.listGetAlarmById(userId);
		model.addAttribute("listAlarm", listAlarm);
		return "/user/user_alarm";
	}

	@ResponseBody
	@PostMapping("/getAlarmList.ajax")
	public List<AlarmDTO> getAlarmList(String alarmCate, HttpSession session) {
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		List<AlarmDTO> alarms = null;
		if ("all".equals(alarmCate)) {
			alarms = userMapper.listGetAlarmById(userId);
		} else {
			alarms = userMapper.getAlarmsByCategory(userId, alarmCate);
		}
		return alarms;
	}

	@ResponseBody
	@PostMapping("/orderOptInsert.ajax")
	public int orderOptInsert(@RequestBody OrderOptDTO dto) {
		int res = userMapper.orderOptInsert(dto);
		Integer optId = userMapper.orderOptIdsearch();
		return optId;
	}

	@RequestMapping("/user_paynow")
	public String userPaynow(HttpSession session, Model model,
			@RequestParam(value = "cartNum", required = false) List<Integer> cartNum,
			@RequestParam(value = "cartCnt", required = false) List<Integer> cartCnt,
			@RequestParam Map<String, String> params, String cart) throws JsonProcessingException {

//		cart 는 단순결제 imme 랑 카트결제 cart 있음
		UserDTO user = (UserDTO) session.getAttribute("inUser");
		String userId = user.getUserId();

		if (cartNum == null) {
			cartNum = new ArrayList<>();
		}

		int totMenuPrice = 0;
		int totOptPrice = 0;
		int totalPrice1 = 0;
		int totalPrice2 = 0;
		int cnt = 0;
		int orderedAmount = 0;
		int tottotOptPrice = 0;
		List<String> orderList = new ArrayList<>();

		// 채성진작업--------------------------------------------------------------
		// 장바구니에서 결제눌렀을때
		if ("cart".equals(cart)) {
			int quantity = 0;
			// 체크된 장바구니 메뉴번호, 수량 각각 받아서 dto에 저장
			List<CartToPay2> cartItemsList = new ArrayList<>();
			List<CartToPay> ctpList = new ArrayList<>();
			Map<String, Integer> params3 = new HashMap<>();
			for (int i = 0; i < cartNum.size(); i++) {
				params3.put("cartNum", cartNum.get(i));
				params3.put("cartCnt", cartCnt.get(i));

				// 메뉴 하나 주문갯수 업데이트 시켜주기
				userMapper.updateCartCount(params3);
				CartToPay2 cartItem = new CartToPay2();
				// 장바구니 번호, 메뉴 주문 갯수들 짝지어서 담아두기
				cartItem.setCartNum(cartNum.get(i));
				cartItem.setCartCnt(cartCnt.get(i));
				cartItemsList.add(cartItem);
			}

			Map<String, Object> params2 = new HashMap<>();
			params2.put("userId", userId);

			// 체크한 각 장박니 메뉴들 정보 조회해서 ctp에 저장
			for (CartToPay2 CartDTO : cartItemsList) {

				// 장바구니 번호 params2에 저장해서 메뉴 갯수 업데이트
				int cartNum2 = CartDTO.getCartNum();
				params2.put("cartNum", cartNum2);
				cnt = CartDTO.getCartCnt();
				int res = userMapper.updateCartCount(params3);

				// id랑 cartnum으로 장바구니 메뉴 정보 조회
				CartDTO cdto = userMapper.CartinfoByCartNum(params2);
				// bucksid로 매장 정보 조회
				String bucksId = cdto.getBucksId();
				BucksDTO bdto = userMapper.getBucksinfoById(bucksId);
				model.addAttribute("bucksId", bucksId);
				// params에 매장 이름, 위치 임시로 저장하기
				params.put("bucksName", bdto.getBucksName());
				params.put("bucksLocation", bdto.getBucksLocation());
				// optid로 옵션금액 구하기
				int optId = cdto.getOptId();
				int optPrice = userMapper.orderOptTotPrice(optId); // 옵션금액
				// 받은 optId 로 optDTO 만들기
				OrderOptDTO optdto = userMapper.findOrderOpt(optId);
				MenuOptCupDTO cupdto = userMapper.getCupInfo(optId);
				MenuOptIceDTO icedto = userMapper.getIceInfo(optId);
				MenuOptShotDTO shotdto = userMapper.getShotInfo(optId);
				MenuOptWhipDTO whipdto = userMapper.getWhipInfo(optId);
				MenuOptSyrupDTO syrupdto = userMapper.getSyrupInfo(optId);
				MenuOptMilkDTO milkdto = userMapper.getMilkInfo(optId);

				// 메뉴코드로 메뉴정보 가져오기
				String menuCode = cdto.getMenuCode();
				MenuDTO mdto = userMapper.getMenuInfoByCode(menuCode);

				CartToPay ctp = new CartToPay();
				ctp.setBucksDTO(bdto);
				ctp.setBucksId(bucksId);
				ctp.setCartDTO(cdto);
				ctp.setCupDTO(cupdto);
				ctp.setIceDTO(icedto);
				ctp.setMenuDTO(mdto);
				ctp.setMilkDTO(milkdto);
				ctp.setOptId(optId);
				ctp.setOptPrice(optPrice);
				ctp.setOrderOptDTO(optdto);
				ctp.setShotDTO(shotdto);
				ctp.setSyrupDTO(syrupdto);
				ctp.setWhipDTO(whipdto);
				ctp.setCartCnt(cdto.getcartCnt());

				ctpList.add(ctp);
				// 옵션 총 가격 초기화
				totOptPrice = 0;
				// 옵션 가격들 더해주기
				if (cupdto != null) {
					totOptPrice += cupdto.getCupPrice();
				}
				if (icedto != null) {
					totOptPrice += icedto.getIcePrice();
				}
				if (shotdto != null) {
					totOptPrice += shotdto.getShotPrice() * optdto.getOptShotCount();
				}
				if (whipdto != null) {
					totOptPrice += whipdto.getWhipPrice();
				}
				if (syrupdto != null) {
					totOptPrice += syrupdto.getSyrupPrice() * optdto.getOptSyrupCount();
				}
				if (milkdto != null) {
					totOptPrice += milkdto.getMilkPrice();
				}
				totMenuPrice = mdto.getMenuPrice();
				orderedAmount += totMenuPrice * cnt;
				tottotOptPrice += totOptPrice * cnt;
				totalPrice1 = (totMenuPrice + totOptPrice) * cnt;
				quantity += cnt;
				totalPrice2 += totalPrice1;

				String order = mdto.getMenuCode() + ":" + optId + ":" + cdto.getcartCnt();
				orderList.add(order);

			}
			String firstOrder = ctpList.get(0).getMenuDTO().getMenuName();
			model.addAttribute("firstOrder", firstOrder);
			String bucksName = params.get("bucksName");
			String bucksLocation = params.get("bucksLocation");
			String modeInput = params.get("modeInput");
			model.addAttribute("bucksName", bucksName);
			model.addAttribute("bucksLocation", bucksLocation);
			model.addAttribute("modeInput", modeInput);
			model.addAttribute("ctpList", ctpList);
			model.addAttribute("cart", cart);
			model.addAttribute("pickup", params.get("pickup"));
			model.addAttribute("quantity", quantity);
			model.addAttribute("totMenuPrice", orderedAmount);
			model.addAttribute("totalPrice", totalPrice2);
			model.addAttribute("totOptPrice", tottotOptPrice);

		} else {

			String bucksId = params.get("bucksId");
			BucksDTO bdto = userMapper.getBucksinfoById(bucksId);

			// 옵션 총금액구하기
			int optId = Integer.parseInt(params.get("optId"));
			model.addAttribute("optId", optId);
			int optPrice = userMapper.orderOptTotPrice(optId); // 옵션금액
			model.addAttribute("optPrice", optPrice);

			// 받은 optId 로 optDTO 만들기
			OrderOptDTO optdto = userMapper.findOrderOpt(optId);

			MenuOptCupDTO cupdto = userMapper.getCupInfo(optId);
			MenuOptIceDTO icedto = userMapper.getIceInfo(optId);
			MenuOptShotDTO shotdto = userMapper.getShotInfo(optId);
			MenuOptWhipDTO whipdto = userMapper.getWhipInfo(optId);
			MenuOptSyrupDTO syrupdto = userMapper.getSyrupInfo(optId);
			MenuOptMilkDTO milkdto = userMapper.getMilkInfo(optId);

			// 페이지로 전송시킬 메뉴 옵션 관련 정보
			model.addAttribute("cupdto", cupdto);
			model.addAttribute("icedto", icedto);
			model.addAttribute("shotdto", shotdto);
			model.addAttribute("whipdto", whipdto);
			model.addAttribute("syrupdto", syrupdto);
			model.addAttribute("milkdto", milkdto);

			String menuCode = params.get("menuCode");
			MenuDTO mdto = userMapper.getMenuInfoByCode(menuCode);
			int quantity = Integer.parseInt(params.get("quantity"));

			List<CartToPay> ctpList = new ArrayList<>();
			CartToPay ctp = new CartToPay();
			ctp.setBucksDTO(bdto);
			ctp.setBucksId(bucksId);
			ctp.setMenuDTO(mdto);
			ctp.setCupDTO(cupdto);
			ctp.setIceDTO(icedto);
			ctp.setMenuDTO(mdto);
			ctp.setMilkDTO(milkdto);
			ctp.setOptId(optId);
			ctp.setOptPrice(optPrice);
			ctp.setOrderOptDTO(optdto);
			ctp.setShotDTO(shotdto);
			ctp.setSyrupDTO(syrupdto);
			ctp.setWhipDTO(whipdto);
			ctp.setCartCnt(quantity);

			ctpList.add(ctp);

			totOptPrice = 0;
			// 옵션 가격들 더해주기
			if (cupdto != null) {
				totOptPrice += cupdto.getCupPrice();
			}
			if (icedto != null) {
				totOptPrice += icedto.getIcePrice();
			}
			if (shotdto != null) {
				totOptPrice += shotdto.getShotPrice() * optdto.getOptShotCount();
			}
			if (whipdto != null) {
				totOptPrice += whipdto.getWhipPrice();
			}
			if (syrupdto != null) {
				totOptPrice += syrupdto.getSyrupPrice() * optdto.getOptSyrupCount();
			}
			if (milkdto != null) {
				totOptPrice += milkdto.getMilkPrice();
			}

			totMenuPrice = mdto.getMenuPrice();
			orderedAmount += totMenuPrice * quantity;
			tottotOptPrice += totOptPrice * quantity;
			totalPrice1 = (totMenuPrice + totOptPrice) * quantity;
			quantity += cnt;
			totalPrice2 += totalPrice1;

			model.addAttribute("mdto", mdto);
			model.addAttribute("cart", cart);
			model.addAttribute("quantity", quantity);
			model.addAttribute("totMenuPrice", orderedAmount);
			model.addAttribute("totalPrice", totalPrice2);
			model.addAttribute("totOptPrice", tottotOptPrice);

			String order = mdto.getMenuCode() + ":" + optId + ":" + quantity;
			orderList.add(order);

			String firstOrder = ctpList.get(0).getMenuDTO().getMenuName();
			model.addAttribute("firstOrder", firstOrder);

			model.addAttribute("optdto", optdto);
			model.addAttribute("bucksId", bdto.getBucksId());
			model.addAttribute("bdto", bdto);
			String pickup = params.get("pickup");
			model.addAttribute("pickup", pickup);
			model.addAttribute("ctpList", ctpList);
			model.addAttribute("cart", cart);
			model.addAttribute("quantity", quantity);
			model.addAttribute("totalPrice", totalPrice2);
		}

		// JSON 문자열로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonOrderList = objectMapper.writeValueAsString(orderList);

		// 자바벅스 카드 리스트 넘기기
		List<CardDTO> list = userMapper.listRegCardById(userId);
		model.addAttribute("listCard", list);
		model.addAttribute("listCardSize", list.size());

		// [채성진 작업] 쿠폰 조회하기
		List<CouponListDTO> cplist = userMapper.getCouponListById(userId);
		for (CouponListDTO cp : cplist) {
			String sd = cp.getCpnListStartDate().substring(0, 10);
			String ed = cp.getCpnListEndDate().substring(0, 10);
			cp.setCpnListStartDate(sd);
			cp.setCpnListEndDate(ed);
			model.addAttribute("couponlist", cplist);
		}
		model.addAttribute("cartNumList", cartNum);
		model.addAttribute("orderList", jsonOrderList);
		return "/user/user_paynow";
	}

	// 주문 결제
	@ResponseBody
	@PostMapping("/orderPayCheck.ajax")
	public ResponseEntity<Map<String, String>> orderPayOk(HttpSession session,
			@RequestBody Map<String, String> params) {
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		if (udto == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}
		String cardRegNum = null;
		int cpnListNum = 0;

		if (params.get("cpnListNum") != null) {
			cpnListNum = Integer.parseInt(params.get("cpnListNum"));
		}

		String userId = udto.getUserId();
		int quantity = Integer.parseInt(params.get("quantity"));
		Map<String, String> response = new HashMap<>();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/json; charset=UTF-8");

		String payhistoryPayType = "";
		String orderType = "";

		if ((params.get("payhistoryPayType")).equals("To-go") || (params.get("payhistoryPayType")).equals("togo")) {
			payhistoryPayType = "주문결제";
			orderType = "togo";
		} else if (params.get("payhistoryPayType").equals("매장이용")
				|| (params.get("payhistoryPayType")).equals("order")) {
			payhistoryPayType = "주문결제";
			orderType = "order";
		} else if ((params.get("payhistoryPayType")).equals("Delivers")
				|| (params.get("payhistoryPayType")).equals("delivers")) {
			payhistoryPayType = "배달결제";
			orderType = "delivers";
		} else {
			payhistoryPayType = "충전";
		}

		int payhistoryPrice = Integer.parseInt(params.get("payhistoryPrice"));

		PayhistoryDTO pdto = new PayhistoryDTO();
		OrderDTO odto = new OrderDTO();

		try {
			// 현재 날짜 + pickUp + 숫자 로 orderCode 만들기
			String orderCode = generateOrderCode((String) params.get("orderType"));
			String orderList = (String) params.get("orderList");

			// Order 인서트
			odto.setOrderCode(orderCode);
			odto.setUserId(userId);
			odto.setBucksId((String) params.get("bucksId"));
			odto.setOrderList(orderList);
			int menuPrice = Integer.parseInt(params.get("menuPrice"));
			odto.setMenuPrice(menuPrice);
			int optPrice = Integer.parseInt(params.get("optPrice"));
			odto.setOptPrice(optPrice);
			int orderPrice = Integer.parseInt(params.get("orderPrice"));
			odto.setOrderPrice(orderPrice);

			if ((params.get("orderType")).equals("To-go") || (params.get("orderType")).equals("togo")) {
				orderType = "togo";
			} else if ((params.get("orderType")).equals("매장이용") || (params.get("orderType")).equals("order")) {
				orderType = "order";
			} else if ((params.get("orderType")).equals("Delivers") || (params.get("orderType")).equals("delivers")) {
				orderType = "delivers";
			} else {
				orderType = "charge";
			}
			odto.setOrderType(orderType);
			int res = userMapper.orderInsert(odto);
			if (res > 0) {
				pdto.setUserId(userId);
				pdto.setCardRegNum(cardRegNum);
				pdto.setBucksId((String) params.get("bucksId"));
				pdto.setOrderCode(orderCode);
				pdto.setCpnListNum(cpnListNum);
				pdto.setPayhistoryPrice(payhistoryPrice);
				pdto.setPayhistoryPayType(payhistoryPayType);
				pdto.setPayhistoryPayWay((String) params.get("payhistoryPayWay"));

				userMapper.payhistoryOrder(pdto);

				AlarmDTO adto = new AlarmDTO();
				adto.setUserId(userId);
				adto.setAlarmCate("order");

				String[] orderCordParts = orderCode.split("_");

				adto.setAlarmCont(orderCordParts[1] + "로 주문이 되었습니다. 전자영수증이 발행되었습니다.");
				userMapper.insertOrderAlarm(adto);

				userMapper.processFrequencyAndUserUpdate(userId, quantity);

				if (params.get("cpnListNum") != null) {
					userMapper.cpnListStatusChange(cpnListNum);
				}
				response.put("status", "success");
				response.put("message", "결제가 완료되었습니다.");
				return ResponseEntity.ok().headers(headers).body(response);
			} else {
				response.put("status", "error");
				response.put("message", "결제에 실패하였습니다. 관리자에게 문의 바랍니다.");
				return ResponseEntity.ok().headers(headers).body(response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "서버 오류가 발생했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).headers(headers).body(response);
		}
	}

	// 자바벅스 카드결제
	@ResponseBody
	@PostMapping("/orderPayBucksCard.ajax")
	public String orderPayBucksCard(HttpSession session, @RequestBody Map<String, String> params)
			throws JsonProcessingException {
		String cardRegNum = null;
		int cpnListNum = 0;
		UserDTO udto = (UserDTO) session.getAttribute("inUser");
		String userId = udto.getUserId();
		int quantity = Integer.parseInt(params.get("quantity"));

		if (params.get("cpnListNum") != null) {
			cpnListNum = Integer.parseInt(params.get("cpnListNum"));
		}

		if (params.get("cardRegNum") != null || !(params.get("cardRegNum")).equals("")) {
			cardRegNum = params.get("cardRegNum");
		}
		PayhistoryDTO pdto = new PayhistoryDTO();
		OrderDTO odto = new OrderDTO();
		CardDTO cdto = userMapper.checkCardDupl(cardRegNum);

		int payhistoryPrice = Integer.parseInt(params.get("payhistoryPrice"));

		String payhistoryPayType = "";
		String orderType = "";
		if ((params.get("payhistoryPayType")).equals("To-go") || (params.get("payhistoryPayType")).equals("togo")) {
			payhistoryPayType = "주문결제";
			orderType = "togo";
		} else if (params.get("payhistoryPayType").equals("매장이용")
				|| (params.get("payhistoryPayType")).equals("order")) {
			payhistoryPayType = "주문결제";
			orderType = "order";
		} else if ((params.get("payhistoryPayType")).equals("Delivers")
				|| (params.get("payhistoryPayType")).equals("delivers")) {
			payhistoryPayType = "배달결제";
			orderType = "delivers";
		} else {
			payhistoryPayType = "충전";
		}

		// 결제금액보다 잔액이 적을 때
		if (cdto.getCardPrice() < payhistoryPrice) {
			return "PASS";
		}

		// 카드 금액 사용.
		int res = userMapper.minusCardPrice(params);
		if (res > 0) {
			// 현재 날짜 + pickUp + 숫자 로 orderCode 만들기
			String orderCode = generateOrderCode((String) params.get("orderType"));
			String orderList = (String) params.get("orderList");

			// Order 인서트

			odto.setOrderCode(orderCode);
			odto.setUserId(userId);
			odto.setBucksId((String) params.get("bucksId"));
			odto.setOrderList(orderList);
			int menuPrice = Integer.parseInt(params.get("menuPrice"));
			odto.setMenuPrice(menuPrice);
			int optPrice = Integer.parseInt(params.get("optPrice"));
			odto.setOptPrice(optPrice);
			int orderPrice = Integer.parseInt(params.get("orderPrice"));
			odto.setOrderPrice(orderPrice);
			odto.setOrderType(orderType);
			userMapper.orderInsert(odto);

			pdto.setUserId(userId);
			pdto.setCardRegNum(cardRegNum);
			pdto.setBucksId((String) params.get("bucksId"));
			pdto.setOrderCode(orderCode);
			pdto.setCpnListNum(cpnListNum);
			pdto.setPayhistoryPrice(payhistoryPrice);
			pdto.setPayhistoryPayType(payhistoryPayType);
			pdto.setPayhistoryPayWay((String) params.get("payhistoryPayWay"));

			userMapper.payhistoryOrder(pdto);

			if (params.get("cpnListNum") != null) {
				userMapper.cpnListStatusChange(cpnListNum);
			}
			String[] orderCordParts = orderCode.split("_");

			AlarmDTO adto = new AlarmDTO();
			adto.setUserId(userId);
			adto.setAlarmCate("order");
			adto.setAlarmCont(orderCordParts[1] + "로 주문이 되었습니다. 전자영수증이 발행되었습니다.");
			userMapper.insertOrderAlarm(adto);

			userMapper.processFrequencyAndUserUpdate(userId, quantity);

			return "OK";
		}
		return "NO";
	}

	@RequestMapping("/user_store")
	public String userStore(HttpServletRequest req, @RequestParam Map<String, String> params, String mode,
			String storeSearch) {

		String menuCode = params.get("menuCode");
		req.setAttribute("menuCode", params.get("menuCode"));

		// 매장 검색하기
		if (mode != null) {
			
			if (storeSearch != null && !storeSearch.trim().isEmpty()) {
				
				// 공백을 기준으로 문자열을 분리하여 List로 저장
				List<String> searchTerms = Arrays.asList(storeSearch.split("\\s+"));
				// 파라미터를 Map에 담아 전달
				Map<String, Object> paramMap = new HashMap<>();
				paramMap.put("searchTerms", searchTerms);

				List<BucksDTO> list = userMapper.getStoreList2(searchTerms);
				for (BucksDTO dto : list) {
					String orderEnalbe = userMapper.getOrderEnableBybucksId(dto.getBucksId());
					dto.setOrderEnalbe(orderEnalbe);
					
					// 시간가져와서 00:00식으로 변환
					String startTime = dto.getBucksStart();
					String st = startTime.substring(11, 16);
					String endTime = dto.getBucksEnd();
					String ed = endTime.substring(11, 16);

					// 시간을 비교하기 위해 LocalTime으로 변환
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
					LocalTime start = LocalTime.parse(st, formatter);
					LocalTime end = LocalTime.parse(ed, formatter);
					LocalTime now = LocalTime.now();

					// 현재 시간과 비교
					if (now.isBefore(start) || now.isAfter(end)) {
						dto.setOrderEnalbe("N");
					}
					dto.setBucksStart(st);
					dto.setBucksEnd(ed);
				}
				
				req.setAttribute("storeList", list);
				req.setAttribute("storeSearch", storeSearch);

			} else {
				List<BucksDTO> list2 = userMapper.getStoreList(storeSearch);
				for (BucksDTO dto : list2) {
					String orderEnalbe = userMapper.getOrderEnableBybucksId(dto.getBucksId());
					dto.setOrderEnalbe(orderEnalbe);
					
					// 시간가져와서 00:00식으로 변환
					String startTime = dto.getBucksStart();
					String st = startTime.substring(11, 16);
					String endTime = dto.getBucksEnd();
					String ed = endTime.substring(11, 16);

					// 시간을 비교하기 위해 LocalTime으로 변환
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
					LocalTime start = LocalTime.parse(st, formatter);
					LocalTime end = LocalTime.parse(ed, formatter);
					LocalTime now = LocalTime.now();

					// 현재 시간과 비교
					if (now.isBefore(start) || now.isAfter(end)) {
						dto.setOrderEnalbe("N");
					}
					dto.setBucksStart(st);
					dto.setBucksEnd(ed);
				}
				req.setAttribute("storeList", list2);
			}
		}else {
			List<BucksDTO> list = userMapper.StoreAll();
			for (BucksDTO dto : list) {
				String orderEnalbe = userMapper.getOrderEnableBybucksId(dto.getBucksId());
				dto.setOrderEnalbe(orderEnalbe);
				
				// 시간가져와서 00:00식으로 변환
				String startTime = dto.getBucksStart();
				String st = startTime.substring(11, 16);
				String endTime = dto.getBucksEnd();
				String ed = endTime.substring(11, 16);

				// 시간을 비교하기 위해 LocalTime으로 변환
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
				LocalTime start = LocalTime.parse(st, formatter);
				LocalTime end = LocalTime.parse(ed, formatter);
				LocalTime now = LocalTime.now();

				// 현재 시간과 비교
				if (now.isBefore(start) || now.isAfter(end)) {
					dto.setOrderEnalbe("N");
				}
				dto.setBucksStart(st);
				dto.setBucksEnd(ed);
			}
			req.setAttribute("storeList", list);
		}

		return "/user/user_store";
	}

	@RequestMapping("/user_other")
	public String userOther() {
		return "/user/user_other";

	}

	@RequestMapping("/user_info")
	public String userInfo() {
		return "/user/user_info";
	}

	@GetMapping("/user_delivershistory")
	public String userDelivershistory(HttpServletRequest req,
			@RequestParam(value = "searchOption", required = false, defaultValue = "ALL") String orderStatus,
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {

		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO) session.getAttribute("inUser");
		String userId = dto.getUserId();

		Map<String, String> params = new HashMap<>();
		params.put("userId", userId);
		params.put("orderStatus", orderStatus);

		// 날짜
		LocalDate today = LocalDate.now();
		LocalDate threeMonthAgo = today.minusMonths(3);
		String stringToday = String.valueOf(today);
		String stringthreeMonthAgo = String.valueOf(threeMonthAgo);

		params.put("startDate", stringthreeMonthAgo);
		params.put("endDate", stringToday);

		// Order테이블 리스트 조회
		List<OrderDTO> deliversHistory = userMapper.getDeliversHistory(params);

		ObjectMapper objectMapper = new ObjectMapper();

		for (OrderDTO order : deliversHistory) {
			try {
				// JSON을 String으로 변환
				List<String> orderList = objectMapper.readValue(order.getOrderList(),
						objectMapper.getTypeFactory().constructCollectionType(ArrayList.class, String.class));

				// 메뉴명 업데이트된 리스트
				List<MenuOrder> updateOrderHistory = new ArrayList<>();

				for (String orderItem : orderList) {
					String[] s = orderItem.split(":");
					String menuCode = s[0];
					String optId = s[1];
					String quantity = s[2];

					// Menuorder 객체 만들어서 생성
					MenuOrder menuOrder = new MenuOrder(menuCode, optId, Integer.parseInt(quantity));

					// MenuName DB에서 조회
					String menuName = userMapper.getMenuName(menuCode);
					menuOrder.setMenuName(menuName);

					updateOrderHistory.add(menuOrder);
				}
				order.setOrderListbyMenuOrder(updateOrderHistory);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		req.setAttribute("deliversInfoList", deliversHistory);
		return "/user/user_delivershistory";
	}

	@PostMapping("/updateDeliversHistory.do")
	public String updateDeliversHistory(HttpServletRequest req, @RequestParam Map<String, String> params) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO) session.getAttribute("inUser");
		String userId = dto.getUserId();

		params.put("userId", userId);

		// Order테이블 리스트 조회
		List<OrderDTO> updateStatusDeliversHistory = new ArrayList<>();

		// 기간보여주는 텍스트
		String period_setting = null;

		// 주문상태만 바뀐 경우
		if (params.get("period_option").isEmpty()) {
			params.put("startDate", params.get("startDate"));
			params.put("endDate", params.get("endDate"));
			updateStatusDeliversHistory = userMapper.getSearchStatusDeliversHistory(params);
		}

		// 주문상태 & 기간검색 커스텀
		else if (params.get("period_option").equals("custom")) {
			params.put("startDate", params.get("startDate"));
			params.put("endDate", params.get("endDate"));

			updateStatusDeliversHistory = userMapper.getSearchPeriodDeliversHistory(params);
		}

		// 주문상태 & 기간검색 1month
		else if (params.get("period_option").equals("1month")) {
			LocalDate today = LocalDate.now();
			LocalDate oneMonthAgo = today.minusMonths(1);
			String stringToday = String.valueOf(today);
			String stringoneMonthAgo = String.valueOf(oneMonthAgo);

			params.put("startDate", stringoneMonthAgo);
			params.put("endDate", stringToday);

			updateStatusDeliversHistory = userMapper.getSearchPeriodDeliversHistory(params);
		}

		// 주문상태 & 기간검색 3month
		else if (params.get("period_option").equals("3month")) {
			LocalDate today = LocalDate.now();
			LocalDate threeMonthAgo = today.minusMonths(3);
			String stringToday = String.valueOf(today);
			String stringthreeMonthAgo = String.valueOf(threeMonthAgo);

			params.put("startDate", stringthreeMonthAgo);
			params.put("endDate", stringToday);

			updateStatusDeliversHistory = userMapper.getSearchPeriodDeliversHistory(params);
		}

		period_setting = params.get("startDate") + " ~ " + params.get("endDate");

		ObjectMapper objectMapper = new ObjectMapper();

		for (OrderDTO order : updateStatusDeliversHistory) {
			try {
				// JSON을 String으로 변환
				List<String> orderList = objectMapper.readValue(order.getOrderList(),
						objectMapper.getTypeFactory().constructCollectionType(ArrayList.class, String.class));

				// 메뉴명 업데이트된 리스트
				List<MenuOrder> updateOrderHistory = new ArrayList<>();

				for (String orderItem : orderList) {
					String[] s = orderItem.split(":");
					String menuCode = s[0];
					String optId = s[1];
					String quantity = s[2];

					// Menuorder 객체 만들어서 생성
					MenuOrder menuOrder = new MenuOrder(menuCode, optId, Integer.parseInt(quantity));

					// MenuName DB에서 조회
					String menuName = userMapper.getMenuName(menuCode);
					menuOrder.setMenuName(menuName);

					updateOrderHistory.add(menuOrder);
				}
				order.setOrderListbyMenuOrder(updateOrderHistory);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		req.setAttribute("deliversInfoList", updateStatusDeliversHistory);
		req.setAttribute("orderStatus", params.get("orderStatus"));
		req.setAttribute("startDate", params.get("startDate"));
		req.setAttribute("endDate", params.get("endDate"));
		req.setAttribute("period_option", params.get("period_option"));
		req.setAttribute("period_setting", period_setting);
		return "/user/user_delivershistory";
	}

	@GetMapping("/user_orderhistory")
	public String userOrderhistory(HttpServletRequest req,
			@RequestParam(value = "searchOption", required = false, defaultValue = "ALL") String orderStatus,
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {

		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO) session.getAttribute("inUser");
		String userId = dto.getUserId();

		Map<String, String> params = new HashMap<>();
		params.put("userId", userId);
		params.put("orderStatus", orderStatus);

		// 날짜
		LocalDate today = LocalDate.now();
		LocalDate threeMonthAgo = today.minusMonths(3);
		String stringToday = String.valueOf(today);
		String stringthreeMonthAgo = String.valueOf(threeMonthAgo);

		params.put("startDate", stringthreeMonthAgo);
		params.put("endDate", stringToday);

		// Order테이블 리스트 조회
		List<OrderDTO> orderHistory = userMapper.getOrderHistory(params);

		ObjectMapper objectMapper = new ObjectMapper();

		for (OrderDTO order : orderHistory) {
			try {
				// JSON을 String으로 변환
				List<String> orderList = objectMapper.readValue(order.getOrderList(),
						objectMapper.getTypeFactory().constructCollectionType(ArrayList.class, String.class));

				// 메뉴명 업데이트된 리스트
				List<MenuOrder> updateOrderHistory = new ArrayList<>();

				for (String orderItem : orderList) {
					String[] s = orderItem.split(":");
					String menuCode = s[0];
					String optId = s[1];
					String quantity = s[2];

					// Menuorder 객체 만들어서 생성
					MenuOrder menuOrder = new MenuOrder(menuCode, optId, Integer.parseInt(quantity));

					// MenuName DB에서 조회
					String menuName = userMapper.getMenuName(menuCode);
					menuOrder.setMenuName(menuName);

					updateOrderHistory.add(menuOrder);
				}
				order.setOrderListbyMenuOrder(updateOrderHistory);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		req.setAttribute("orderInfoList", orderHistory);
		return "/user/user_orderhistory";
	}

	@PostMapping("/updateOrderHistory.do")
	public String updateOrderHistory(HttpServletRequest req, @RequestParam Map<String, String> params) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO) session.getAttribute("inUser");
		String userId = dto.getUserId();

		params.put("userId", userId);

		// Order테이블 리스트 조회
		List<OrderDTO> updateStatusOrderHistory = new ArrayList<>();

		// 기간보여주는 텍스트
		String period_setting = null;

		// 주문상태만 바뀐 경우
		if (params.get("period_option").isEmpty()) {
			params.put("startDate", params.get("startDate"));
			params.put("endDate", params.get("endDate"));
			updateStatusOrderHistory = userMapper.getSearchStatusOrderHistory(params);
		}

		// 주문상태 & 기간검색 커스텀
		else if (params.get("period_option").equals("custom")) {
			params.put("startDate", params.get("startDate"));
			params.put("endDate", params.get("endDate"));

			updateStatusOrderHistory = userMapper.getSearchPeriodOrderHistory(params);
		}

		// 주문상태 & 기간검색 1month
		else if (params.get("period_option").equals("1month")) {
			LocalDate today = LocalDate.now();
			LocalDate oneMonthAgo = today.minusMonths(1);
			String stringToday = String.valueOf(today);
			String stringoneMonthAgo = String.valueOf(oneMonthAgo);

			params.put("startDate", stringoneMonthAgo);
			params.put("endDate", stringToday);

			updateStatusOrderHistory = userMapper.getSearchPeriodOrderHistory(params);
		}

		// 주문상태 & 기간검색 3month
		else if (params.get("period_option").equals("3month")) {
			LocalDate today = LocalDate.now();
			LocalDate threeMonthAgo = today.minusMonths(3);
			String stringToday = String.valueOf(today);
			String stringthreeMonthAgo = String.valueOf(threeMonthAgo);

			params.put("startDate", stringthreeMonthAgo);
			params.put("endDate", stringToday);

			updateStatusOrderHistory = userMapper.getSearchPeriodOrderHistory(params);
		}

		period_setting = params.get("startDate") + " ~ " + params.get("endDate");

		ObjectMapper objectMapper = new ObjectMapper();

		for (OrderDTO order : updateStatusOrderHistory) {
			try {
				// JSON을 String으로 변환
				List<String> orderList = objectMapper.readValue(order.getOrderList(),
						objectMapper.getTypeFactory().constructCollectionType(ArrayList.class, String.class));

				// 메뉴명 업데이트된 리스트
				List<MenuOrder> updateOrderHistory = new ArrayList<>();

				for (String orderItem : orderList) {
					String[] s = orderItem.split(":");
					String menuCode = s[0];
					String optId = s[1];
					String quantity = s[2];

					// Menuorder 객체 만들어서 생성
					MenuOrder menuOrder = new MenuOrder(menuCode, optId, Integer.parseInt(quantity));

					// MenuName DB에서 조회
					String menuName = userMapper.getMenuName(menuCode);
					menuOrder.setMenuName(menuName);

					updateOrderHistory.add(menuOrder);
				}
				order.setOrderListbyMenuOrder(updateOrderHistory);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		req.setAttribute("orderInfoList", updateStatusOrderHistory);
		req.setAttribute("orderStatus", params.get("orderStatus"));
		req.setAttribute("startDate", params.get("startDate"));
		req.setAttribute("endDate", params.get("endDate"));
		req.setAttribute("period_option", params.get("period_option"));
		req.setAttribute("period_setting", period_setting);
		return "/user/user_orderhistory";
	}

	public String generateOrderCode(String pickUp) {
		// 현재날짜 YYMMDD로 설정하기
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
		LocalDate today = LocalDate.now();
		String currentDate = today.format(formatter);

		// pickUp 값에 따른 문자 결정
		String pickUpChar = getPickUpChar(pickUp);

		// SQL에서 주어진 날짜와 문자를 기준으로 가장 큰 번호 가져오기
		String maxNumberStr = userMapper.getMaxOrderCode(currentDate + "_" + pickUpChar);
		int maxNumber = 0;

		// maxNumberStr가 null이 아니면 해당 값을 정수로 변환
		if (maxNumberStr != null) {
			maxNumber = Integer.parseInt(maxNumberStr);
		}

		// 다음 번호 생성 (001, 002, ...)
		int nextNumber = maxNumber + 1;

		// 새로운 orderCode 생성
		return String.format("%s_%s-%03d", currentDate, pickUpChar, nextNumber);
	}

	private String getPickUpChar(String pickUp) {
		switch (pickUp) {
		case "매장이용":
			return "A";
		case "order":
			return "A";
		case "togo":
			return "B";
		case "To-go":
			return "B";
		case "Delivers":
			return "C";
		case "delivers":
			return "C";
		default:
			throw new IllegalArgumentException("Invalid pickUp value: " + pickUp);
		}
	}

}
