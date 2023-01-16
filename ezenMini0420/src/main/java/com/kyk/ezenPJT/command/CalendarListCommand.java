package com.kyk.ezenPJT.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.FullCalendarDto;
import com.kyk.ezenPJT.util.Constant;

public class CalendarListCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		
		EzenDao edao = Constant.edao;
		
		String cId = request.getParameter("cId");
		
		ArrayList<FullCalendarDto> list = edao.calendarList(cId);
		
		model.addAttribute("calendarList", list);
	}

}
