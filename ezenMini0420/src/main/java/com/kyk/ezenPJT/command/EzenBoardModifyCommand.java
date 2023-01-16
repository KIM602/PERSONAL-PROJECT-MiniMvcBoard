package com.kyk.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.EzenBoardDto;
import com.kyk.ezenPJT.util.Constant;

public class EzenBoardModifyCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		EzenDao edao = Constant.edao;
		
		int bId = Integer.parseInt(request.getParameter("bId"));
		String bName = request.getParameter("bName");
		String bTitle = request.getParameter("bTitle");
		String bContent = request.getParameter("bContent");
		
		EzenBoardDto dto = new EzenBoardDto(bId, bName, bTitle, bContent);
		
		edao.modify(dto);
	}

}
