package com.project.javabucksStore.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.eclipse.tags.shaded.org.apache.bcel.generic.RETURN;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.javabucksStore.dto.BaljooDTO;
import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.MenuDTO;
import com.project.javabucksStore.dto.PayhistoryDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class HomeMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<PayhistoryDTO> topMenuOrderList(String bucksId){
		return sqlSession.selectList("topMenuOrderList",bucksId);
	}
	
	public List<MenuDTO> getMenuDetails(@Param("list") List<String> menuCodes){
		return sqlSession.selectList("getMenuDetails",menuCodes);
	}
	public List<Map<String, Object>> MonthlySales(String bucksId, String year){
		Map<String, Object> params = new HashMap<>();
        params.put("bucksId", bucksId);
        params.put("year", year);
		return sqlSession.selectList("MonthlySales",params);
	}
	

}
