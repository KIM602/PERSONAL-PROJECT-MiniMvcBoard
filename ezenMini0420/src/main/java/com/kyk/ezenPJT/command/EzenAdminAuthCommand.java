package com.kyk.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.util.Constant;

public class EzenAdminAuthCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		EzenDao edao = Constant.edao;
		String pid = request.getParameter("pid");
		String auth = request.getParameter("auth");
		
		System.out.println("pid auth " + pid + auth);
		String result = edao.adminAuth(pid, auth);
		
		model.addAttribute("result", result);
	}

}
