package com.example.demo.khTest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

public class Controller {
	@Autowired
	BoardService boardService;
	
	@RequestMapping("bdetail.do")
	public String selectBoard(Model model, @RequestParam("bId") int bId) {
		Board board = null;
		board = boardService.selectBoard(bId);
		if(board != null) {
			model.addAttribute("board", board);
			return "boardDetail";
		} else {
			return "redirect:error.do";
			}
	}
}

