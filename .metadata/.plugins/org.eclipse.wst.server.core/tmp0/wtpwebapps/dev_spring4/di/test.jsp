<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
// 디클러레이션 - 여기에 클래스나 메소드를 선언한다.
// test_jsp.java - 클래스 이름도 바뀌었잖아.
// 프로젝트를 배포하는 서버마다 클래스 이름의 명명 규칙이 다르다.
// 우리가 인스턴스화 한다? > 난 코린이인데 ㅠㅡㅠ 살려주삼.....
// 넌 인스턴스화 하지 마삼. - 메모리 관리 책임은 스프링이 책임진다잇!
// 자원관리를 프레임워크에게 맡긴다.
// 클래스 이름은 누가 결정해야 할까요? - 업무를 구현할 개발자가 결정~!
// 제어 역전이다. (IoC)
// 단독으로 인스턴스화 불가능
	class Sonata{
	
	}
%>
<%
	Sonata myCar = new Sonata(); // scope를 줄 수가 없잖아요!!!!!!!!!!!!!!!!!!
	out.print(myCar);
	// 로컬 PC
	// 웹 서버 (Web Application Server <--> Web Server(정적페이지))
	// 유지 - scope(page|request|session|application)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- xml문법: jsp-namespace 
프레임워크에 대한 환경 설정은 xml로 처리한다. (spring2.5)
myBatis+Java 연계
myBatis+servlet 연계 (연동)
myBatis+spring 연계 (연동)

ORM 솔루션 - JDO, myBatis, Hibernate

이종 간에 연동(연계, 결합, 인터페이스)
인스턴스화 - 객체주입(클래스분할 - 리액트) - myBatis-3.5.10.jar(클래스)
xml끼리(xml내부에서 클래스간의 객체 주입이 되어야한다.)

JAVA - JAVA 는 안되남? 
: 컴파일 - 서버를 내렸다 추가하고 서버를 기동한다.

useBean태그로 객체를 선언하는 것은 재사용이 어렵다. 
: test$Sonata.class
앞에 jsp의 이름에 대한 클래스 이름이 서버 제품마다 다르다(명명규칙이 다르기 때문에)

spring 창시자
클래스 명은 개발자가 결정하는 데 사용은 여러 개발자가 공유해야 함. 
동시 접속자도 많고 불특정 다수가 시도때도 없이 사용함.
자원관리를 시스템에서 맡아주는 게 효과적이지 않나?
제어역전 가져왔따. - 스프링은....
spring-core.jar ==> ApplicationContext, BeanFactory(빈을 관리한다) - 
단, 대신 클래스에 대한 등록은 개발자인 너가 해주세요 - 너는 업무 담당자니까!

BeanFactory
객체를 관리하는 고급 설정 기법 제공
org.springframework.beans 내에 속함
보든 Bean을 늦게 로딩(Lazy loading)함

ApplicationContext
BeanFactory에 모든 기능을 제공함.
Spring의 AOP기능 제공
메세지 지원 핸들링, 이벤트 위임
org.springframework.context에 속함
Context를 시작시킬 때 모든 SingleTon Bean을 미리 로딩함으로써 그 Bean이 필요할 때 즉시 사용될 수 있도록 보장해줌
애플리케이션 동작 시 Bean이 생성되기를 기다릴 필요가 없게 됨
-->
<jsp:useBean id="himCar" scope="request" class="com.spring4.mvc.Sonata" />
</body>
</html>