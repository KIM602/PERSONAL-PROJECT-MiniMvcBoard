package com.kyk.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.RecipeDto;
import com.kyk.ezenPJT.util.Constant;

public class EzenRecipeDetailsCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		EzenDao edao = Constant.edao;
		String rId = request.getParameter("rId");
		int bId = Integer.parseInt(rId);
		System.out.println(bId);
		
		RecipeDto dto = edao.recipeDetails(bId);
		
		if(dto != null) {
			model.addAttribute("rDetails", dto);
		}
	}

}
