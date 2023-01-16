package com.kyk.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.EzenBoardDto;
import com.kyk.ezenPJT.util.Constant;

public class EzenBoardContentCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		
		EzenDao edao = Constant.edao;
		
		String bId = request.getParameter("bId");
		System.out.println("bId");
		
		EzenBoardDto dto = edao.contentView(bId);
		
		if(dto != null) {
			model.addAttribute("contentView", dto);
		}
	}

}
