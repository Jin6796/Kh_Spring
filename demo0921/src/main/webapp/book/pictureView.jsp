<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../common/easyui_common.jsp" %>
<style type="text/css">
	#d_search {
		position:absolute;
	}
</style>
<script type="text/javascript">
	function startMethod(td){
		$.ajax({
			  method: "GET",
			  url: "./pictureInfo.jsp?p_no=2",
			  success:function(result) { // result -> searchResult.jsp -> html태그들
				console.log(result); // JSON 포맷으로 찍힌다.
			  },
			  error:function(e){
				  $("#d_search").text(e.responseText); // 에러메세지 출력 - 디버깅
			  }
		});
	}
	function clearMethod(){
		document.getElementByID("d_detail").innerHTML="";
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
				<td id="1" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화 1</td>
			</tr>
			<tr>
				<td align="center"><img src="../images/picture2.jpg" width="50" height="50"></td>
				<td id="1" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화 2</td>
			</tr>
			<tr>
				<td align="center"><img src="../images/picture3.jpg" width="50" height="50"></td>
				<td id="1" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화 3</td>
			</tr>
			<tr>
				<td align="center"><img src="../images/picture4.jpg" width="50" height="50"></td>
				<td id="1" onmouseover="startMethod(this)" onmouseout="clearMethod()">추상화 4</td>
			</tr>
		</tbody>
	</table>

</body>
</html>