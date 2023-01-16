package com.kyk.ezenPJT.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kyk.ezenPJT.dao.EzenDao;
import com.kyk.ezenPJT.dto.RecipeDto;
import com.kyk.ezenPJT.util.Constant;

public class EzenRecipeCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		EzenDao edao = Constant.edao;
		ArrayList<RecipeDto> dtos = edao.recipeList();
		model.addAttribute("recipeList", dtos);
	}

}
