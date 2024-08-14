package com.project.javabucksStore.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.javabucksStore.dto.MenuOrder;
import com.project.javabucksStore.dto.OrderDTO;
import com.project.javabucksStore.dto.OrderOptDTO;
import com.project.javabucksStore.mapper.OrderMapper;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class OrderController {

    @Autowired
    OrderMapper mapper;

    @GetMapping("/orderHistory.do")
    public String orderHistory(HttpServletRequest req) {
    	 // 지점 아이디 받아서 추가하는 작업 필요
        String bucksId = "bucks001";
        
        Map<String, Object> params = new HashMap<>();
        params.put("bucksId", bucksId);
        
        // 주문정보
        List<OrderDTO> orderInfoList = mapper.orderInfo(params);
        
        
        
        for (OrderDTO orderDTO : orderInfoList) {
            try {
                // JSON 문자열을 List<String>으로 변환
                List<String> orderList = orderDTO.getOrderListtoStringList();
                // 메뉴명까지 들어간 orderList (업데이트용)
                List<MenuOrder> updateOrderList = new ArrayList<>();                
                // 실제 옵션데이터가 들어갈 옵션정보 리스트 (업데이트용)
                List<MenuOrder> updateOptList = new ArrayList<>();
                
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
                    
                    for(OrderOptDTO dto : optList) {
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
            
            
        }       
        	
        	
        // update된 orderInfoLIst 출력해보기(메뉴명 잘 들어갔는지)
        for(OrderDTO dto : orderInfoList) {
        	System.out.println(dto.getOrderList());
        }
        
        
        	
        	
        	
        	
        	
        req.setAttribute("orderInfoList", orderInfoList);

        return "/order/store_orderHistory";
    }
}