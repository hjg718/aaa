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
<script src="<c:url value="/resources/jquery-3.1.1.min.js"/>"></script>
<script type="text/javascript">
function modify(){
	var param = $("#modify").serialize();
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
<div id="div1">
<input type="text" name="num" value="${read.getNum()}"> <br>
타이틀<input type="hidden" name="title"value="${read.getTitle()}"> <br>
<br>
내용<textarea rows="5" cols="25" name="contents">${read.getContents()}</textarea><br>
<br>
작성자<input type="text" name="author" value="${read.getAuthor()}"> <br>
<br>

</div>
<button type="submit">수정 하기</button>
 </form>

</body>
</html>