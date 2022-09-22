<%
// 확장자를 jsp로 해야 스크립틀릿 사용이 가능함
// JSP = html+CSS+JS(브라우저-인터프리터-로컬-다운로드)+JAVA (백엔드-서버가 주체-서버측에서 처리된 결과가 다운로드됨)
// 왜 중요하냐 이게? > 시간차 때문에! (인스턴스화 - 위치 - 싱글톤패턴 - 서블릿 싱글톤 관리)
// 서블릿의 라이프 사이클 - 스레드로 관리 > 관리되는 주체: 객체(서블릿)
// 왜 서블릿이어야 하지? >> 서블릿이어야 웹서비스가 가능하니께~
//		                       웹서비스는 요청으로 시작해서 응답으로 끝나는 것 (요청을 위해 요청객체와 응답객체에 대한 객체 주입이 필요하다.)
//                                                                누가? 톰캣이! 누구에게? 요청자에게!
//		 												요청방식: GET/POST
//		 												서비스를 제공하는 백엔드 단에서 전송방식에 매칭되는 메소드가 필요하다 (doGet, doPost)
// a.jsp -> a_jsp.java -> a_jsp.class -> 브라우저 쓰기
//     jsp 컨테이너(엔진), servlet-api.jar(서블릿 엔진)
// init() - service() - destroy()  
// >> 개발자는? init() - service(req,res) / doGet,doPost(구분 가능) - destroy()
// 톰캣 서버가 init()과 destroy()까지는 책임을 진다 - 개발자 책임이 아님
// 프로젝트 이름마다 경로가 다를 수 있다.
// 매번 그 때마다 경로를 수정한다?? 우웩
// WAS에서 관리하는 server.xml문서에서 Context에 정보를 가져오는 메소드 호출!
    StringBuilder path = new StringBuilder(request.getContextPath());
    path.append("/");
%>   
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>demo/demo.css">
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/icon.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>