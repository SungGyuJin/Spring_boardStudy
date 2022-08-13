package com.myboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myboard.model.BoardVO;
import com.myboard.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	
	@Autowired
	private BoardService service;

	@GetMapping("/boardList")
	public void boardListGET(Model model) {
		
		System.out.println("목록 진입");
		
		model.addAttribute("list", service.boardList());
	}
	
	@GetMapping("/boardEnroll")
	public void boardEnroll() {
		
		System.out.println("등록 진입");
	}
	
	@PostMapping("/boardEnroll")
	public String boardEnrollPOST(BoardVO bvo, RedirectAttributes rttr) {
		
		log.info("BoardVO : " + bvo);
		
		service.boardEnroll(bvo);
		
		rttr.addFlashAttribute("result", "enroll success");
		
		return "redirect:/board/boardList";
	}
	
	
	
}
