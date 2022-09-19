package com.chap2;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

// 나는 순수한 자바입니다.
// 어떤 추상 클래스나 어떤 인터페이스도 상속, implement 하지 않은 클래스
// 어떠한 메소드도 오버라이드 하지 않아도 된다.
public class Main {

   public static void main(String[] args) {
      AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(AppContext.class);
      DeptVO dVO = ctx.getBean("getDeptVO", DeptVO.class);
      int deptno = dVO.getDeptno();
      String dname = dVO.getLoc();
      String loc = dVO.getLoc();
      System.out.println(deptno + ", " + dname + ", " + loc);
      ctx.close();
   }

}