package com.kyk.ezenPJT.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.EzenBoardDto;
import com.kyk.ezenPJT.util.Constant;

public class EzenBoardPageListCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		
		EzenDao edao = Constant.edao;
		String pageNo = request.getParameter("pageNo");
		ArrayList<EzenBoardDto> dtos = edao.pageList(pageNo);
		
		model.addAttribute("listContent", dtos);
	}

}
