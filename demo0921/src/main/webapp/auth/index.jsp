<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.vo.MemberVO" %>
<%
	MemberVO mVO = (MemberVO)session.getAttribute("mVO");
	String s_id   = null;
	String s_name = null;
	
	if(mVO!=null) {
	s_id   = mVO.getMem_id();
	s_name = mVO.getMem_name();
	out.print("회원입니다. [회원 아이디: " + s_id+"], [회원 이름: "+s_name+"]"); // 처음에는 null, null이 찍힐 듯
	} else {
		out.print("비회원입니다.");
	}
//	out.print("위치 어디야?");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>인증처리 - 쿠키와 세션</title>
<%@include file="../common/easyui_common.jsp" %>
<style type="text/css">
	a {
		text-decoration: none;
		color: black;
	}
</style>
<script type="text/javascript">
// 함수 선언은 head 태그 안에서!!!
// easyui_common.jsp
	function login(){
		const tb_id = $("#mem_id").val();
		const tb_pw = $("#mem_pw").val();			
		location.href="./login.pj?mem_id="+tb_id+"&mem_pw="+tb_pw;
	}
	function logout(){ // 로그아웃
		location.href="./logout.jsp";
	}
	// 순서 지향적인, 절차 지향적인 코딩을 전개 하는 데에서 모듈화 해 나가는 것, 비동기 처리하는 연습(await/async)
	function memberList(){ // 회원목록
        alert($("#_easyui_textbox_input4").val());
	
        let type = null;
        let keyword = null;

        if($("#_easyui_textbox_input4").val()!=null && $("#_easyui_textbox_input4").val()) {
            type = "mem_id";
            keyword = $("#_easyui_textbox_input4").val();
        }
        else if($("#_easyui_textbox_input5").val()!=null && $("#_easyui_textbox_input5").val()) {
            type = "mem_name";
            keyword = $("#_easyui_textbox_input5").val();
        }

//		alert("회원목록 호출 성공");
		// 아래 코드는 클라이언트 측에 같이 다운로드가 완료된 상태에서 처리된다. - 결정이 되었다.
		
		// 시점 문제 유의하자
		// jeasyUI datagrid에서도 get/post방식을 지원함
		$("#dg_member").datagrid({
			// 오라클 서버에서 요청한 결과를 myBatis를 사용하면 자동으로 컬럼명이 대문자! 단, List<XXVO>형태라면 그땐 소문자가 맞다.
			method:"get"
		// url 속성에 XXX.jsp가 오면 표준 서블릿인 HttpServlet이 관여하는 것이고 XXX.pj로 요청하면 ActionSupport가 관여하는 것
			,url: "/member/memberList.pj?type="+type+"&keyword="+keyword // JSON으로 전달하는 페이지가 조립이 되어야 한다. (응답페이지는 html이 아니라 JSON포맷의 파일이어야 한다.)
			,onDblClickCell: function(index,field,value){
				console.log(index + ", " + field + ", " + value);
				if("BUTTON" == field){
					alert("쪽지쓰기 클릭");
				}
			}
		});	
        $("#d_member").show();
		$("#d_memberInsert").hide();
	}
	function memberInsert(){ // 회원등록
		alert("회원등록 호출 성공");
		$("#d_member").hide();
		$("#d_memberInsert").show();
	}
	function memberDelete(){ // 회원삭제
		alert("회원삭제 호출 성공");
	}
</script>
</head>
<body>
	<script>
	// DOM트리가 다 그려진건가?
	// DOM트리가 다 그려졌을 때(준비되었을 때) - 메소드 이름도 ready !!
	$(document).ready(function(){

		$("#d_member").hide();
		$("#d_memberInsert").hide();

/* 
		$("#dg_memberInsert").datagrid({
			
		});
*/
	});
	</script>
	<div style="margin: 20px 0;"></div>
	<div class="easyui-layout" style="width: 1000px; height: 500px;">
		<div data-options="region:'south',split:true" style="height: 50px;"></div>
	    <div data-options="region:'west',split:true" title="KH정보교육원"
	         style="width: 200px;">
	                 
      		<div style="margin: 10px 0;"></div> <!-- 여백 -->
     
