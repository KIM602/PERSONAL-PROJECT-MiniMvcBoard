package com.kyk.ezenPJT.dto;

import java.sql.Timestamp;

public class EzenJoinDto {
	private String pid;
	private String ppw;
	private String paddress;
	private String phobby;
	private String pprofile;
	private Timestamp pdate;
	private String pauth;
	
	public EzenJoinDto() {
		super();
	}

	public EzenJoinDto(String pid, String pauth) {
		super();
		this.pid = pid;
		this.pauth = pauth;
	}
	
	public EzenJoinDto(String pid, String ppw, String paddress, String phobby, String pprofile, Timestamp pdate,
			String pauth) {
		super();
		this.pid = pid;
		this.ppw = ppw;
		this.paddress = paddress;
		this.phobby = phobby;
		this.pprofile = pprofile;
		this.pdate = pdate;
		this.pauth = pauth;
	}

	public String getPid() {
		return pid;
	}

	public String getPpw() {
		return ppw;
	}

	public String getPaddress() {
		return paddress;
	}

	public String getPhobby() {
		return phobby;
	}

	public String getPprofile() {
		return pprofile;
	}

	public Timestamp getPdate() {
		return pdate;
	}

	public String getPauth() {
		return pauth;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public void setPpw(String ppw) {
		this.ppw = ppw;
	}

	public void setPaddress(String paddress) {
		this.paddress = paddress;
	}

	public void setPhobby(String phobby) {
		this.phobby = phobby;
	}

	public void setPprofile(String pprofile) {
		this.pprofile = pprofile;
	}

	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}

	public void setPauth(String pauth) {
		this.pauth = pauth;
	}

	
}