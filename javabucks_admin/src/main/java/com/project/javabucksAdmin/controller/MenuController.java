package com.project.javabucksAdmin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.javabucksAdmin.dto.MenuDTO;
import com.project.javabucksAdmin.dto.OrderDTO;
import com.project.javabucksAdmin.mapper.MenuMapper;
import com.project.javabucksAdmin.util.FileNameUtils;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MenuController {
	
	@Autowired
	private MenuMapper menuMapper;
	
	// 메뉴등록 공통 메소드
	private String insertMenu(HttpServletRequest req, @ModelAttribute MenuDTO dto, 
	        @RequestPart(value = "uploadImages", required = false) MultipartFile uploadImages, String redirectPath) throws IOException {
	    
	    if (uploadImages != null && !uploadImages.isEmpty()) {
	        // 파일 이름 변환
	        String saveImgFileName = FileNameUtils.fileNameConvert(uploadImages.getOriginalFilename());
	        String path = req.getServletContext().getRealPath("/upload_menuImages"); // 상대 경로 설정
	        File directory = new File(path);

	        // 디렉토리가 없으면 생성
	        if (!directory.exists()) {
	            directory.mkdirs();
	        }

	        // 파일 저장
	        File file = new File(directory, saveImgFileName);
	        try {
	            uploadImages.transferTo(file);
	            dto.setMenuImages(saveImgFileName);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    } else {
	        // 파일이 없는 경우 빈 문자열로 설정
	        dto.setMenuImages("");
	    }

	    // 나머지 DTO 값 설정
	    dto.setMenuCode(dto.getMenuCode());
	    dto.setMenuName(dto.getMenuName());
	    dto.setMenuPrice(dto.getMenuPrice());
	    dto.setMenuDesc(dto.getMenuDesc());
	    dto.setMenuEnable("Y");
	    dto.setMenuoptCode(dto.getMenuoptCode());

	    // 메뉴 등록
	    int res = menuMapper.insertMenu(dto);
	    
	    // 리다이렉트 경로 반환
	    return "redirect:" + redirectPath;
	}
	
	@GetMapping("/admin_adddrink")
	public String addMenuDrink(HttpServletRequest req) {
	    return "/menu/admin_adddrink";
	}
	// 음료 등록
	@PostMapping("/admin_adddrink")
	public String insertDrink(HttpServletRequest req, @ModelAttribute MenuDTO dto, 
	        @RequestPart(value = "uploadImages", required = false) MultipartFile uploadImages) throws IOException {
	    return insertMenu(req, dto, uploadImages, "/admin_drinklist");
	}
	
	@GetMapping("/admin_adddessert")
	public String addMenuDessert(HttpServletRequest req) {
	    return "/menu/admin_adddessert";
	}
	// 디저트 등록
	@PostMapping("/admin_adddessert")
	public String insertDessert(HttpServletRequest req, @ModelAttribute MenuDTO dto, 
	        @RequestPart(value = "uploadImages", required = false) MultipartFile uploadImages) throws IOException {
	    return insertMenu(req, dto, uploadImages, "/admin_dessertlist");
	}
	
	@GetMapping("/admin_addmd")
	public String addMenuMd(HttpServletRequest req) {
		return "/menu/admin_addmd";
	}
	// MD 등록
	@PostMapping("/admin_addmd")
	public String insertMd(HttpServletRequest req, @ModelAttribute MenuDTO dto, 
	        @RequestPart(value = "uploadImages", required = false) MultipartFile uploadImages) throws IOException {
	    return insertMenu(req, dto, uploadImages, "/admin_mdlist");
	}
	
	// 조건에 해당하는 음료리스트 검색
	@RequestMapping("/admin_drinklist")
	public String getAllDrinks(HttpServletRequest req, @RequestParam Map<String, Object> params, 
	        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
	    
	    // 검색 필터가 null or ""일 경우 기본값 설정
	    String menuCate = (String) params.get("menu_cate");
	    String menuBase = (String) params.get("menu_base");
	    String menuName = (String) params.get("menuName");
	    String menuStatus = (String) params.get("menuStatus");
	    
	    menuCate = (menuCate == null || menuCate.isEmpty()) ? "" : menuCate;
	    menuBase = (menuBase == null || menuBase.isEmpty()) ? "" : menuBase;
	    menuName = (menuName == null || menuName.isEmpty()) ? "" : menuName;
	    menuStatus = (menuStatus == null || menuStatus.isEmpty()) ? "N" : "Y";
	    
	    // 검색 조건을 포함한 매퍼 호출
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("menu_cate", menuCate);
	    searchParams.put("menu_base", menuBase);
	    searchParams.put("menuName", menuName);
	    searchParams.put("menuEnable", "Y");
	    searchParams.put("menuStatus", menuStatus);
	    
	    int searchCount = menuMapper.searchDrinkCount(searchParams); // 검색결과별 리스트 수
	    int pageSize = 10; // 한 페이지의 보여줄 리스트 갯수
	    int startRow = (pageNum - 1) * pageSize + 1;
	    int endRow = startRow + pageSize - 1;	
	    if (endRow > searchCount) endRow = searchCount;		
	    int no = searchCount - startRow + 1;				
	    int pageBlock = 3;
	    int pageCount = searchCount / pageSize + (searchCount % pageSize == 0 ? 0 : 1);		
	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1;		
	    int endPage = startPage + pageBlock - 1;
	    if (endPage > pageCount) endPage = pageCount;
	    
	    List<MenuDTO> drinkList;
	    
	    // 검색 조건에 따라 메뉴 리스트 가져오기
	    searchParams.put("startRow", startRow);
	    searchParams.put("endRow", endRow);
	    
	    drinkList = menuMapper.searchDrink(searchParams);
	    
	    if (drinkList.isEmpty()) {
	        // 값이 없을 때
	        req.setAttribute("noList", true);
	    } else {
	        // 값이 있을 때
	        req.setAttribute("drinkList", drinkList);
	        req.setAttribute("searchParams", searchParams);
	        req.setAttribute("searchCount", searchCount);
	        req.setAttribute("pageSize", pageSize);
	        req.setAttribute("startRow", startRow);
	        req.setAttribute("endRow", endRow);
	        req.setAttribute("no", no);
	        req.setAttribute("pageBlock", pageBlock);
	        req.setAttribute("pageCount", pageCount);
	        req.setAttribute("startPage", startPage);
	        req.setAttribute("endPage", endPage);
	    }
	    return "/menu/admin_drinklist";
	}
	
	// 조건에 해당하는 디저트리스트 검색
	@RequestMapping("/admin_dessertlist")
	public String getAllDessert(HttpServletRequest req, @RequestParam Map<String, Object> params, 
	        @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
		
		// 검색 필터가 null or ""일 경우 기본값 설정
	    String menuName = (String) params.get("menuName");
	    String menuStatus = (String) params.get("menuStatus");
	    
	    menuName = (menuName == null || menuName.isEmpty()) ? "" : menuName;
	    menuStatus = (menuStatus == null || menuStatus.isEmpty()) ? "N" : "Y";
	    
	    // 검색 조건을 포함한 매퍼 호출
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("menuName", menuName);
	    searchParams.put("menuEnable", "Y");
	    searchParams.put("menuStatus", menuStatus);
	    
	    int searchCount = menuMapper.searchDessertCount(searchParams);
	    int pageSize = 10; // 한 페이지의 보여줄 리스트 갯수
	    int startRow = (pageNum - 1) * pageSize + 1;
	    int endRow = startRow + pageSize - 1;	
	    if (endRow > searchCount) endRow = searchCount;		
	    int no = searchCount - startRow + 1;				
	    int pageBlock = 3;
	    int pageCount = searchCount / pageSize + (searchCount % pageSize == 0 ? 0 : 1);		
	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1;		
	    int endPage = startPage + pageBlock - 1;
	    if (endPage > pageCount) endPage = pageCount;
	    
	    List<MenuDTO> dessertList;
	    
	    // 검색 조건에 따라 메뉴 리스트 가져오기
	    searchParams.put("startRow", startRow);
	    searchParams.put("endRow", endRow);
	    
	    dessertList = menuMapper.searchDessert(searchParams);
	    
	    if (dessertList.isEmpty()) {
	        // 값이 없을 때
	        req.setAttribute("noList", true);
	    } else {
	        // 값이 있을 때
	        req.setAttribute("dessertList", dessertList);
	        req.setAttribute("searchParams", searchParams);
	        req.setAttribute("searchCount", searchCount);
	        req.setAttribute("pageSize", pageSize);
	        req.setAttribute("startRow", startRow);
	        req.setAttribute("endRow", endRow);
	        req.setAttribute("no", no);
	        req.setAttribute("pageBlock", pageBlock);
	        req.setAttribute("pageCount", pageCount);
	        req.setAttribute("startPage", startPage);
	        req.setAttribute("endPage", endPage);
	    }
	    return "/menu/admin_dessertlist";
	}
	
	// 조건에 해당하는 MD리스트 검색
	@RequestMapping("/admin_mdlist")
	public String getAllMd(HttpServletRequest req, @RequestParam Map<String, Object> params, 
			@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
		
		// 검색 필터가 null or ""일 경우 기본값 설정
	    String menuName = (String) params.get("menuName");
	    String menuStatus = (String) params.get("menuStatus");
	    
	    menuName = (menuName == null || menuName.isEmpty()) ? "" : menuName;
	    menuStatus = (menuStatus == null || menuStatus.isEmpty()) ? "N" : "Y";
	    
	    // 검색 조건을 포함한 매퍼 호출
	    Map<String, Object> searchParams = new HashMap<>();
	    searchParams.put("menuName", menuName);
	    searchParams.put("menuEnable", "Y");
	    searchParams.put("menuStatus", menuStatus);
	    
	    int searchCount = menuMapper.searchMdCount(searchParams);
	    int pageSize = 10; // 한 페이지의 보여줄 리스트 갯수
	    int startRow = (pageNum - 1) * pageSize + 1;
	    int endRow = startRow + pageSize - 1;	
	    if (endRow > searchCount) endRow = searchCount;		
	    int no = searchCount - startRow + 1;				
	    int pageBlock = 3;
	    int pageCount = searchCount / pageSize + (searchCount % pageSize == 0 ? 0 : 1);		
	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1;		
	    int endPage = startPage + pageBlock - 1;
	    if (endPage > pageCount) endPage = pageCount;
	    
	    List<MenuDTO> mdList;
	    
	    // 검색 조건에 따라 메뉴 리스트 가져오기
	    searchParams.put("startRow", startRow);
	    searchParams.put("endRow", endRow);
	    
	    mdList = menuMapper.searchMd(searchParams);
	    
	    if (mdList.isEmpty()) {
	        // 값이 없을 때
	        req.setAttribute("noList", true);
	    } else {
	        // 값이 있을 때
	        req.setAttribute("mdList", mdList);
	        req.setAttribute("searchParams", searchParams);
	        req.setAttribute("searchCount", searchCount);
	        req.setAttribute("pageSize", pageSize);
	        req.setAttribute("startRow", startRow);
	        req.setAttribute("endRow", endRow);
	        req.setAttribute("no", no);
	        req.setAttribute("pageBlock", pageBlock);
	        req.setAttribute("pageCount", pageCount);
	        req.setAttribute("startPage", startPage);
	        req.setAttribute("endPage", endPage);
	    }
		return "/menu/admin_mdlist";
	}
	
	// 주문막기/풀기 메소드
	@PostMapping("/menuStatusUpdate.ajax")
	@ResponseBody
	public ResponseEntity<String> menuStatusUpdate(@RequestBody MenuDTO dto) {
	    int res = menuMapper.menuStatusUpdate(dto);
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/plain; charset=UTF-8");
	    
	    if (res > 0) {
	        return ResponseEntity.ok().headers(headers).body("주문 막기/풀기 완료");
	    } else {
	        return ResponseEntity.ok().headers(headers).body("주문 막기/풀기 실패");
	    }
	}
	
	// 메뉴 상세 페이지 이동 공동 메소드
	private String editMenuCont(HttpServletRequest req, String menuCode, String viewName) {
        MenuDTO menu = menuMapper.getEditMenu(menuCode);
        req.setAttribute("menu", menu);
        return "/menu/" + viewName;
    }
	
	// 메뉴수정 공통 메소드
	private String MenuEdit(HttpServletRequest req, MenuDTO dto,
            MultipartFile uploadImages, String redirectUrl) throws IOException {

		if (uploadImages != null && !uploadImages.isEmpty()) {
			String saveImgFileName = FileNameUtils.fileNameConvert(uploadImages.getOriginalFilename());
			String path = req.getServletContext().getRealPath("/upload_menuImages");
			File directory = new File(path);
			
			if (!directory.exists()) {
				directory.mkdirs();
			}
			
			File file = new File(directory, saveImgFileName);
			try {
				uploadImages.transferTo(file);
				dto.setMenuImages(saveImgFileName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			// 이미지 변경 없을 경우 기존 이미지 유지
			dto.setMenuImages(dto.getMenuImages());
		}
		
		int res = menuMapper.editMenu(dto);
		return "redirect:/" + redirectUrl;
	}
	
	// 음료 수정/삭제 페이지
    @RequestMapping("/admin_editdrink")
    public String editDrinkCont(HttpServletRequest req, @RequestParam String menuCode) {
        return editMenuCont(req, menuCode, "admin_editdrink");
    }
    // 음료 수정
    @PostMapping("/admin_editdrink")
    public String editDrink(HttpServletRequest req, @ModelAttribute MenuDTO dto,
                            @RequestPart(value = "uploadImages", required = false) MultipartFile uploadImages) throws IOException {
        return MenuEdit(req, dto, uploadImages, "admin_drinklist");
    }
    
    // 음료 삭제
    @PostMapping("/delDrink.ajax")
    @ResponseBody
    public String delDrink(@RequestBody Map<String, Object> params) {
        String menuCode = (String) params.get("menuCode");
        
        // 주문완료/제조중 상태 주문내역 확인
	    List<OrderDTO> orderCheck = menuMapper.OrderCheck(params);
	    
	    if (orderCheck != null) {
	        // 주문 목록에서 메뉴 코드 확인
	        for (OrderDTO orderDTO : orderCheck) {
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
        
        // 주문 상태 확인 후 메뉴 삭제
        int res = menuMapper.delMenu(menuCode);
        
        if (res > 0) {
            return "해당 메뉴가 삭제되었습니다.";
        } else {
            return "메뉴 메뉴삭제에 실패하였습니다.";
        }
    }

    // 디저트 수정/삭제 페이지
    @RequestMapping("/admin_editdessert")
    public String editDessertCont(HttpServletRequest req, @RequestParam String menuCode) {
        return editMenuCont(req, menuCode, "admin_editdessert");
    }
    // 디저트 수정
    @PostMapping("/admin_editdessert")
    public String editDessert(HttpServletRequest req, @ModelAttribute MenuDTO dto,
                              @RequestPart(value = "uploadImages", required = false) MultipartFile uploadImages) throws IOException {
        return MenuEdit(req, dto, uploadImages, "admin_dessertlist");
    }
    
    // 디저트 삭제
    @PostMapping("/delDessert.ajax")
    @ResponseBody
    public String delDessert(@RequestBody Map<String, Object> params) {
        String menuCode = (String) params.get("menuCode");
        
        // 주문완료/제조중 상태 주문내역 확인
	    List<OrderDTO> orderCheck = menuMapper.OrderCheck(params);
	    
	    if (orderCheck != null) {
	        // 주문 목록에서 메뉴 코드 확인
	        for (OrderDTO orderDTO : orderCheck) {
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

        // 주문 상태 확인 후 메뉴 삭제
        int res = menuMapper.delMenu(menuCode);
        
        if (res > 0) {
            return "해당 메뉴가 삭제되었습니다.";
        } else {
            return "메뉴 메뉴삭제에 실패하였습니다.";
        }
    }
    
    // MD 수정/삭제 페이지
    @RequestMapping("/admin_editmd")
    public String editMdCont(HttpServletRequest req, @RequestParam String menuCode) {
        return editMenuCont(req, menuCode, "admin_editmd");
    }
    // MD 수정
    @PostMapping("/admin_editmd")
    public String editMd(HttpServletRequest req, @ModelAttribute MenuDTO dto,
                         @RequestPart(value = "uploadImages", required = false) MultipartFile uploadImages) throws IOException {
        return MenuEdit(req, dto, uploadImages, "admin_mdlist");
    }
//    // MD 삭제
    @PostMapping("/delMd.ajax")
    @ResponseBody
    public String delMd(@RequestBody Map<String, Object> params) {
        String menuCode = (String) params.get("menuCode");
        
        // 주문완료/제조중 상태 주문내역 확인
	    List<OrderDTO> orderCheck = menuMapper.OrderCheck(params);
	    
	    if (orderCheck != null) {
	        // 주문 목록에서 메뉴 코드 확인
	        for (OrderDTO orderDTO : orderCheck) {
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

        // 주문 상태 확인 후 메뉴 삭제
        int res = menuMapper.delMenu(menuCode);
        
        if (res > 0) {
            return "해당 메뉴가 삭제되었습니다.";
        } else {
            return "메뉴 메뉴삭제에 실패하였습니다.";
        }
    }
}
