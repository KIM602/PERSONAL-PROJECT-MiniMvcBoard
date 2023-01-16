package com.kyk.ezenPJT.dto;

public class RecipeDto {
	private int rId;
	private String rClass;
	private String rtrName;
	private String rTitle;
	private String rPhoto;
	private String rContent;
	
	public RecipeDto() {
		super();
	}

	public RecipeDto(int rId, String rClass, String rtrName, String rTitle, String rPhoto, String rContent) {
		super();
		this.rId = rId;
		this.rClass = rClass;
		this.rtrName = rtrName;
		this.rTitle = rTitle;
		this.rPhoto = rPhoto;
		this.rContent = rContent;
	}

	public int getrId() {
		return rId;
	}

	public String getrClass() {
		return rClass;
	}

	public String getRtrName() {
		return rtrName;
	}

	public String getrTitle() {
		return rTitle;
	}

	public String getrPhoto() {
		return rPhoto;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}

	public void setrClass(String rClass) {
		this.rClass = rClass;
	}

	public void setRtrName(String rtrName) {
		this.rtrName = rtrName;
	}

	public void setrTitle(String rTitle) {
		this.rTitle = rTitle;
	}

	public void setrPhoto(String rPhoto) {
		this.rPhoto = rPhoto;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
}
