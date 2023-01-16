package com.kyk.ezenPJT.dao;

import java.util.ArrayList;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kyk.ezenPJT.dto.AuthUserDto;
import com.kyk.ezenPJT.dto.DashBoardDto;
import com.kyk.ezenPJT.dto.EzenBoardDto;
import com.kyk.ezenPJT.dto.EzenJoinDto;
import com.kyk.ezenPJT.dto.FullCalendarDto;
import com.kyk.ezenPJT.dto.RecipeDto;

public class EzenDao implements iEzenDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String join(EzenJoinDto dto) {
		String result = null;
		
		try {
			int res = sqlSession.insert("join",dto);
			if(res>0) {
				result = "success";
			}
			else {
				result = "failed";
			}
			
		}
		catch (Exception e) {
			e.getMessage();
			result = "failed";
		}
		return result;
		
	}
	
	/* login 처리 */
	@Override
	public EzenJoinDto login(String pid) {
		System.out.println(pid);
		EzenJoinDto result = sqlSession.selectOne("login",pid);
		return result;
	}
	
	/* main의 recipe view */
	public ArrayList<RecipeDto> recipeList() {
		System.out.println("recipeList");
		ArrayList<RecipeDto> dtos = (ArrayList)sqlSession.selectList("recipeList");
		return dtos;
	}
	
	/* recipe에서 recipe등록 */
	@Override
	public String recipeWrite(RecipeDto dto) {
		System.out.println("recipeWrite");
		String result;
		int res = sqlSession.insert("recipeWrite", dto);
		if(res == 1) {
			result = "success";
		}
		else {
			result = "failed";
		}
		return result;
	}
	
	/* 레시피 상세보기 */
	@Override
	public RecipeDto recipeDetails(int rId) {
		System.out.println("recipeDetails");
		RecipeDto dto = sqlSession.selectOne("recipeDetails", rId);
		return dto;
	}
	
	/* authAdmin */
	@Override
	public String adminAuth(String pid, String pauth) {
		EzenJoinDto dto = new EzenJoinDto(pid, pauth);
		int res = sqlSession.update("adminAuth", dto);
		System.out.println("auth res " + res);
		if(res > 0) {
			return "success";
		}
		else {
			return "failed";
		}
	}
	
	/* EBoard list */
	@Override
	public ArrayList<EzenBoardDto> list() {
		ArrayList<EzenBoardDto> dtos = (ArrayList)sqlSession.selectList("list");
		return dtos;
	}
	
	/* EBoard page list */
	@Override
	public ArrayList<EzenBoardDto> pageList(String pageNo) {
		System.out.println("pageList");
		int page = Integer.parseInt(pageNo);
		int startNo = (page-1) * 10 + 1;
		System.out.println("statNo : " + startNo);
		ArrayList<EzenBoardDto> result = (ArrayList)sqlSession.selectList("pageList", startNo);
		
		return result;
	}

	/* Eboard write */
	@Override
	public void bWrite(String name, String title, String content) {
		EzenBoardDto dto = new EzenBoardDto(name,title,content);
		sqlSession.insert("bWrite", dto);
	}
	
	/* 게시판 내용 보기 */
	@Override
	public EzenBoardDto contentView(String bid) {
		int bId = Integer.parseInt(bid);
		upHit(bId);
		EzenBoardDto dto = sqlSession.selectOne("contentView", bId);
		return dto;
	}

	/* 히트수 올리기 */
	@Override
	public void upHit(int bId) {
		sqlSession.update("upHit", bId);
	}

	/* 게시판 수정 */
	@Override
	public void modify(EzenBoardDto dto) {
		sqlSession.update("modify",dto);
	}
	
	/* 게시판 삭제 */
	@Override
	public void delete(int bId) {
		int res = sqlSession.delete("delete", bId);
	}
	
	/* 댓글창 */
	@Override
	public EzenBoardDto replyView(int bId) {
		System.out.println("댓글창 보여주기");
		EzenBoardDto dto = sqlSession.selectOne("replyView", bId);
		return dto;
	}
	
	/* 댓글 내용 저장 */
	@Override
	public void reply(EzenBoardDto dto) {
		System.out.println("댓글내용 저장하기");
		int res = sqlSession.insert("reply", dto);
	}
	
	/* 댓글 모양 처리 */
	@Override
	public void replyShape(int bGroup, int bStep) {
		EzenBoardDto dto = new EzenBoardDto(bGroup, bStep);
		int res = sqlSession.update("replyShape", dto);
	}
	
	/* 캘린더 insert */
	@Override
	public void calendarInsert(FullCalendarDto dto) {
		System.out.println("캘린더 insert");
		int res = sqlSession.insert("calendarInsert", dto);
	}
	
	/* 캘린더 리스트 처리 */
	@Override
	public ArrayList<FullCalendarDto> calendarList(String cId) {
		System.out.println("캘린더 list DB처리");
		ArrayList<FullCalendarDto> list = (ArrayList)sqlSession.selectList("calendarList", cId);
		return list;
	}
	
	/* 캘린더 업데이트 처리 */
	@Override
	public void calendarUpdate(FullCalendarDto dto) {
		System.out.println("캘린더 update DB처리");
		int res = sqlSession.update("calendarUpdate", dto);
	}

	/* 캘린더 일정 삭제 처리 */
	@Override
	public void calendarDelete(FullCalendarDto dto) {
		System.out.println("캘린더 delete DB처리");
		int res = sqlSession.delete("calendarDelete", dto);
	}
	
	//dashboard
	@Override
	public ArrayList<DashBoardDto> dashBoardList() {
		System.out.println("dashboard DB처리");
		ArrayList<DashBoardDto> dtos =(ArrayList)sqlSession.selectList("dashBoardList");
	
		return dtos;
	}
	
	//Auth 처리
	@Override
	public void authDB(AuthUserDto dto) {
		System.out.println("Auth DB 처리");
		String authUsername = dto.getAuthUsername();
		AuthUserDto result = sqlSession.selectOne("authDB", authUsername);
		if(result == null) {
			authInsert(dto);
		}
	}
	
	@Override
	public void authInsert(AuthUserDto dto) {
		System.out.println("Auth DB insert 처리");
		int res = sqlSession.insert("authInsert", dto);
	}
	
	@Override
	public AuthUserDto authLogin(String username) {
		System.out.println("Auth DB 로그인 처리");
		AuthUserDto dto = sqlSession.selectOne("authLogin", username);
		return dto;
	}
}
