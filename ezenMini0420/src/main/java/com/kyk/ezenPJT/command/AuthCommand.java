package com.kyk.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.AuthUserDto;
import com.kyk.ezenPJT.util.Constant;

public class AuthCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		
		EzenDao edao = Constant.edao;
		
		AuthUserDto dto = (AuthUserDto)request.getAttribute("dto");
		
		edao.authDB(dto);
	}

}
