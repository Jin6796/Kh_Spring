<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.vo.MemberVO" %>
<%
	int s_cnt = 0;
		out.println(session.getAttribute("s_cnt"));
	if(session.getAttribute("s_cnt") != null){
		s_cnt = (Integer)session.getAttribute("s_cnt");
		out.println("if문 탔음");
	}else{
		out.println("if문 안탔음");
	}
	
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
		let gm_no;
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
		function receiveMemoList(){
			$("#dg_receiveMemoList").datagrid({
				method:"get"
				,url: "/memo/receiveMemoList?to_id=<%=smem_id%>" // JSON으로 전달하는 페이지가 조립이 되어야 한다. (응답페이지는 html이 아니라 JSON포맷의 파일이어야 한다.)
				,onSelect: function(index, row){
					gm_no = row.NO; // 번호 받아오자
				}
			});	
	        $("#d_member").hide();
			$("#d_memberInsert").hide();
			$("#d_receiveMemoList").show();
			$("#d_sendMemoList").hide();
		}
		function sendMemoList(){
			$("#dg_sendMemoList").datagrid({
				method:"get"
				,url: "/memo/sendMemoList?from_id=<%=smem_id%>" // JSON으로 전달하는 페이지가 조립이 되어야 한다. (응답페이지는 html이 아니라 JSON포맷의 파일이어야 한다.)
				,onSelect: function(index, row){
					gm_no = row.NO; // 번호 받아오자
				}
			});	
	        $("#d_member").hide();
			$("#d_memberInsert").hide();
			$("#d_receiveMemoList").hide();
			$("#d_sendMemoList").show();
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
			$("#d_receiveMemoList").hide();
			$("#d_sendMemoList").hide();
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
		function memoContent(){
			console.log("쪽지내용보기");
			$("#dlg_memoContent").dialog({
				title: "쪽지 내용 확인",
				// 쪽지 내용을 DB에서 꼭 가져와야 되나?
				// 목록을 가져올 때 가지고 있다가 출력해도 되지 않나? - 오라클 경유를 안해도 되잖아
				// 근데.. 쪽지를 읽었는지 여부를 업데이트해서 반영해야 하기 때문에 오라클 경유해야 됨
				// 한 건을 조회한 후 그 자료구조가 null이 아닐 때에만 업데이트!! 500번 에러가 뜨면 진행이 되면 안됨.
				// 이 기능을 구현하기 위해 컨토를 계층의 메소드부터 호출되어야 하나? 아니면 로직 클래스의 메소드 호출만으로도 괜찮은가?
				//		 > 고민 후 객체 주입 관계와 메소드 선언을 결정하자
				// 설계자는 기능 담당자가 구현해야하는 페이지이름과 메소드, 
				// 그리고 파라미터와 리턴타입 모두를 다 정해놓고 담당자는 메소드 안에 기능구현만 하도록 할 것
				href: "/memo/memoContent?no="+gm_no,
				modal: true,
				closed: true
			});
			$("#dlg_memoContent").dialog('open');
		}
		// 가능하다면 최소한의 코드만 수정하고 유지보수가 이루어질 수 있도록 하자.
		function memoContentClose(){
//			receiveMemoList();
			location.href = "/auth/index.jsp"; // URL이 변경된다 > 기존의 요청이 끊기고 새로운 요청이 들어온다 - 세션/쿠키가 바뀜
			$("#dlg_memoContent").dialog('close');
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
		$("#d_sendMemoList").hide();
		$("#d_receiveMemoList").hide();
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
<!-- ######################## 로그아웃 영역 시작 ################### -->   
      <div id="d_logout" align="center">
         <div id="d_ok"><%=smem_name%>님 환영합니다.
	         <br>읽지 않은 쪽지 수: <%= s_cnt %>개
         </div>
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
	                        <a href="javascript:receiveMemoList()">받은 쪽지함</a>
	                    </li>
	                     <li>
	                        <a href="javascript:sendMemoList()">보낸 쪽지함</a>
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
	        
<!-- 
======================================================================================        
     [ 받은 쪽지함 ]   -   읽지 않은 쪽지 수 // to_id == smem_id
======================================================================================        
-->       
			<div id="d_receiveMemoList">
				<div style="margin: 5px 0"></div>
				&nbsp Home > 쪽지관리 > 받은 쪽지함
				<hr>
				<div style="margin: 20px 0;"></div>
				<table id="dg_receiveMemoList" class="easyui-datagrid" style="width:700px;height:250px"
           		 		data-options="singleSelect:true,collapsible:true,method:'get'">
			        <thead>
			            <tr>
			                <th data-options="field:'NO',width:80,align:'center'">번호</th>
			                <th data-options="field:'FROM_ID',width:100,align:'center'">아이디</th>
			                <th data-options="field:'MEM_NAME',width:100,align:'center'">이름</th>
			                <th data-options="field:'READ_YN',width:100,align:'center'">읽음 확인</th>
			                <th data-options="field:'BUTTON',width:100,align:'center'">버튼</th>
			            </tr>
			        </thead>
			    </table>
				<div id="dlg_memoContent" footer="#btn_memoContent" class="easyui-dialog" 
					 title="쪽지쓰기" data-options="modal:true,closed:true" 
					 style="width: 600px; padding: 10px;"> <!-- height:300px; 지움. -->
					<div id="btn_memoContent" align="right">
						<a href="javascript:memoContentClose()" class="easyui-linkbutton" iconCls="icon-clear">닫기</a>
					</div>
				</div>
				
			</div>
<!-- 
======================================================================================        
     [ 보낸 쪽지함 ]
======================================================================================        
-->     
			<div id="d_sendMemoList">
				<div style="margin: 5px 0"></div>
				&nbsp Home > 쪽지관리 > 보낸 쪽지함
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