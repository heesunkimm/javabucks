package com.project.javabucks.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.javabucks.dto.CardDTO;
import com.project.javabucks.dto.CardListDTO;
import com.project.javabucks.dto.PayhistoryDTO;
import com.project.javabucks.dto.UserDTO;
import com.project.javabucks.mapper.UserMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	UserMapper userMapper;

	@RequestMapping("/user_index")
	public String userIndex(HttpServletRequest req) {
		UserDTO dto = new UserDTO();
		dto.setUserId("inUser");
		dto.setUserPasswd("inUser");
		dto.setUserName("이용중");
		dto.setUserNickname("별며어엉");
		dto.setUserGender("M");
		dto.setUserBirth("920606");
		dto.setUserEmail1("sky2464");
		dto.setUserEmail2("naver.com");
		dto.setUserTel1("010");
		dto.setUserTel2("6859");
		dto.setUserTel3("4432");
		dto.setGradeCode("gold");
		dto.setUserGradedate("24/08/06");
		dto.setUserJoindate("24/06/06");
		dto.setUserEnable("Y");
		dto.setUserFrequencyCount("500");
		req.getSession().setAttribute("inUser", dto);

		return "/user/user_index";
	}

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
	public String modifyCardName(String cardName, String cardRegNum, Model model) {
		Map<String, String> params = new HashMap<>();
		params.put("cardName", cardName);
		params.put("cardRegNum", cardRegNum);
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

	@RequestMapping("/user_paynow")
	public String userPaynow() {
		return "/user/user_paynow";
	}

	@RequestMapping("/user_store")
	public String userStore() {
		return "/user/user_store";
	}

	@RequestMapping("/user_delivers")
	public String userDelivers() {
		return "/user/user_delivers";
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

	@RequestMapping("/user_cpnhistory")
	public String userCpnhistory() {
		return "/user/user_cpnhistory";
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
