package com.project.javabucks.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.javabucks.dto.AlarmDTO;
import com.project.javabucks.dto.BucksDTO;
import com.project.javabucks.dto.CardDTO;
import com.project.javabucks.dto.CardListDTO;
import com.project.javabucks.dto.CartDTO;
import com.project.javabucks.dto.CouponListDTO;
import com.project.javabucks.dto.FrequencyDTO;
import com.project.javabucks.dto.MenuDTO;
import com.project.javabucks.dto.MenuOptCupDTO;
import com.project.javabucks.dto.MenuOptIceDTO;
import com.project.javabucks.dto.MenuOptMilkDTO;
import com.project.javabucks.dto.MenuOptShotDTO;
import com.project.javabucks.dto.MenuOptSyrupDTO;
import com.project.javabucks.dto.MenuOptWhipDTO;
import com.project.javabucks.dto.MymenuDTO;
import com.project.javabucks.dto.OrderDTO;
import com.project.javabucks.dto.OrderOptDTO;
import com.project.javabucks.dto.PayhistoryDTO;
import com.project.javabucks.dto.UserDTO;

@Service
public class UserMapper {

	@Autowired
	private SqlSession sqlSession;

	public List<AlarmDTO> noReadAlarm(String userId) {
		return sqlSession.selectList("noReadAlarm", userId);
	}

	public int readAlarmUpdate(String userId) {
		return sqlSession.update("readAlarmUpdate", userId);
	}

	public BucksDTO getBucksinfoById(String bucksId) {
		return sqlSession.selectOne("getBucksinfoById", bucksId);
	}

	public int addNewCard(CardDTO dto) {
		return sqlSession.insert("addNewCard", dto);
	}

	public String findBucksLocation(String bucksName) {
		return sqlSession.selectOne("findBucksLocation", bucksName);
	}

	public List<CardDTO> listRegCardById(String userId) {
		return sqlSession.selectList("listRegCardById", userId);
	}

	public CardDTO checkCardDupl(String cardRegNum) {
		return sqlSession.selectOne("checkCardDupl", cardRegNum);
	}

	public CardListDTO compareCardNum(String cardRegNum) {
		return sqlSession.selectOne("compareCardNum", cardRegNum);
	}

	public int modifyCardStatus(String cardRegNum) {
		return sqlSession.update("modifyCardStatus", cardRegNum);
	}

	public int updateCardName(Map<String, String> params) {
		return sqlSession.update("updateCardName", params);
	}

	// Payhistory 카드충전 기록.
	public int paychargeCard(PayhistoryDTO dto) {
		return sqlSession.insert("paychargeCard", dto);
	}

	// Payhistory 주문결제 기록.
	public int payhistoryOrder(PayhistoryDTO dto) {
		return sqlSession.insert("payhistoryOrder", dto);
	}

	// Order 주문결제 기록
	public int orderInsert(OrderDTO dto) {
		return sqlSession.update("orderInsert", dto);
	}

	public int insertOrderAlarm(AlarmDTO dto) {
		return sqlSession.insert("insertOrderAlarm", dto);
	}

	public int insertAlamUpgrade(Map<String, String> params) {
		return sqlSession.insert("insertAlamUpgrade", params);
	}

	public int insertAlamCoupon(Map<String, String> params) {
		return sqlSession.insert("insertAlamCoupon", params);
	}

	public int getCardCountByUserId(String userId) {
		return sqlSession.selectOne("getCardCountByUserId", userId);
	}

	// 카드 충전 금액 증가
	public int plusCardPrice(Map<String, Object> params) {
		return sqlSession.update("plusCardPrice", params);
	}

	// 카드 충전 금액 감소
	public int minusCardPrice(Map<String, String> params) {
		return sqlSession.update("minusCardPrice", params);
	}

	// 해당아이디로 등록된 알람 전체리스트(날짜순)
	public List<AlarmDTO> listGetAlarmById(String userId) {
		return sqlSession.selectList("listGetAlarmById", userId);
	}

