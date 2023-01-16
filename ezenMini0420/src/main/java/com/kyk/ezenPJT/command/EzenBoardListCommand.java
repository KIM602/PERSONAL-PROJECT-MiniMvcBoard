package com.kyk.ezenPJT.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.EzenBoardDto;
import com.kyk.ezenPJT.util.Constant;

public class EzenBoardListCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		
		EzenDao edao = Constant.edao;
		ArrayList<EzenBoardDto> dtos = edao.list();
		//리턴된 jsp페이지에 dtos값 포함
		model.addAttribute("listContent", dtos);
	}

}