<%
//	String s_name = (String)session.getAttribute("s_name");
	//s_name = "이순신";
	if(s_name ==null){
%>
<!-- ######################## 로그인 영역 ################### -->      
      <div id="d_login" align="center">
      <div style="margin: 3px 0;"></div>
      <input id="mem_id" name ="mem_id" class="easyui-textbox"/>
      <script type="text/javascript">
         $("#mem_id").textbox({
            iconCls:'icon-man',
            iconAlign: 'right',
            prompt: '아이디'
         });
      </script>
      <div style="margin: 3px 0;"></div>
      <input id="mem_pw" name ="mem_pw" class="easyui-psswardbox"/>
      <script type="text/javascript">
         $("#mem_pw").passwordbox({
            iconAlign: 'right',
            prompt: '비밀번호'
         });
      </script>
      <div style="margin: 3px 0;"></div>
         <a id="btn_login" href="javascript:login()" class="easyui-linkbutton" data-options="iconCls:'icon-man'">
            로그인
         </a>
         <a id="btn_member" href="javascript:memberShip()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">
            회원가입
         </a>
      </div>   
<!-- ######################## 로그인 영역 끝 ##################### -->

<!-- 안했네 -->
<%
	}else {
%>
<!-- ######################## 로그아웃 영역 ################### -->   
      <div id="d_logout" align="center">
         <div id="d_ok"><%=s_name%>님 환영합니다.</div>
         <div style="margin:3px 0"></div>
         <a id="btn_login" href="javascript:logout()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">
            로그아웃
         </a>
         <a id="btn_member" href="javascript:memberUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">
            정보수정
         </a>
      </div>
<!-- ######################## 로그아웃 영역 끝 ##################### -->
<%
	} // end of else
%>
<!-- ######################## 메뉴 영역 시작  ##################### -->
	  <div style="margin:20px 0;"></div>
<%
if (mVO!=null){
%>
	        <ul id="tre_gym" class="easyui-tree">
	            <li data-options="state:'closed'">
	                <span>회원 관리</span>
	                <ul class ="member">
	                    <li>
	                        <a href="javascript:memberList()">회원목록</a>
	                    </li>
	                    <li>
	                        <a href="javascript:memberInsert()">회원등록</a>
	                    </li>
	                    <li>
	                        <a href="javascript:memberDelete()">회원삭제</a>
	                    </li>
	                </ul>
	            </li>
	            
	             <li data-options="state:'closed'">
	                <span>쪽지 관리</span>
	                <ul>
	                    <li>
	                        <span>받은 쪽지함</span>
	                    </li>
	                     <li>
	                        <span>보낸 쪽지함</span>
	                    </li>
	                </ul>
	            </li>
	            
	            <li data-options="state:'closed'">
	                <span>게시판</span>
	                <ul>
	                    <li >
	                        <span>1:1 게시판</span>
	                    </li>
	                     <li>
	                        <span>공지게시판</span>
	                    </li>
	                </ul>
	            </li>
	        </ul>
<%
}
%>
	    </div>
<!-- ######################## 메뉴 영역 끝 ##################### -->


        <div data-options="region:'center',title:'&nbspTerrGYM System',iconCls:'icon-ok'" style="padding: 2px;">
        
        <!-- [[ 회원관리 {회원목록, 회원등록, 회원삭제} ]] -->
	        <div id = "d_member">
	        	<div style="margin: 5px 0;"></div>
	        	&nbsp Home > 회원관리 > 회원목록
	        	<hr>
	        	<div style="margin: 20px 0;"></div>
	    <!--[[ 조건검색 화면 ]]-->
	            <div style="margin: 20px 0;">
			         아이디: <input id="mem_id" name="mem_id" class="easyui-textbox" style="width:110px">&nbsp&nbsp
			         이 름: <input id="mem_name" name="mem_name" class="easyui-textbox" style="width:110px">        
	            </div>
	    <!-- [[ 조회|입력|수정|삭제 버튼 ]] -->
	        	<div style="margin: 10px 0;">
		        	<a id="btn" href="javascript:memberList()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">조회</a>
		        	<a id="btn" href="javascript:memberInsert()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">입력</a>
		        	<a id="btn" href="javascript:memberUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">수정</a>
		        	<a id="btn" href="javascript:memberDelete()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">삭제</a>
	        	</div>
        <!-- [[ 회원목록 출력 ]] -->
	        	<table id="dg_member" class="easyui-datagrid" style="width:700px;height:250px"
           		 		data-options="singleSelect:true,collapsible:true,method:'get'">
			        <thead>
			            <tr>
			                <th data-options="field:'MEM_ID',width:80,align:'center'">아이디</th>
			                <th data-options="field:'MEM_NAME',width:100,align:'center'">이름</th>
			                <th data-options="field:'MEM_ADDRESS',width:300,align:'center'">주소</th>
			                <th data-options="field:'BUTTON',width:80,align:'center'">버튼</th>
			            </tr>
			        </thead>
			    </table>
	        </div>
        <!-- [[ 쪽지관리 {받은 쪽지함, 보낸 쪽지함} ]] -->
	        <div id = "d_memberInsert">
	        	<div style="margin: 5px 0;"></div>
	        	&nbsp Home > 회원관리 > 회원등록
	        	<hr>
	        	<div style="margin: 20px 0;"></div>
	        	<div id="dg_memberInsert">회원등록 화면 보여주기</div>
	        </div>
        
        
        </div>
    </div>
</body>
</html>