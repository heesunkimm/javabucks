package com.project.javabucksStore.dto;
public class CouponListDTO {

   private int cpnListNum;
   private String cpnCode;
   private String userId;
   private String cpnListStatus;
   private String cpnListStartDate;
   private String cpnListEndDate;
   private String cpnListUseDate;
   
   
   public int getCpnListNum() {
      return cpnListNum;
   }
   public void setCpnListNum(int cpnListNum) {
      this.cpnListNum = cpnListNum;
   }
   public String getcpnCode() {
      return cpnCode;
   }
   public void setcpnCode(String cpnCode) {
      this.cpnCode = cpnCode;
   }
   public String getUserId() {
      return userId;
   }
   public void setUserId(String userId) {
      this.userId = userId;
   }
   public String getCpnListStatus() {
      return cpnListStatus;
   }
   public void setCpnListStatus(String cpnListStatus) {
      this.cpnListStatus = cpnListStatus;
   }
   public String getCpnListStartDate() {
      return cpnListStartDate;
   }
   public void setCpnListStartDate(String cpnListStartDate) {
      this.cpnListStartDate = cpnListStartDate;
   }
   public String getCpnListEndDate() {
      return cpnListEndDate;
   }
   public void setCpnListEndDate(String cpnListEndDate) {
      this.cpnListEndDate = cpnListEndDate;
   }
   public String getCpnListUseDate() {
      return cpnListUseDate;
   }
   public void setCpnListUseDate(String cpnListUseDate) {
      this.cpnListUseDate = cpnListUseDate;
   }
}