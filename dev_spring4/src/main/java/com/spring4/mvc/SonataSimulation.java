package com.spring4.mvc;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
// ApplicationContext 대 BeanFactory => 컨테이너의 종류
// 빈을 관리해준다. > 어떻게? 이른/게으른 인스턴스화

public class SonataSimulation {
   // 아래 두 인스턴스화의 차이는?
   
   // 게으른 인스턴스화 (왜 게으르죠? ==> 
//   Sonata myCar = null; // 언제 초기화가 되나요? ==> 
   
   // 이른 인스턴스화
//   Sonata herCar = new Sonata();
   
   // 메소드 선언
   void methodA() {
//      System.out.println(herCar.speed);
//      myCar = new Sonata();
//      System.out.println(myCar.speed);
   }
   
   // 메인 메소드
   public static void main(String[] args) {
      SonataSimulation ss = new SonataSimulation();
//      ss.methodA();
//      스프링에서는 xml문서에 선언된 클래스 정보를 얻어와서 자바코드에 쓸 수 있도록 제공하는 클래스가 있다. -- (ClassPathXmlApplicationContext)
      ApplicationContext context = new ClassPathXmlApplicationContext("com\\spring4\\mvc\\sonataBean.xml");
      Sonata myCar  = (Sonata)context.getBean("myCar");
      Sonata herCar = (Sonata)context.getBean("herCar"); // 인스턴스화
//      생성자가 여러개일 땐 어떤게 호출이 되는 겨?
      System.out.println(herCar.speed);     // 0
      System.out.println(herCar.carName);   // null
      System.out.println(herCar.carColor);  // null
      System.out.println(myCar);
      System.out.println(myCar.speed);
      System.out.println(myCar.carName);
      System.out.println("객체관리 책임이 개발자에게 있는 경우.");
      
      myCar = new Sonata();
      System.out.println(myCar);
      System.out.println(myCar.speed);
      System.out.println(myCar.carName);
      
      myCar = null; // 여기 null 처리에서 두줄 밑으로 갈 떄, Candidate 상태에 빠진다. (null 처리 후, 새로운 인스턴스화 할 때)
      // 41번에 생성된 객체는 쓰레기 값으로 인식되어 자원을 회수 당하게 된다. ﻿→ 그시점이 인스턴스화하고 null로 하고 새로운 인스턴스화하기 직전의 상태 때!
      myCar = new Sonata(); // NullpointerException 안당하려면 인스턴스화
      System.out.println("null 초기화 후 비교" + myCar);
      System.out.println(myCar.speed);
      System.out.println(myCar.carName);

   }

}