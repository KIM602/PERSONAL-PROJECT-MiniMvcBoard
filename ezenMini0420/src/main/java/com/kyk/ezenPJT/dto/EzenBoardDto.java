package com.kyk.ezenPJT.dto;

import java.sql.Timestamp;

//DB의 MVC_BOARD테이블과 매핑되는 DTO클래스
public class EzenBoardDto {
	private int bId; //오라클에서는 number, 다음엔 꼭.. 대문자로 쓰렴...
	private String bName; //varchar2
	private String bTitle;
	private String bContent;
	private Timestamp bDate; //oracle에서 DATE
	private int bHit; //db에서 정수 number
	private int bGroup;
	private int bStep;
	private int bIndent;
	
	public EzenBoardDto() {
		super();
	}
	
	public EzenBoardDto(String bName, String bTitle, String bContent) {
		super();
		this.bName = bName;
		this.bTitle = bTitle;
		this.bContent = bContent;
	}
	
	public EzenBoardDto(int bId, String bName, String bTitle, String bContent) {
		super();
		this.bId = bId;
		this.bName = bName;
		this.bTitle = bTitle;
		this.bContent = bContent;
	}
	
	public EzenBoardDto(int bId, String bName, String bTitle, String bContent, Timestamp bDate, int bHit, int bGroup,
			int bStep, int bIndent) {
		super();
		this.bId = bId;
		this.bName = bName;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bDate = bDate;
		this.bHit = bHit;
		this.bGroup = bGroup;
		this.bStep = bStep;
		this.bIndent = bIndent;
	}
	
	public EzenBoardDto(int bGroup, int bStep) {
		super();
		this.bGroup = bGroup;
		this.bStep = bStep;
	}
	
	public int getbId() {
		return bId;
	}
	public String getbName() {
		return bName;
	}
	public String getbTitle() {
		return bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public Timestamp getbDate() {
		return bDate;
	}
	public int getbHit() {
		return bHit;
	}
	public int getbGroup() {
		return bGroup;
	}
	public int getbStep() {
		return bStep;
	}
	public int getbIndent() {
		return bIndent;
	}
	public void setbId(int bId) {
		this.bId = bId;
	}
	public void setbName(String bName) {
		this.bName = bName;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public void setbDate(Timestamp bDate) {
		this.bDate = bDate;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public void setbGroup(int bGroup) {
		this.bGroup = bGroup;
	}
	public void setbStep(int bStep) {
		this.bStep = bStep;
	}
	public void setbIndent(int bIndent) {
		this.bIndent = bIndent;
	}
}
