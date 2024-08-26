package com.project.javabucks.dto;

public class FrequencyDTO {

	private int frequencyNum;
	private String userId;
	private String frequencyRegDate;
	private int frequencyCount;
	private String frequencyEndDate;
	
	public int getFrequencyNum() {
		return frequencyNum;
	}
	public void setFrequencyNum(int frequencyNum) {
		this.frequencyNum = frequencyNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFrequencyRegDate() {
		return frequencyRegDate;
	}
	public void setFrequencyRegDate(String frequencyRegDate) {
		this.frequencyRegDate = frequencyRegDate;
	}
	public int getFrequencyCount() {
		return frequencyCount;
	}
	public void setFrequencyCount(int frequencyCount) {
		this.frequencyCount = frequencyCount;
	}
	
	// [채성진 작업] db값 담기위해 변수 frequencyEndDate 추가
	public String getFrequencyEndDate() {
		return frequencyEndDate;
	}
	public void setFrequencyEndDate(String frequencyEndDate) {
		this.frequencyEndDate = frequencyEndDate;
	}		
}
