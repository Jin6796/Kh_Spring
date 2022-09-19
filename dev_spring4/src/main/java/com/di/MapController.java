package com.di;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

public class MapController extends AbstractController {
	Logger logger = Logger.getLogger(MapController.class);
	// spring-servlet.xml에 선언된 bean[MapController] 태그 안에 정의된
	private Map<String, String> insaMsg = null; // 주입받고 싶어요. 누가(스프링에서 필요할 때 - 게으른[BeanFactory], 이른[

	// setter메소드는 setter 객체주입법 코드!
	// 그 객체는 어디있다고? >>> spring-servlet.xml Map
	public void setInsaMsg(Map<String, String> insaMsg) {
		this.insaMsg = insaMsg;
	}

	// spring-servlet.xml에 선언된 bean[MapController]에 선언된 
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest req, HttpServletResponse res) throws Exception {
		logger.info("handleRequestInternal ==> " + insaMsg);
		return null;
	}

}
