package com.project.javabucks.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucks.dto.CardDTO;
import com.project.javabucks.dto.CardListDTO;
import com.project.javabucks.dto.CouponListDTO;
import com.project.javabucks.dto.FrequencyDTO;
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
	public String userDelivers(HttpServletRequest req) {

//		// 매장 검색하기
//		List<BucksDTO> list = userMapper.getStoreList();
//		req.setAttribute("storeList", list);
		return "/user/user_delivers";
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
        System.out.println(dto);
        Map<String, String> response = new HashMap<>();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json; charset=UTF-8");
        Map<String, Object> params = new HashMap<>();
        params.put("cardRegNum", dto.getCardRegNum());
        params.put("payhistoryPrice", dto.getPayhistoryPrice());
        System.out.println(params);
        try {
            int res = userMapper.paychargeCard(dto);
            int price = userMapper.plusCardPrice(params);
            if (res > 0) {
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

	
	@RequestMapping("/user_paynow")
	public String userPaynow() {
		return "/user/user_paynow";
	}

	@RequestMapping("/user_store")
	public String userStore() {
		return "/user/user_store";
	}

	@RequestMapping("/user_other")
	public String userOther() {
		return "/user/user_other";
	}

	@RequestMapping("/user_alarm")
	public String userAlarm() {
		return "/user/user_alarm";
	}

	@RequestMapping("/user_starhistory")
	public String userStarhistory() {
		return "/user/user_starhistory";
	}

	@RequestMapping("/user_recepit")
	public String userRecepit() {
		return "/user/user_recepit";
	}

	@RequestMapping("/user_info")
	public String userInfo() {
		return "/user/user_info";
	}

	@RequestMapping("/user_mymenu")
	public String userMymenu() {
		return "/user/user_mymenu";
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
