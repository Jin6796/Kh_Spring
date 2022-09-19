package com.chap2;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.vo.DeptVO;

@Configuration
public class AppContext {
	// 메소드 이름 앞에 @Bean 어노테이션을 붙이면 메소드 이름이 빈네임이 되는 것!
	// 인스턴스변수.getBean(빈네임);
	// 빈 생성 객체를 인스턴스화 하면서 @Bean이 정의된 클래스를 생성자의 파라미터로 추가하는 것만으로도
	// @Bean이 붙은 메소드를 호출할 수 있다.
	// @Configuration과 @Bean은 직접적인 의존관계는 아님
	@Bean
	public DeptVO getDeptVO() {
		DeptVO dVO = new DeptVO();
		dVO.setDeptno(10);
		dVO.setDname("총무부");
		dVO.setLoc("대전");
		return dVO;
	}

}
