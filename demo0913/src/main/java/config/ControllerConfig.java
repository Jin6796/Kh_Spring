package config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.example.demo.controller.TestController;
import com.example.demo.logic.TestLogic;

@Configuration
public class ControllerConfig {
	Logger logger = LoggerFactory.getLogger(ControllerConfig.class);

	@Bean
	public TestController testCotnroller() {
		TestController testController = new TestController();
//		setter 객체주입법으로 처리하면 아래처럼!
//		그럼 만약 생성자 객체 주입법 코드를 사용하려면 어떻게 해야할까? 
//		 	>> 이종간의 연계에 있어서 필요한 조립기 역할이 추가되어야함.
		TestLogic testLogic = new TestLogic();
		testController.setTestLogic(testLogic);
		return testController;
	}
}
