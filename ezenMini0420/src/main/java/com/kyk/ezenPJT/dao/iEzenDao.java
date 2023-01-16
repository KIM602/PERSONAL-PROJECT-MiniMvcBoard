package com.kyk.ezenPJT.dao;

import java.util.ArrayList;

import com.kyk.ezenPJT.dto.AuthUserDto;
import com.kyk.ezenPJT.dto.DashBoardDto;
import com.kyk.ezenPJT.dto.EzenBoardDto;
import com.kyk.ezenPJT.dto.EzenJoinDto;
import com.kyk.ezenPJT.dto.FullCalendarDto;
import com.kyk.ezenPJT.dto.RecipeDto;

public interface iEzenDao {
	//추상메서드
	public String join(EzenJoinDto dto);
	public EzenJoinDto login(String pid);
	public ArrayList<RecipeDto> recipeList();
	public String recipeWrite(RecipeDto dto);
	public RecipeDto recipeDetails(int rId);
	public String adminAuth(String pid, String pauth);
	public ArrayList<EzenBoardDto> list();
	public ArrayList<EzenBoardDto> pageList(String pageNo);
	public void bWrite(String name, String title, String content);
	public EzenBoardDto contentView(String bid);
	public void upHit(int bId);
	public void modify(EzenBoardDto dto);
	public void delete(int bId);
	public EzenBoardDto replyView(int bId);
	public void reply(EzenBoardDto dto);
	public void replyShape(int bGroup, int bStep);
	public void calendarInsert(FullCalendarDto dto);
	public ArrayList<FullCalendarDto> calendarList(String cId);
	public void calendarUpdate(FullCalendarDto dto);
	public void calendarDelete(FullCalendarDto dto);
	public ArrayList<DashBoardDto> dashBoardList();
	public void authDB(AuthUserDto dto);
	public void authInsert(AuthUserDto dto);
	public AuthUserDto authLogin(String username);
 }
