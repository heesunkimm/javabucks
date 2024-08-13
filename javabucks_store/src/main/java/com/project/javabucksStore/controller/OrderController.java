package com.project.javabucksStore.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.javabucksStore.dto.MenuOrder;
import com.project.javabucksStore.dto.OrderDTO;
import com.project.javabucksStore.mapper.OrderMapper;

import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;


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
                
                for (String orderItem : orderList) {
                    // ":"로 문자열을 분리
                    String[] s = orderItem.split(":"); 
                    
                    if (s.length == 3) { // 예상되는 배열 길이 확인
                        String menuCode = s[0];
                        String optId = s[1];
                        String quantity = s[2];
                        
                        // 결과 출력
                        System.out.println("------------------------------");
                        System.out.println("Menu Code: " + menuCode);
                        System.out.println("Option ID: " + optId);
                        System.out.println("Quantity: " + quantity);
                        
                        
                        // 이제 여기다게 MenuOrder객체 만들어서 그 객체가지고 다시 OrderList를 업데이트해볼까?
                    } else {
                        System.out.println("Unexpected format for order item: " + orderItem);
                    }
                }
                

            } catch (IOException e) {
                // JSON 파싱 중 에러 처리
                e.printStackTrace();
            }
        }
        
        	
        	
        
        
        
        
        	
        	
        	
        	
        	
        //req.setAttribute("orderInfoList", orderInfoList);

        return "/order/store_orderHistory";
    }
}