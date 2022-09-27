package com.example.demo.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
// Getter/Setter를 작성하지 않아도 되는데.. 왜?왜? 난 왜 안돼?
@Data
//@Getter
//@Setter
public class MemberVO {
	private int    mem_no      = 0;
	private String mem_id      = null;
	private String mem_pw      = null;
	private String mem_name    = null;
	private String mem_zipcode = null;
	private String mem_address = null;
	// member 테이블에는 없는 컬럼이지만 업무 처리를 위해 필요한 변수 선언이 기능적으로 필요함.
	// 눈에 보이지 않는 컬럼과 변수를 찾아서 처리할 수 있어야 함.
	private int count = 0;
	
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pw() {
		return mem_pw;
	}
	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_zipcode() {
		return mem_zipcode;
	}
	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}
	public String getMem_address() {
		return mem_address;
	}
	public void setMem_address(String mem_address) {
		this.mem_address = mem_address;
	}
	public void setCount(int cnt) {
		// TODO Auto-generated method stub
		
	}
	public Object getCount() {
		// TODO Auto-generated method stub
		return null;
	}
}  