	// 알람 카테별 리스트(날짜순)
	public List<AlarmDTO> getAlarmsByCategory(String userId, String alarmCate) {
		Map<String, String> params = new HashMap<>();
		params.put("userId", userId);
		params.put("alarmCate", alarmCate);
		return sqlSession.selectList("getAlarmsByCategory", params);
	}

	// 주문옵션 javabucks_order_opt 테이블인서트
	public int orderOptInsert(OrderOptDTO dto) {
		return sqlSession.insert("orderOptInsert", dto);
	}

	// 인서트된 optId 바로 뽑기
	public int orderOptIdsearch() {
		return sqlSession.selectOne("orderOptIdsearch");
	}

	// 옵션의 총 가격
	public int orderOptTotPrice(int optId) {
		return sqlSession.selectOne("orderOptTotPrice", optId);
	}

	// 가장 최근 orderCode 찾아 뽑기
	public String getMaxOrderCode(String pickData) {
		return sqlSession.selectOne("getMaxOrderCode", pickData);
	}

	// optId 로 OrderOptDTO 구하기
	public OrderOptDTO findOrderOpt(int optId) {
		return sqlSession.selectOne("findOrderOpt", optId);
	}

	public MenuOptCupDTO getCupInfo(int optId) {
		return sqlSession.selectOne("getCupInfo", optId);
	}

	public MenuOptIceDTO getIceInfo(int optId) {
		return sqlSession.selectOne("getIceInfo", optId);
	}

	public MenuOptShotDTO getShotInfo(int optId) {
		return sqlSession.selectOne("getShotInfo", optId);
	}

	public MenuOptWhipDTO getWhipInfo(int optId) {
		return sqlSession.selectOne("getWhipInfo", optId);
	}

	public MenuOptSyrupDTO getSyrupInfo(int optId) {
		return sqlSession.selectOne("getSyrupInfo", optId);
	}

	public MenuOptMilkDTO getMilkInfo(int optId) {
		return sqlSession.selectOne("getMilkInfo", optId);
	}

	@Transactional
	public void processFrequencyAndUserUpdate(String userId, int quantity) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("quantity", quantity);

		sqlSession.insert("insertFrequency", params);

