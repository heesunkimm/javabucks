package com.project.javabucks.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.project.javabucks.dto.AlarmDTO;
import com.project.javabucks.dto.BucksDTO;
import com.project.javabucks.dto.CardDTO;
import com.project.javabucks.dto.CardListDTO;
import com.project.javabucks.dto.CouponListDTO;
import com.project.javabucks.dto.FrequencyDTO;
import com.project.javabucks.dto.MenuDTO;
import com.project.javabucks.dto.MenuOptCupDTO;
import com.project.javabucks.dto.MenuOptIceDTO;
import com.project.javabucks.dto.MenuOptMilkDTO;
import com.project.javabucks.dto.MenuOptShotDTO;
import com.project.javabucks.dto.MenuOptSyrupDTO;
import com.project.javabucks.dto.MenuOptWhipDTO;
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

	// 채성진 작업-------------------------------------------------------------------
	@RequestMapping("/user_index")
	public String userIndex(HttpServletRequest req) {
//		HttpSession session = req.getSession();
//		UserDTO dto = (UserDTO)session.getAttribute("inUser");

		UserDTO dto = userMapper.getInfoById();
		String userId = dto.getUserId();

		FrequencyDTO dto2 = userMapper.getFrequencyById();
		int frequencyById = dto2.getFrequencyCount();

		if (dto.getGradeCode().equals("green")) {
			int frequency = 30 - frequencyById;
			int gage = (int) ((frequencyById / 30.0) * 100);
			req.setAttribute("maxStar", "30");
			req.setAttribute("frequency", frequency);
			req.setAttribute("until", "Gold");
			req.setAttribute("progress_bar", gage);

		} else if (dto.getGradeCode().equals("welcome")) {
			int frequency = 5 - frequencyById;
			int gage = (int) ((frequencyById / 5.0) * 100);
			req.setAttribute("maxStar", "5");
			req.setAttribute("frequency", frequency);
			req.setAttribute("until", "Green");
			req.setAttribute("progress_bar", gage);
		}
		req.getSession().setAttribute("inUser", dto);
		return "/user/user_index";
	}

	@RequestMapping("/user_cpnhistory")
	public String ListCpnhistory(HttpServletRequest req) {
		UserDTO dto = userMapper.getInfoById();
		String userId = dto.getUserId();
		List<CouponListDTO> list = userMapper.getCouponListById();
		req.setAttribute("couponlist", list);
		return "/user/user_cpnhistory";
	}

	@RequestMapping("/user_delivers")
	public String userDelivers(HttpServletRequest req, @RequestParam Map<String, String> params, String mode,
			String storeSearch) {
		// 매장 검색하기
		if (mode != null) {
			List<BucksDTO> list = userMapper.getStoreList(storeSearch);
			req.setAttribute("storeList", list);
		}

		return "/user/user_delivers";
	}

	@RequestMapping("/user_order")
	public String orderMenu(HttpServletRequest req, String storeName, String pickup) {

		List<MenuDTO> list = userMapper.getStoreDrinkList(storeName);
		List<MenuDTO> list2 = userMapper.getStoreFoodList(storeName);
		List<MenuDTO> list3 = userMapper.getStoreProdcutList(storeName);
		req.setAttribute("drinkList", list);
		req.setAttribute("foodList", list2);
		req.setAttribute("productList", list3);
		req.setAttribute("store", storeName);
		req.setAttribute("pickup", pickup);
		return "/user/user_order";
	}

	@RequestMapping("/user_menudetail")
	public String menudetail(HttpServletRequest req, @RequestParam Map<String, String> params) {

		// 메뉴코드로 메뉴정보 꺼내오기
		String menuCode = params.get("menuCode");
		String menuoptCode = params.get("menuoptCode");
		MenuDTO dto = userMapper.getMenuInfoByCode(menuCode);
		req.setAttribute("menu", dto);
		req.setAttribute("drink", params.get("drink"));
		req.setAttribute("store", params.get("store"));
		req.setAttribute("pickup", params.get("pickup"));

		// 음료메뉴 퍼스널옵션값 가져오기
		if (params.get("drink").equals("drink")) {
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

	@RequestMapping("/user_starhistory")
	public String userStarhistory(HttpServletRequest req, @RequestParam Map<String, String> params) {

		UserDTO dto = userMapper.getInfoById();
		String userId = dto.getUserId();
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
	public String userMymenu(HttpServletRequest req, String mode, String menuCode) {

		UserDTO dto = userMapper.getInfoById();
		String userId = dto.getUserId();
		System.out.println(mode);

//		// 나만의메뉴 X 눌렀을때
//		if(mode != null) {
//			
//			//마메넘 구하는 메소드, 그걸 받아서 다시 아래에 넣어주기
//			int res =userMapper.MyMenuDeleteByMenuNum(mymenuNum);
//			if (res > 0) {	        	
//				req.setAttribute("msg", "나만의메뉴가 삭제되었습니다.");
//				req.setAttribute("url", "user_mymenu");
//	        } else {
//	        	req.setAttribute("msg", "나만의메뉴 삭제 중 오류가 발생하였습니다.");
//	    		req.setAttribute("url", "user_mymenu");
//	        }
//		}

		List<MenuDTO> list = userMapper.MyMenuByUserid(userId);
		req.setAttribute("mymenu", list);

		return "/user/user_mymenu";
	}

	// ------------------------------------------------------------------------------------
	@RequestMapping("/user_pay")
	public String userPay(Model model, HttpSession session) {
		UserDTO dto = (UserDTO) session.getAttribute("inUser");
		String userId = dto.getUserId();
		List<CardDTO> list = userMapper.listRegCardById(userId);
		model.addAttribute("listCard", list);
		return "/user/user_pay";
	}

	@GetMapping("/user_addcard")
	public String userAddcard() {
		return "/user/user_addcard";
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
		System.out.println(dto.getCardRegNum());
		System.out.println(cldto);
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
		try {
			int res = userMapper.paychargeCard(dto);
			if (res > 0) {
				int price = userMapper.plusCardPrice(params);
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
		System.out.println(dto);
		userMapper.orderOptInsert(dto);
		Integer optId = userMapper.orderOptIdsearch();
		System.out.println(optId);
		return optId;
	}

	@RequestMapping("/user_paynow")
	public String userPaynow(Model model, @RequestParam Map<String, String> params) {
		System.out.println(params);
		String bucksId = params.get("store");
		return "/user/user_paynow";
	}

	@RequestMapping("/user_store")
	public String userStore(Model model, @RequestParam Map<String, String> params, String mode, String storeSearch) {
		// 매장 검색하기
		if (mode != null) {
			List<BucksDTO> list = userMapper.getStoreList(storeSearch);
			model.addAttribute("storeList", list);
		}

		return "/user/user_store";
	}

	@RequestMapping("/user_other")
	public String userOther() {
		return "/user/user_other";
	}

	@RequestMapping("/user_recepit")
	public String userRecepit() {
		return "/user/user_recepit";
	}

	@RequestMapping("/user_info")
	public String userInfo() {
		return "/user/user_info";
	}

	@RequestMapping("/user_delivershistory")
	public String userDelivershistory() {
		return "/user/user_delivershistory";
	}

	@RequestMapping("/user_orderhistory")
	public String userOrderhistory() {
		return "/user/user_orderhistory";
	}

}
