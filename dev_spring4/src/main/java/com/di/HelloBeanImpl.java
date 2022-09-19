package com.di;

public class HelloBeanImpl implements HelloBean {
	
	String msg = null;
	
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	@Override
	public String getGreeting(String msg) {
		// this.msg가 아닌 msg를 출력하면 xml 입력값이 아닌 HelloMain 입력값이 출력된다.
		// this 를 넣으면 helloBean.xml에 있는 bean(class)의 property 값을 받아옴
		return "Spring!!! " + this.msg;
	}

}
