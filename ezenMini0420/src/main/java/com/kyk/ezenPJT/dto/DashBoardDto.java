package com.kyk.ezenPJT.dto;

import java.sql.Timestamp;

public class DashBoardDto {
	private String month;
	private int pcQty;
	private int monitorQty;
	private Timestamp regDate;
	
	public DashBoardDto() {
		super();	
	}

	public DashBoardDto(String month, int pcQty, int monitorQty, Timestamp regDate) {
		super();
		this.month = month;
		this.pcQty = pcQty;
		this.monitorQty = monitorQty;
		this.regDate = regDate;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public int getPcQty() {
		return pcQty;
	}

	public void setPcQty(int pcQty) {
		this.pcQty = pcQty;
	}

	public int getMonitorQty() {
		return monitorQty;
	}

	public void setMonitorQty(int monitorQty) {
		this.monitorQty = monitorQty;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
}
