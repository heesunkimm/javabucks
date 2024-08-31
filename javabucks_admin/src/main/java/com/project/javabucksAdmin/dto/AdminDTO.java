package com.project.javabucksAdmin.dto;

public class AdminDTO {

	private String adminId;
	private String adminPasswd;
	private String adminEmail;
	private String adminAuthority;
	private String adminJoindate;
	private String adminEnable; 
	

	public String getAdminEmail() {
		return adminEmail;
	}

	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getAdminPasswd() {
		return adminPasswd;
	}

	public void setAdminPasswd(String adminPasswd) {
		this.adminPasswd = adminPasswd;
	}

	public String getAdminAuthority() {
		return adminAuthority;
	}

	public void setAdminAuthority(String adminAuthority) {
		this.adminAuthority = adminAuthority;
	}

	public String getAdminJoindate() {
		return adminJoindate;
	}

	public void setAdminJoindate(String adminJoindate) {
		this.adminJoindate = adminJoindate;
	}

	public String getAdminEnable() {
		return adminEnable;
	}

	public void setAdminEnable(String adminEnable) {
		this.adminEnable = adminEnable;
	}

}
