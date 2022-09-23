package com.example.demo.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.logic.MemoLogic;

@Controller
@RequestMapping("/memo/*")
public class MemoController {
	Logger logger = LoggerFactory.getLogger(MemoController.class);
	
	@Autowired(required=false)
	private MemoLogic memoLogic = null;
	
	@GetMapping("memoInsert")
	public String memberInsert(@RequestParam Map<String,Object> pMap) {
		logger.info("memoInsert 호출 성공: " + pMap);
		return "redirect:/auth/index.jsp";
	}
}