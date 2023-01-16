package com.kyk.ezenPJT.dto;

import java.sql.Timestamp;

//캘린더 처리용 DTO
public class FullCalendarDto {
	private int cNo;
	private String cId;
	private String cTitle;
	private String cStart;
	private String cEnd;
	private Timestamp tStart;
	private Timestamp tEnd;
	private String cAllDay;
	
	public FullCalendarDto() {
		super();
	}
	
	public FullCalendarDto(int cNo, String cId, String cTitle, String cStart, String cEnd, Timestamp tStart,
			Timestamp tEnd, String cAllDay) {
		super();
		this.cNo = cNo;
		this.cId = cId;
		this.cTitle = cTitle;
		this.cStart = cStart;
		this.cEnd = cEnd;
		this.tStart = tStart;
		this.tEnd = tEnd;
		this.cAllDay = cAllDay;
	}
	
	public int getcNo() {
		return cNo;
	}
	public String getcId() {
		return cId;
	}
	public String getcTitle() {
		return cTitle;
	}
	public String getcStart() {
		return cStart;
	}
	public String getcEnd() {
		return cEnd;
	}
	public Timestamp gettStart() {
		return tStart;
	}
	public Timestamp gettEnd() {
		return tEnd;
	}
	public String getcAllDay() {
		return cAllDay;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public void setcId(String cId) {
		this.cId = cId;
	}
	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}
	public void setcStart(String cStart) {
		this.cStart = cStart;
	}
	public void setcEnd(String cEnd) {
		this.cEnd = cEnd;
	}
	public void settStart(Timestamp tStart) {
		this.tStart = tStart;
	}
	public void settEnd(Timestamp tEnd) {
		this.tEnd = tEnd;
	}
	public void setcAllDay(String cAllDay) {
		this.cAllDay = cAllDay;
	}
}
