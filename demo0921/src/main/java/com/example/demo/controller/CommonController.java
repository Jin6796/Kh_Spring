package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.logic.CommonLogic;
import com.google.gson.Gson;

@Controller // JSON 포맷..
public class CommonController {
	Logger logger = LogManager.getLogger(CommonController.class);
   
   	@Autowired(required=true)
	private CommonLogic commonLogic = null;
   
   	@GetMapping("/zipcode/zipcodeList") 
   	public String zipcodeList(@RequestParam String dong, Model model) { // JSON 방식으로 받을거야 ! 
   		logger.info("zipcodeList 호출 성공");
   		List<Map<String,Object>> zipList = null;
   		zipList = commonLogic.zipcodeList(dong);
   		model.addAttribute("zipList", zipList);
   		return "forward:/auth/zipcodeList.jsp"; 
   	}

   	@ResponseBody
	@GetMapping("/zipcode/jsonZipcodeList")
	public String jsonZipcodeList(@RequestParam String dong) { // JSON 방식으로 받을거야 !
	   	logger.info("zipcodeList 호출 성공");
		List<Map<String,Object>> zipList = null;
		zipList = commonLogic.zipcodeList(dong);
		Gson g = new Gson();
		String imsi = g.toJson(null);
		return imsi;
    }
   }