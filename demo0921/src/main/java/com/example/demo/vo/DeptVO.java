package com.example.demo.vo;

import org.apache.logging.log4j.message.Message;

import lombok.Data;
// getter,setter을 대신한 어노테이션. 
// '생성자'를 대신할 수 있는 어노테이션은? @Builder
@Data 
public class DeptVO {
	private int deptno;
	private String dname;
	private String loc;
	public Message getDeptno() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
