package com.kyk.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.FullCalendarDto;
import com.kyk.ezenPJT.util.Constant;

public class CalendarUpdateCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		
		EzenDao edao = Constant.edao;
		
		FullCalendarDto dto = (FullCalendarDto)request.getAttribute("dto");
		
		edao.calendarUpdate(dto);
	}

}
