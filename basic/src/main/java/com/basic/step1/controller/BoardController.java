package com.basic.step1.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.basic.step1.logic.BoardLogic;
import com.util.HangulConversion;
import com.util.HashMapBinder;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	// @Autowired(required = false) ==> 저는 이거 추가 되어있는데 한 번 확인해보셔요!! 제가 틀릴 수도,,
	private BoardLogic boardLogic = null;

	/*
	 * dev_web과 basic 비용 계산 해보기 Map 선언만 함 - @RequestParam HashMapBinder가 필요없어짐
	 * ModelAndView도 필요 없음 - Model로 대체 리턴타입 : ModelAndView -> String
	 */
	@GetMapping("boardList.sp4")
	public String boardList(Model model) {
		logger.info("boardList 호출 성공");
		List<Map<String, Object>> boardList = null;
		boardList = boardLogic.boardList(null); // 저는 여기 null이 아니라 pMap인데 같이 확인해봐요!!
		model.addAttribute("boardList", boardList);
		return "forward:boardList.jsp";
	}

	// 경진님 저는 왜 insert가 하나에 그 안에 file 업로드 되어있을까여?
	@GetMapping("boardInsert.sp4")
	public String boardInsert(@RequestParam Map<String, Object> pMap,
			@RequestParam(value = "bs_file", required = false) MultipartFile bs_file) {
		logger.info("boardInsert 호출 성공");
		int result = 0;
		result = boardLogic.boardInsert(pMap);
		return "redirect:boardList.sp4";
	}

	@GetMapping("boardUpdate.sp4")
	public Object boardUpdate(@RequestParam Map<String, Object> pMap) {
		logger.info("boardUpdate 호출 성공");
		int result = 0;
		result = boardLogic.boardUpdate(pMap);
		// jsp에서 시작해서 action으로!(for update) 그 다음 action에서 (select) >>>>>(forward)>>>>> boardList.jsp
		return "redirect:boardList.sp4";
	}

	@GetMapping("boardDetail.sp4")
	public String boardDetail(Model model, @RequestParam Map<String,Object> pMap) {
		logger.info("boardDetail 호출 성공"); 
		List<Map<String,Object>> boardList = null;
		boardList = boardLogic.boardDetail(pMap); 
		model.addAttribute("boardList", boardList);
		return "forward:read.jsp";
	}
	
	@GetMapping("boardDelete.sp4")
	public Object boardDelete(@RequestParam Map<String,Object> pMap) {
		logger.info("boardDelete 호출 성공");
		int result = 0;
		result = boardLogic.boardDelete(pMap);
		// jsp에서 시작해서 action으로!(for update) 그 다음 action에서 (select) >>>>>(forward)>>>>> boardList.jsp
		return "redirect:boardList.sp4";
	}
	
	@PostMapping("boardInsert.sp4")
	public String boardInsert(MultipartHttpServletRequest mpRequest, @RequestParam(value = "bs_file", required = false) MultipartFile bs_file) {
		logger.info("boardInsert 호출 성공");
		int result = 0;
		Map<String, Object> pMap = new HashMap<>();
		HashMapBinder hmb = new HashMapBinder(mpRequest);
		hmb.mbind(pMap);
		if(!bs_file.isEmpty()) {
			String filename= HangulConversion.toUTF(bs_file.getOriginalFilename());
			String savePath = "C:\\workspace_spring\\basic\\src\\main\\webapp\\pds";
			// 파일 풀 네임 담기
			String fullPath = savePath+"\\"+filename;
			try {
				// File객체는 파일 명을 객체화 해줌
				File file = new File(fullPath);
				// board_sub_t에 파일크기를 담기 위해
				byte[] bytes = bs_file.getBytes();
				BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(file));
				// 실제로 파일 내용이 채워짐
				bos.write(bytes);
				bos.close();
				long size = file.length();
				double d_size = Math.floor(size/1024.0); //kb
				logger.info("size: "+d_size);
				pMap.put("bs_file", filename);
				pMap.put("bs_size", d_size);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		result = boardLogic.boardInsert(pMap);
		return "redirect:boardList.sp4";
	}
}
