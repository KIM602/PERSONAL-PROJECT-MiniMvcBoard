package com.kyk.ezenPJT.dto;

public class AuthUserDto {
	private String authUsername;
	private String authPw;
	private String auth;
	
	public AuthUserDto() {
		super();
	}
	
	public AuthUserDto(String authUsername, String authPw, String auth) {
		super();
		this.authUsername = authUsername;
		this.authPw = authPw;
		this.auth = auth;
	}
	
	public String getAuthUsername() {
		return authUsername;
	}
	public String getAuthPw() {
		return authPw;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuthUsername(String authUsername) {
		this.authUsername = authUsername;
	}
	public void setAuthPw(String authPw) {
		this.authPw = authPw;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	
}
