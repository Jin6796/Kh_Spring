<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<%@ include file="../common/easyui_common.jsp" %>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			let t = $('#dong');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){	// 엔터 빵!
					zipcodeSearch();
				}
			});
		})
	</script>
	<div>
		<label for="dong">동이름 입력</label>
		<input id="dong" name="dong" class="easyui-textbox" style="width:300px" />
		<a href="javascript:zipcodeSearch()" class="easyui-linkbutton">검색</a>
		<div id="d_zipcode">여기에 검색 결과가 노출됨</div>
	</div>
</body>
</html>