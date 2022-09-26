<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.vo.MemberVO" %>
<%
	String smem_id = (String)session.getAttribute("smem_id");
	String smem_name = (String)session.getAttribute("smem_name");
	if(smem_id == null){
	out.print("로그인을 해주세요.");
	}else{
	out.print("사용자 아이디: " + smem_id + ", " + "사용자 이름: " + smem_name);
	}
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
		let to_id;   // 받는 사람 아이디 - 쪽지쓰기 로우에서 자동으로 담기. 수동입력X
		let to_name; // 받는 사람 이름
	// 함수 선언은 head 태그 안에서!!!
	// easyui_common.jsp
		function login(){
			const tb_id = $("#mem_id").val();
			const tb_pw = $("#mem_pw").val();			
			location.href="/member/login?mem_id="+tb_id+"&mem_pw="+tb_pw;
		}
		function logout(){ // 로그아웃
			location.href="./logout.jsp";
		}
		// 순서 지향적인, 절차 지향적인 코딩을 전개 하는 데에서 모듈화 해 나가는 것, 비동기 처리하는 연습(await/async)
		function memberList(){ // 회원목록
	        //alert($("#_easyui_textbox_input4").val());
		
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
			$("#dg_member").datagrid({
				method:"get"
				,url: "/member/jsonMemberList?type="+type+"&keyword="+keyword // JSON으로 전달하는 페이지가 조립이 되어야 한다. (응답페이지는 html이 아니라 JSON포맷의 파일이어야 한다.)
				,onSelect: function(index, row){
					to_id = row.MEM_ID;     // 데이터그리드 선택 시 해당 로우의 아이디 담기
					to_name = row.MEM_NAME; // 데이터그리드 선택 시 해당 로우의 이름 담기
					console.log("아이디: " + to_id + ", " + "이름: " + to_name)
				}
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
		function memoForm(){
			console.log("memoForm 호출");
			$("#dlg_memo").dialog({
				title: "쪽지쓰기",
				href: "/memo/memoForm.jsp?to_id="+to_id+"&to_name="+to_name,
				modal: true,
				closed: true
			});
			$("#dlg_memo").dialog('open');
		}
		function memoSend(){
			console.log("쪽지보내기");
			$("#f_memo").submit();
		}
		function memoFormClose(){
			$("#dlg_memo").dialog('close');
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
		$("#mem_id").textbox('setValue', 'tomato');
		$("#mem_pw").textbox('setValue', '123');
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
	if(smem_name ==null){
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
         <div id="d_ok"><%=smem_name%>님 환영합니다.</div>
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
if (smem_id!=null){
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
<!-- 쪽지쓰기 화면 시작 -->	
	<div id="dlg_memo" footer="#dlg_memo" class="easyui-dialog" 
		 title="쪽지쓰기" data-options="modal:true,closed:true" 
		 style="width: 600px; padding: 10px;"> <!-- height:300px; 지움. -->
		<div id="btn_memo" align="right">
			<a href="javascript:memoFormClose()" class="easyui-linkbutton" iconCls="icon-clear">닫기</a>
		</div>
	</div>
<!-- 쪽지쓰기 화면 끝 -->
</body>
</html>