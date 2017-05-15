<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
#div1 { text-align: center;}
#qcontents{vertical-align: text-top;}
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
			if(r.mo==1){
			alert('저장 성공');
			location.href="recent";
			}
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
<input type="hidden" name="num" value="${read.num}"> <br>
타이틀<input type="text" name="title"value="${read.title}"> <br>
<br>
내용<textarea id="qcontents" rows="5" cols="25" name="qcontents">${read.qcontents}</textarea><br>
<br>
작성자<input type="text" name="author" value="${read.author}"> <br>
<br>

</div>
<button type="submit">수정 하기</button>
<a href="list">목록보기</a>
 </form>

</body>
</html>