package com.project.javabucks.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.project.javabucks.dto.PayhistoryDTO;
import com.project.javabucks.dto.UserDTO;

@Service
public class UserMapper {

	@Autowired
	private SqlSession sqlSession;

	public int addNewCard(CardDTO dto) {
		return sqlSession.insert("addNewCard", dto);
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
	
	// 카드 충전 금액 증가
	public int plusCardPrice(Map<String, Object> params) {
		return sqlSession.update("plusCardPrice", params);
	}
	
	// 해당아이디로 등록된 알람 전체리스트(날짜순)
	public List<AlarmDTO> listGetAlarmById (String userId){
		return sqlSession.selectList("listGetAlarmById", userId);
	}
	// 알람 카테별 리스트(날짜순)
	public List<AlarmDTO> getAlarmsByCategory (String userId, String alarmCate){
		Map<String, String> params = new HashMap<>();
		params.put("userId", userId);
		params.put("alarmCate", alarmCate);
		return sqlSession.selectList("getAlarmsByCategory", params);
	}
	
	// 채성진 작업------------------------------------------------------
	public UserDTO getInfoById() {
		return sqlSession.selectOne("getInfoById");
	}
	
	public FrequencyDTO getFrequencyById() {		
		return sqlSession.selectOne("getFrequencyById");
	}
	
	public List<CouponListDTO> getCouponListById() {	
		return sqlSession.selectList("getCouponListById");
	}
	
	public List<BucksDTO> getStoreList(String storeSearch) {	
		return sqlSession.selectList("getStoreList", storeSearch);
	}
	
	public List<MenuDTO> getStoreDrinkList(String storeName) {	
		return sqlSession.selectList("getStoreDrinkList", storeName);
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
	
	public MenuOptShotDTO MyMenuNumByMenucode(String menuoptCode) {	
		return sqlSession.selectOne("MyMenuNumByMenucode", menuoptCode);
	}
	
	public int MyMenuDeleteByMenuNum(int mymenuNum) {
		return sqlSession.delete("MyMenuDeleteByMenuNum", mymenuNum);
	}
}
