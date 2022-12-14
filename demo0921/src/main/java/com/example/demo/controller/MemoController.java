package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	// 컨트롤 계층에서는 Model과 @RequestParam을 지원받고 있다. - 컨트롤 클래스가 필요한가?
	// 역할은 무엇을 주어야하나?
	// 스프링에서는 객체주입으로 지원하고 있으니까 개발자가 따로 고민하지 않아도 됨.
	// POJO vs SPRING(획일적 구조를 가져감 - 추가기능이 생겨도 대응하기 좋음, 업무에 대한 depth가 달라서 다른 팀 지원을 나간다?)
	// xml방식으로의 설정과 (* 메소드의 파라미터로 주입을 바든 대신 xml문서에 정의된 객체를 주입받는 방식)
	// 어노테이션 방식으로의 설정 (* 자바코드, 파라미터에도 어노테이션을 지원함) 차이점에 대해 말할 수 있다.
	// 인스턴스화 없이 사용할 수 있다. 직접 new A()하지 않는다. 생성자를 직접 호출하지 않는다. 초기화도 직접 안하고~! 자원반납도 직접 하지 않아도 된다.
	// * 동시 접속사가 많은 경우 메모리 관리 어떻게?
	// 컨트롤 클래스 > 로직클래스 > 다오클래스 > 화면이 다르면 로직과 다오는 재사용하더라도 컨트롤은 분리하는 것이 유지보수에 유리.
	
	@GetMapping("memoContent")
	public String memoContent(Model model, @RequestParam Map<String,Object> pMap) {
		Map<String,Object> rMap = null;
		rMap = memoLogic.memoContent(pMap);
		model.addAttribute("rMap", rMap);
		return "forward:/memo/memoContent.jsp";
	}
	
	@GetMapping("memoInsert")
	public String memoInsert(@RequestParam Map<String,Object> pMap) {
		logger.info("memoInsert 호출 성공: " + pMap);
		int result = 0;
		result = memoLogic.memoInsert(pMap);
		return "redirect:/auth/index.jsp";
	}
	
	@GetMapping("sendMemoList")
	public String sendMemoList(Model model, @RequestParam Map<String,Object> pMap) {
		List<Map<String,Object>> sendMemoList = null;
		sendMemoList = memoLogic.sendMemoList(pMap);
		model.addAttribute("sendMemoList", sendMemoList);
	    // @RestController, @ResponseBody의 차이?
		return "forward:/memo/jsonSendMemoList.jsp";
	}
	
	@GetMapping("receiveMemoList")
	public String receiveMemoList(HttpSession session,Model model, @RequestParam Map<String,Object> pMap) {
		List<Map<String,Object>> receiveMemoList = null;
		receiveMemoList = memoLogic.receiveMemoList(pMap, session);
		model.addAttribute("receiveMemoList", receiveMemoList);
		return "forward:/memo/jsonReceiveMemoList.jsp";
	}	
}
