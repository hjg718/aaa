<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
#div1 { text-align: center;}
</style>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
function modify(){
	var param = $("#modify").serialize();
	alert(param);
	$.ajax({
	 	url:'modify',
		method:'post',
		data:param,
		dataType:'json',
		success:function(r){
			if(r){
			alert('저장 성공');
			location.href="recent";
			}
			else alert('저장 실패')
		},
		error:function(xhr,status,err){
			alert("오류발생");
		}
	});
	return false;
}
</script>

</head>
<body>
<form id="modify" onsubmit="return modify()">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<div id="div1">
<input type="hidden" name="num" value="${read.vo.num}"> <br>
타이틀<input type="text" name="title"value="${read.vo.title}"> <br>
<br>
내용<textarea rows="5" cols="25" name="qcontents">${read.vo.qcontents}</textarea><br>
<br>
작성자<input type="text" name="author" value="${read.vo.author}"> <br>
<br>

</div>
<button type="submit">수정 하기</button>
 </form>

</body>
</html>