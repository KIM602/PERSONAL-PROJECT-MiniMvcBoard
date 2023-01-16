package com.kyk.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.RecipeDto;
import com.kyk.ezenPJT.util.Constant;

public class EzenRecipeWriteCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		EzenDao edao = Constant.edao;
		RecipeDto dto = (RecipeDto)request.getAttribute("rdto");
		String result = edao.recipeWrite(dto);
		model.addAttribute("result", result);
	}

}
