package com.kyk.ezenPJT.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.DashBoardDto;
import com.kyk.ezenPJT.util.Constant;

public class DashBoardCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {

			EzenDao edao = Constant.edao;
			
			ArrayList<DashBoardDto> dtos = edao.dashBoardList();
			
			model.addAttribute("dashArray", dtos); 
			//map형식으로 저장됨, key가 dashArray , value가 dtos
		}
	}
