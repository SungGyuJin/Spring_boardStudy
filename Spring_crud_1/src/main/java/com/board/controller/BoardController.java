package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.board.service.BoardService;

@Controller
@RequestMapping("/bvo")
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	// 목록
	@GetMapping("/listPage")
	public void listGET(Model model) {
	
		model.addAttribute("list", bService.listBoard());
		
	}
	
	// 상세목록페이지
	@GetMapping("/detailPage")
	public void modifyMoveGET(int bno, Model model) {
		
		model.addAttribute("list", bService.detailBoard(bno));
	}
	
	
	
	
}