		// User의 frequency count 업데이트
		sqlSession.update("updateUserFrequencyCount", params);
	}

	public int cpnListStatusChange(int cpnListNum) {
		return sqlSession.update("cpnListStatusChange", cpnListNum);
	}

	// cartType이 delivers 인 경우 가장큰 cartNum cartDTO
	public CartDTO findCartByMaxCartNumForDelivers(String userId) {
		return sqlSession.selectOne("findCartByMaxCartNumForDelivers", userId);
	}

	// cartType이 delivers 이 아닌 경우 가장큰 cartNum cartDTO
	public CartDTO findCartByMaxCartNumForNonDelivers(String userId) {
		return sqlSession.selectOne("findCartByMaxCartNumForNonDelivers", userId);
	}

	// 채성진 작업------------------------------------------------------
	public UserDTO getInfoById(String userId) {
		return sqlSession.selectOne("getInfoById", userId);
	}

	public List<FrequencyDTO> getFrequencyById(String userId) {
		return sqlSession.selectList("getFrequencyById", userId);
	}

	public int updateGreen(String userId) {
		return sqlSession.update("updateGreen", userId);
	}
	
	public int cpnInsertGreen(String userId) {
		return sqlSession.insert("cpnInsertGreen", userId);
	}
	
	public int cpnInsertGold(String userId) {
		return sqlSession.insert("cpnInsertGold", userId);
	}
	
	public int cpnInsertDrink(String userId) {
		return sqlSession.insert("cpnInsertDrink", userId);
	}

	public int updateGold(String userId) {
		return sqlSession.update("updateGold", userId);
	}

	public int updateGoldAfter(String userId) {
		return sqlSession.update("updateGoldAfter", userId);
	}

	public int updateCount(Map<String, Object> params) {
		return sqlSession.update("updateCount", params);
	}
	
	public int AddMyMenu(Map<String, String> params) {
		return sqlSession.insert("AddMyMenu", params);
	}

	public MymenuDTO SearchMyMenu(Map<String, String> params) {
		return sqlSession.selectOne("SearchMyMenu", params);
	}
	
	public int DeleteMyMenu(Map<String, String> params) {
		return sqlSession.delete("DeleteMyMenu", params);
	}
	
	public List<CouponListDTO> getCouponListById(String userId) {
		return sqlSession.selectList("getCouponListById", userId);
	}
	
	public List<BucksDTO> StoreAll() {
		return sqlSession.selectList("StoreAll");
	}
	
	public List<BucksDTO> getStoreList(String storeSearch) {
		return sqlSession.selectList("getStoreList", storeSearch);
	}

	public List<BucksDTO> getStoreList2(List<String> searchTerms) {
		return sqlSession.selectList("getStoreList2", searchTerms);
	}
	
	public List<BucksDTO> getStoreListByMenuCode(Map<String, Object> params) {
		return sqlSession.selectList("getStoreListByMenuCode", params);
	}

	public String getOrderEnableBybucksId(String bucksId) {
		return sqlSession.selectOne("getOrderEnableBybucksId", bucksId);
	}
	
	public String getStoreEnable(Map<String, String> params) {
		return sqlSession.selectOne("getStoreEnable", params);
	}
	
	public List<MenuDTO> getStoreDrinkList(String storeName) {
		return sqlSession.selectList("getStoreDrinkList", storeName);
	}
	
	public String getMenuOptCode(String menuCode) {
		return sqlSession.selectOne("getMenuOptCode", menuCode);
	}

	public String getMenuStatus(Map<String, String> params) {
		return sqlSession.selectOne("getMenuStatus", params);
	}
	
	public String getMenuStatus2(Map<String, String> params) {
		return sqlSession.selectOne("getMenuStatus2", params);
	}

	public List<MenuDTO> getStoreFoodList(String storeName) {
		return sqlSession.selectList("getStoreFoodList", storeName);
	}

	public List<MenuDTO> getStoreProdcutList(String storeName) {
		return sqlSession.selectList("getStoreProdcutList", storeName);
	}

	public MenuDTO getMenuInfoByCode(String menuCode) {
		return sqlSession.selectOne("getMenuInfoByCode", menuCode);
	}

	public List<MenuOptCupDTO> CupSizeByCode(String menuoptCode) {
		return sqlSession.selectList("CupSizeByCode", menuoptCode);
	}

	public List<MenuOptIceDTO> IceByCode(String menuoptCode) {
		return sqlSession.selectList("IceByCode", menuoptCode);
	}

	public MenuOptShotDTO ShotByCode(String menuoptCode) {
		return sqlSession.selectOne("ShotByCode", menuoptCode);
	}

	public List<MenuOptWhipDTO> WhipByCode(String menuoptCode) {
		return sqlSession.selectList("WhipByCode", menuoptCode);
	}

	public List<MenuOptSyrupDTO> SyrupByCode(String menuoptCode) {
		return sqlSession.selectList("SyrupByCode", menuoptCode);
	}

	public List<MenuOptMilkDTO> MilkByCode(String menuoptCode) {
		return sqlSession.selectList("MilkByCode", menuoptCode);
	}

	public List<FrequencyDTO> StarHistoryByUserid(Map<String, String> params) {
		return sqlSession.selectList("StarHistoryByUserid", params);
	}

	public List<MenuDTO> MyMenuByUserid(String userId) {
		return sqlSession.selectList("MyMenuByUserid", userId);
	}

	public int MyMenuNumByUserid(Map<String, String> params) {
		return sqlSession.selectOne("MyMenuNumByUserid", params);
	}

	public int MyMenuDeleteByMenuNum(int mymenuNum) {
		return sqlSession.delete("MyMenuDeleteByMenuNum", mymenuNum);
	}

	public List<PayhistoryDTO> RecepitByUserid(Map<String, String> params) {
		return sqlSession.selectList("RecepitByUserid", params);
	}

	public OrderDTO OrderInfoByHistoryNum(int payhistoryNum) {
		return sqlSession.selectOne("OrderInfoByHistoryNum", payhistoryNum);
	}

	public BucksDTO StoreInfoByBucksId(String bucksId) {
		return sqlSession.selectOne("StoreInfoByBucksId", bucksId);
	}

	public PayhistoryDTO PayInfoByHistoryNum(int payhistoryNum) {
		return sqlSession.selectOne("PayInfoByHistoryNum", payhistoryNum);
	}

	public String NicknameByHistoryNum(int payhistoryNum) {
		return sqlSession.selectOne("NicknameByHistoryNum", payhistoryNum);
	}

	public CardDTO CardInfoByHistoryNum(int payhistoryNum) {
		return sqlSession.selectOne("CardInfoByHistoryNum", payhistoryNum);
	}

	public int insertCart(Map<String, Object> params) {
		return sqlSession.update("insertCart", params);
	}

	public int updateCart(Map<String, Object> params) {
		return sqlSession.update("updateCart", params);
	}
	
	public List<CartDTO> CartManyByUserid(Map<String, String> params) {
		return sqlSession.selectList("CartManyByUserid", params);
	}

	public CartDTO CartinfoByCartNum(Map<String, Object> params) {
		return sqlSession.selectOne("CartinfoByCartNum", params);
	}

	public List<CartDTO> CartinfoOdByUserId(Map<String, Object> params) {
		return sqlSession.selectList("CartinfoOdByUserId", params);
	}
	
	public List<CartDTO> CartinfoDlvByUserId(Map<String, Object> params) {
		return sqlSession.selectList("CartinfoDlvByUserId", params);
	}

	public int updateCartCount(Map<String, Integer> params) {
		return sqlSession.update("updateCartCount", params);
	}

	public List<CartDTO> OrderCartByUserid(String userId) {
		return sqlSession.selectList("OrderCartByUserid", userId);
	}

	public List<CartDTO> DeliversCartByUserid(String userId) {
		return sqlSession.selectList("DeliversCartByUserid", userId);
	}

	public int deleteCart(Map<String, Object> params) {
		return sqlSession.delete("deleteCart", params);
	}

	public int deleteAllCartOrder(String userId) {
		return sqlSession.delete("deleteAllCartOrder", userId);
	}

	public int deleteAllCartDelivers(String userId) {
		return sqlSession.delete("deleteAllCartDelivers", userId);
	}

	// 민영
	// 작업-------------------------------------------------------------------------

	public List<OrderDTO> getOrderHistory(Map<String, String> params) {
		return sqlSession.selectList("getOrderHistory", params);
	}

	public List<OrderDTO> getSearchStatusOrderHistory(Map<String, String> params) {
		return sqlSession.selectList("getSearchStatusOrderHistory", params);
	}

	public List<OrderDTO> getSearchPeriodOrderHistory(Map<String, String> params) {
		return sqlSession.selectList("getSearchPeriodOrderHistory", params);
	}

	public String getMenuName(String menuCode) {
		return sqlSession.selectOne("getMenuName", menuCode);
	}

	public List<OrderDTO> getDeliversHistory(Map<String, String> params) {
		return sqlSession.selectList("getDeliversHistory", params);
	}

	public List<OrderDTO> getSearchStatusDeliversHistory(Map<String, String> params) {
		return sqlSession.selectList("getSearchStatusDeliversHistory", params);
	}

	public List<OrderDTO> getSearchPeriodDeliversHistory(Map<String, String> params) {
		return sqlSession.selectList("getSearchPeriodDeliversHistory", params);
	}
	
	//s: 핑복코드 
	public List<OrderDTO> getOrderList(String userId){
	      return sqlSession.selectList("getOrderList", userId);
	   }
	
	public List<MenuDTO> top3MenuNames(List<String> top3MenuCodes) {
	//	System.out.println("top3MenuCodes:"+top3MenuCodes);
		return sqlSession.selectList("top3MenuNames", top3MenuCodes);
	}
	
	
	public List<MenuDTO> getLatestMenus() {
		return sqlSession.selectList("getLatestMenus");
	}
	
	//e:핑복코드

}
