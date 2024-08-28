package com.project.javabucksAdmin.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksAdmin.dto.AlarmDTO;
import com.project.javabucksAdmin.dto.CouponDTO;
import com.project.javabucksAdmin.dto.CouponListDTO;
import com.project.javabucksAdmin.dto.UserDTO;
import com.project.javabucksAdmin.mapper.CouponMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CouponController {
	
	@Autowired
	private CouponMapper couponMapper;
	
	@RequestMapping("/admin_cpnmange")
	public String cpnIndex (HttpServletRequest req) {
		// 쿠폰생성
		List<CouponDTO> cpnList = couponMapper.listCoupon();
		
		req.setAttribute("cpnList", cpnList);
		return "/coupon/admin_cpnmange";
	}
	
	// 매일 00시 스케줄링 실행
	@Scheduled(cron = "0 0 0 * * ?") 
	public void sendCoupon () {
		// 생일 일주일 전인 유저에게 쿠폰 발송
		userBirthCheck();
		// 발급된 쿠폰 확인해 유저에게 알림 전송
		cpnListCheck();
	}

	// 유저 생일 체크
	public void userBirthCheck() {
	    // 오늘 날짜 기준으로 일주일 뒤 날짜 셋팅
	    SimpleDateFormat dtFormat = new SimpleDateFormat("MM-dd");
	    Calendar cal = Calendar.getInstance();
	    // 오늘 날짜 포맷팅 후 설정
	    String today = dtFormat.format(cal.getTime());
	    cal.add(Calendar.DATE, 7);  // 현재 날짜에서 7일 추가
	    // 일주일 뒤 날짜
	    String onlyDate = dtFormat.format(cal.getTime());
	    
	    // 유저 정보 조회
	    List<UserDTO> userCheck = couponMapper.getUserInfo();
	    
	    // 조회된 유저 정보와 오늘 날짜 비교
	    for (UserDTO user : userCheck) {
	        // 등록된 유저 생일
	    	String userBday = user.getUserBirth().substring(5, 10);
	        
	    	// 유저의 생일이 일주일뒤 날짜와 같을때 실행
	        if (onlyDate.equals(userBday)) {
	        	CouponListDTO cpn = new CouponListDTO();
	        	cpn.setUserId(user.getUserId());
	        	cpn.setCpnCode("B-1");
	        	cpn.setCpnListStatus("발급완료");
	        	
	        	// 유저에게 쿠폰 등록
	        	toUserCoupon(cpn);
	        }
	    }
	}
	
	// 유저에게 쿠폰 알림 전송
	public void cpnListCheck() {
		// 오늘 날짜 포맷팅
		Date nowDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM-dd"); 
		String today = simpleDateFormat.format(nowDate);
		
		// 등록된 쿠폰리스트 조회
		List<CouponListDTO> userCpnList = couponMapper.getUserCpnList();
		
		for(CouponListDTO user : userCpnList) {
			// 쿠폰 발급일
			String cpnStartDate = user.getCpnListStartDate().substring(5, 10);
			String cpnListCode = user.getCpnCode();
			
			// 오늘 날짜와 쿠폰 발급일이 동일할 때
			if(today.equals(cpnStartDate)) {
				AlarmDTO alarm = new AlarmDTO();
				alarm.setUserId(user.getUserId());
				alarm.setAlarmCate("cpn");
				
				// 쿠폰코드별 AlarmCont 조건
				if(cpnListCode.equals("B-1")) {
					alarm.setAlarmCont(user.getUserId() + "님 생일쿠폰이 발급되었습니다.");
				}else {
					alarm.setAlarmCont(user.getUserId() + "님 쿠폰이 발급되었습니다.");
				}
				
	        	// 등록된 쿠폰이 있다면 해당 유저에게 알람 전송
	        	 toUserAlarm(alarm);
			}
		}
	}
	
	// 유저에게 등록된 쿠폰 전송
	public String toUserCoupon(CouponListDTO dto) {
		int res = couponMapper.toUserCoupon(dto);
		
		if(res > 0) {
			return "쿠폰전송 성공";
		}else {
			return "쿠폰전송 실패";
		}
	}
	
	// 유저에게 쿠폰 알림 등록
	public String toUserAlarm(AlarmDTO dto) {
		int res = couponMapper.toUserAlarm(dto);
		
		if(res > 0) {
			return "알림전송 성공";
		}else {
			return "알림전송 실패";
		}
	}
	
	// 어드민 쿠폰등록
	@PostMapping("/insertCoupon.ajax")
	@ResponseBody	
	public String insertCoupon(@RequestBody CouponDTO dto) {
	    // 중복 체크
	    CouponDTO cpnCheck = couponMapper.cpnCheck(dto);
	    
	    if (cpnCheck != null) {
	        // 중복된 쿠폰이 있을 경우
	    	return "[" + dto.getCpnCode() + "] " + "이미 등록된 쿠폰코드입니다.";
	    }

	    // 쿠폰 등록
	    int res = couponMapper.insertCoupon(dto);

	    if (res > 0) {
	        return "쿠폰등록이 완료되었습니다.";
	    } else {
	        return "쿠폰등록에 실패하였습니다.";
	    }
	}
	
	// 쿠폰삭제
	@PostMapping("/deleteCoupon.ajax")
	@ResponseBody
	public String deleteCoupon(@RequestBody Map<String, String> params) {
		String cpnCode = params.get("cpnCode");
		
		int res = couponMapper.deleteCoupon(cpnCode);
		System.out.println(res);
		
	    if (res > 0) {
	        return "해당 쿠폰이 삭제되었습니다.";
	    } else {
	        return "해당 쿠폰 삭제를 실패하였습니다.";
	    }
	}
	
	// 등록된 쿠폰리스트 조회
	@GetMapping("/getCouponList.ajax")
	@ResponseBody
	public ResponseEntity<List<CouponDTO>> getCouponList() {
	    List<CouponDTO> cpnList = couponMapper.listCoupon();
	    return ResponseEntity.ok(cpnList);
	}
}
