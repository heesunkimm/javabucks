package com.project.javabucksStore.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.javabucksStore.dto.BucksDTO;
import com.project.javabucksStore.dto.MenuDTO;
import com.project.javabucksStore.dto.OrderDTO;
import com.project.javabucksStore.dto.StoreMenuDTO;
import com.project.javabucksStore.mapper.MenuMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MenuController {
	
	@Autowired
	MenuMapper menuMapper;
	
	@GetMapping("/store_adddrink")
	public String addDrink() {
		return "/menu/store_adddrink";
	}
	
	@GetMapping("/store_adddessert")
	public String addDessert() {
		return "/menu/store_adddessert";
	}
	
	@GetMapping("/store_addmd")
	public String addMd() {
		return "/menu/store_addmd";
	}
	
	// 메뉴추가 - 선택된 메뉴 리스트 필터링
	@PostMapping("/getSelectMenu.ajax")
	@ResponseBody
	public List<MenuDTO> getSelectmenu(@RequestBody Map<String, String> params) {
	    String selectedOpt = params.get("menuoptCode");

	    List<MenuDTO> selectedList = menuMapper.getSelectMenu(selectedOpt);
	    
	    // 신규 이미지 추가했을 때 뒤에꺼만 짤라서 SET
	    for(int i=0; i<selectedList.size(); i++) {
	    	//System.out.println(selectedList.get(i).getMenuImages()); // eefadab4_BESMIPIS.jpg
	    	String imageName = selectedList.get(i).getMenuImages();;
	    	//System.out.println(imageName.length());
	    	if(imageName.length() != 12) {
	    		String imageName2 = imageName.substring(9, 21);
	    		selectedList.get(i).setMenuImages(imageName2);
	    	}
	    }
	    
	    return selectedList;
	}
	
	// 어드민에서 등록된 메뉴 지점 메뉴로 추가
	@PostMapping("/addMenu.ajax")
	@ResponseBody
	public Map<String, String> addMenu(HttpServletRequest req, @RequestBody StoreMenuDTO dto) {
	    String bucksId = dto.getBucksId();
	    String menuCode = dto.getMenuCode();
	    Map<String, String> response = new HashMap<>();

	    // 지점에 이미 등록된 메뉴가 있는지 확인
	    List<StoreMenuDTO> menuCheck = menuMapper.getMenuByStore(dto);
	    
	    if (menuCheck != null && !menuCheck.isEmpty()) {
	        for (StoreMenuDTO list : menuCheck) {
	            if (list.getMenuCode().equals(menuCode)) {
	                // 이미 등록된 메뉴의 상태 업데이트
	                int updateRes = menuMapper.updateMenuStatus(dto);
	                if (updateRes > 0) {
	                    response.put("status", "addSucess");
	                    response.put("storeEnable", dto.getStoreEnable());
	                    return response;
	                } else {
	                    response.put("status", "addFail");
	                    return response;
	                }
	            }
	        }
	    }
	    
	    // 지점에 메뉴 추가
	    int res = menuMapper.addMenu(dto);
	    if (res > 0) {
	        response.put("status", "addSucess");
	        response.put("storeEnable", "Y");
	        return response;
	    } else {
	        response.put("status", "addFail");
	        return response;
	    }
	}

	// 추가된 메뉴 리스트 불러오기 - 메뉴 추가 후 상태변경, 버튼 유지
	@GetMapping("/getSelectedMenu.ajax")
	@ResponseBody
	public List<StoreMenuDTO> getSelectedMenu(@RequestParam String bucksId) {
	    return menuMapper.getSelectedMenu(bucksId);
	}
	
	@PostMapping("/adminMenuDisableCheck.ajax")
	@ResponseBody
	public List<MenuDTO> adminMenuDisableCheck(HttpServletRequest req) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		// 어드민에서 주문막기 처리된 메뉴가 스토어에 있는지 조회
		List<MenuDTO> disableMenu = menuMapper.adminMenuDisableCheck(bucksId);
//		for(MenuDTO list : disableMenu) {
//			System.out.println(list.getMenuName());
//		}
		
		return disableMenu;
	}
	
	@RequestMapping("/store_alldrink")
	public String getAllDrink(HttpServletRequest req, @RequestParam Map<String, Object> params) {
		return "/menu/store_alldrink";
	}
	
	@RequestMapping("/store_alldessert")
	public String getAllDessert() {		
		return "/menu/store_alldessert";
	}
	
	@RequestMapping("/store_allmd")
	public String getAllMd() {
		return "/menu/store_allmd";
	}
	
	// 조건에 해당하는 음료 리스트 뽑기
	@PostMapping("/searchDrinks.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchDrinks(HttpServletRequest req, @RequestBody Map<String, Object> params) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
	    String menuCate = (String) params.get("menu_cate");
	    String menuBase = (String) params.get("menu_base");
	    
	    menuCate = "".equals(menuCate) ? "" : menuCate;
	    menuBase = "".equals(menuBase) ? "" : menuBase;

		Map<String, Object> searchParams = new HashMap<>();
		searchParams.put("bucksId", bucksId);
		searchParams.put("menuCate", menuCate);
		searchParams.put("menuBase", menuBase);
	    params.put("menuEnable","Y");
	    params.put("menuStatus", "Y");
	    
	    // 검색 조건에 따라 메뉴 리스트 가져오기	    
	    List<StoreMenuDTO> drinkList = menuMapper.searchDrinks(searchParams);
	    
//	    System.out.println("Drink List:");
//	    for (StoreMenuDTO drink : drinkList) {
//	        System.out.println("1. 메뉴명: " + drink.getMenuName());
//	        System.out.println("2. 메뉴추가가능: " + drink.getMenuEnable());
//	        System.out.println("3. 메뉴주문가능: " + drink.getStoremenuStatus());
//	        System.out.println("3. id" + drink.getBucksId());
//	    }
	    
	    
	    // 신규 이미지 추가했을 때 뒤에꺼만 짤라서 SET
	    for(int i=0; i<drinkList.size(); i++) {
	    	//System.out.println(top3MenuNames.get(i).getMenuImages()); // eefadab4_BESMIPIS.jpg
	    	String imageName = drinkList.get(i).getMenuImages();;
	    	//System.out.println(imageName.length());
	    	if(imageName.length() != 12) {
	    		String imageName2 = imageName.substring(9, 21);
	    		drinkList.get(i).setMenuImages(imageName2);
	    	}
	    }
	    
	    
	    
	    req.setAttribute("drinkList", drinkList);
	    return drinkList;
	}
	
	// 음료 키워드 검색 리스트 뽑기
	@PostMapping("/searchDrinksList.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchDrinksList(HttpServletRequest req, @RequestBody Map<String, Object> params) {

		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
	    String searchCont = (String) params.get("menu_name");

	    searchCont = (searchCont == null || searchCont.isEmpty()) ? "" : searchCont;
	    
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("bucksId", bucksId);
	    searchParams.put("searchCont", searchCont);
	    params.put("menuEnable","Y");
	    params.put("menuStatus", "Y");
	    
	    List<StoreMenuDTO> filterList = menuMapper.searchDrinksList(searchParams);
	    
	    // 신규 이미지 추가했을 때 뒤에꺼만 짤라서 SET
	    for(int i=0; i<filterList.size(); i++) {
	    	//System.out.println(top3MenuNames.get(i).getMenuImages()); // eefadab4_BESMIPIS.jpg
	    	String imageName = filterList.get(i).getMenuImages();;
	    	//System.out.println(imageName.length());
	    	if(imageName.length() != 12) {
	    		String imageName2 = imageName.substring(9, 21);
	    		filterList.get(i).setMenuImages(imageName2);
	    	}
	    }
	    
	    return filterList;
	}
	
	// 조건에 해당하는 디저트 리스트 뽑기
	@PostMapping("/searchDessert.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchDessert(HttpServletRequest req, @RequestBody Map<String, Object> params) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
	    String menuCate = (String) params.get("menu_cate");
	    
		Map<String, Object> searchParams = new HashMap<>();
		searchParams.put("bucksId", bucksId);
		searchParams.put("menuCate", menuCate);
	    params.put("menuEnable","Y");
	    params.put("menuStatus", "Y");
		
	    List<StoreMenuDTO> dessertList = menuMapper.searchDessert(searchParams);

	    return dessertList;
	}
	
	// 디저트 키워드 검색 리스트 뽑기
	@PostMapping("/searchDessertList.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchDessertList(HttpServletRequest req, @RequestBody Map<String, Object> params) {
		
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		String searchCont = (String) params.get("menu_name");
		
		searchCont = (searchCont == null || searchCont.isEmpty()) ? "" : searchCont;
		
		Map<String, Object> searchParams = new HashMap<>();
		searchParams.put("bucksId", bucksId);
		searchParams.put("searchCont", searchCont);
	    params.put("menuEnable","Y");
	    params.put("menuStatus", "Y");
		
		List<StoreMenuDTO> filterList = menuMapper.searchDessertList(searchParams);
		
		return filterList;
	}
	
	// 조건에 해당하는 MD 리스트 뽑기
	@PostMapping("/searchMd.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchMd(HttpServletRequest req, @RequestBody Map<String, Object> params) {
		
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		String menuCate = (String) params.get("menu_cate");
		
		Map<String, Object> searchParams = new HashMap<>();
		searchParams.put("bucksId", bucksId);
		searchParams.put("menuCate", menuCate);
	    params.put("menuEnable","Y");
	    params.put("menuStatus", "Y");
		
		List<StoreMenuDTO> mdList = menuMapper.searchMd(searchParams);
		
		req.setAttribute("mdList", mdList);
		return mdList;
	}
	
	// MD 키워드 검색 리스트 뽑기
	@PostMapping("/searchMdList.ajax")
	@ResponseBody
	public List<StoreMenuDTO> searchMdList(HttpServletRequest req, @RequestBody Map<String, Object> params) {
		
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO dto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = dto.getBucksId();
		
		String searchCont = (String) params.get("menu_name");
		
		searchCont = (searchCont == null || searchCont.isEmpty()) ? "" : searchCont;
		
		Map<String, Object> searchParams = new HashMap<>();
		searchParams.put("bucksId", bucksId);
		searchParams.put("searchCont", searchCont);
	    params.put("menuEnable","Y");
	    params.put("menuStatus", "Y");
		
		List<StoreMenuDTO> filterList = menuMapper.searchMdList(searchParams);
		
		return filterList;
	}
	
	// 주문막기 상태 업데이트
	@PostMapping("/menuStatusUpdate.ajax")
	@ResponseBody
	public String menuStatusUpdate(HttpServletRequest req, @RequestBody StoreMenuDTO dto) {
		// 세션에서 ID꺼내기
		HttpSession session = req.getSession();
		BucksDTO bdto = (BucksDTO)session.getAttribute("inBucks");
		String bucksId = bdto.getBucksId();
		
		Map<String, Object> params = new HashMap<>();
		params.put("menuCode", dto.getMenuCode());
	    params.put("bucksId", bucksId);
	    
		// 지점에 등록된 메뉴 중 이미 주문막기 처리가 됐는지 여부 확인
		StoreMenuDTO statusCheck = menuMapper.getMenuByStatus(params);
		
		int res = 0;
		
	    if (statusCheck != null) {
	        if (statusCheck.getStoremenuStatus().equals("N")) {
	            dto.setStoremenuStatus("Y");
	            res = menuMapper.menuStatusUpdate(dto);
	        }
	    } else {
	        dto.setStoremenuStatus("N");
	        res = menuMapper.menuStatusUpdate(dto);
	    }
	    
	    if (res > 0) {
	        if (statusCheck != null) {
	            return "해당 메뉴의 주문막기를 해제했습니다.";
	        }
	        return "해당 메뉴의 주문을 막았습니다.";
	    } else {
	        return "해당 메뉴의 주문을 막는데 실패하였습니다.";
	    }
	}
	
	// 메뉴삭제 - 지점에 추가한 메뉴 삭제
	@PostMapping("/deleteMenu.ajax")
	@ResponseBody
	public String delDrinkList(HttpServletRequest req, @RequestBody Map<String, Object> params) {
	    
	    // 세션에서 ID꺼내기
	    HttpSession session = req.getSession();
	    BucksDTO dto = (BucksDTO) session.getAttribute("inBucks");
	    String bucksId = dto.getBucksId();
	            
	    String menuCode = (String) params.get("menuCode");
	    String storeEnable = (String) params.get("storeEnable");
	    
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("bucksId", bucksId);
	    searchParams.put("menuCode", menuCode);
	    searchParams.put("storeEnable", storeEnable);
	    
	    // 주문완료/제조중 상태 주문내역 확인
	    List<OrderDTO> delCheck = menuMapper.delOrderCheck(bucksId);
	    
	    if (delCheck != null && !delCheck.isEmpty()) {
	        // 주문 목록에서 메뉴 코드 확인
	        for (OrderDTO orderDTO : delCheck) {
	            try {
	            	// JSON 문자열을 List<String>으로 변환
	                List<String> orderList = orderDTO.getOrderListtoStringList();
	                
	                for (String orderItem : orderList) {
	                    String[] str = orderItem.split(":"); // ":"로 문자열을 분리
	                    String orderMenuCode = str[0];
	                    
	                    // 현재 메뉴 코드와 일치하는지 확인
	                    if (orderMenuCode.equals(menuCode)) {
	                        return "현재 지점에서 주문중 or 주문완료 상태인 메뉴로 삭제할 수 없습니다.";
	                    }
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	                return "주문 내역 처리 중 오류가 발생했습니다.";
	            }
	        }
	    }
	    
	    // 메뉴 삭제 처리
	    int res = menuMapper.deleteMenu(searchParams);
	    
	    if (res > 0) {
	        return "해당 메뉴를 지점 메뉴에서 삭제하였습니다.";
	    } else {
	        return "해당 메뉴를 삭제하는데 실패하였습니다.";
	    }
	}
}
