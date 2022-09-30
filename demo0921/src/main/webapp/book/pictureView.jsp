<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../common/easyui_common.jsp" %>
<style type="text/css">
	#d_detail {
		position:absolute;
	}
</style>
<!-- 
리액트를 사용하지 않는 경우 필요한 기술요소
자바스크립트는 절차지향적이고 순서지향적!
싱글 스레드 - 비동기처리가 내장되어있지 않음 - NodeJS
 -->
<script type="text/javascript">
	function makeInfo(result){
		console.log(result);
		
		// JSON.stringyfy는 왜 안쓰지? - 이미 문자열이니까~ >> object로 출력될 때만 사용.
		const jsonDoc = JSON.parse(result); // Array 변환
		let picHTML = "";
		
		if(jsonDoc.length>0){ // 조회결과가 있니?
			for(let i = 0; i<jsonDoc.length; i++){
				picHTML += "<table>";
				picHTML += "<tr><td><img width='200' height='200' src='/images/"+jsonDoc[i].p_img+"'/></td>";
				picHTML += "<td>"+jsonDoc[i].p_info+"</td></tr>";
				picHTML += "</table>";
			}
		}else{
			picHTML += "조회결과가 없습니다.";
		}
		return picHTML;
	}
	
	function startMethod(td){ // html element - object .
		$.ajax({
			  method: "GET",
			  url: "./pictureInfo.jsp?p_no="+td.id,
			  success:function(result) { // result -> searchResult.jsp -> html태그들
				console.log(result); // JSON 포맷으로 찍힌다.
				let picHTML = makeInfo(result);
				// 화면에 렌더링 되기 전에 스타일 처리가 선행되어야 함.
				$("#d_detail").css("border", "1px dotted #b0e0e6");
				$("#d_detail").css("left", td.offsetWidth+85+"px");
				$("#d_detail").css("top", td.offsetTop+20+"px");
				$("#d_detail").html(picHTML);
			  },
			  error:function(e){
				  $("#d_search").text(e.responseText); // 에러메세지 출력 - 디버깅
			  }
		});
	}
	
	function clearMethod(){
		document.getElementById("d_detail").innerHTML="";
	}
</script>
</head>
<body>
	<table border="1">
		<thead>
			<th colspan="2">그림 목록</th>
		</thead>
		<tbody>
			<tr>
				<td align="center"><img src="../images/picture1.jpg" width="50" height="50"></td>
				<td id="1" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화1</td>
			</tr>
			<tr>
				<td align="center"><img src="../images/picture2.jpg" width="50" height="50"></td>
				<td id="2" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화2</td>
			</tr>
			<tr>
				<td align="center"><img src="../images/picture3.jpg" width="50" height="50"></td>
				<td id="3" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화3</td>
			</tr>
			<tr>
				<td align="center"><img src="../images/picture4.jpg" width="50" height="50"></td>
				<td id="4" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화4</td>
			</tr>
		</tbody>
	</table>
	<div id="d_detail"></div>
</body>
</html>