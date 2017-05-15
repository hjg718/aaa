<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<style type="text/css">
body{
background-image: url('../resources/assets/img/read.jpg');
background-repeat:no-repeat;
background-position:center;
top:0; 
left:0;
width:100%; 
height:100%; 
text-align:center;
}
</style>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

function re() {
	   var param = $("#reForm").serialize();
	   alert(param);
	   $.ajax({
	      url : "reple",
	      method : "post",
	      data : param,
	      dataType : "json",
	      success : function(r) {
	    	 if(r){
	         alert("답글 달기성공");
	         location.href="recent";
	    	 }
	      },
	      error : function(x, s, e) {
	         alert('오류');
	      }
	   });
	   return false;
	}

function remove(){
	var param = $("#delete").serialize();
	$.ajax({
	 	url:'delete',
		method:'post',
		data:param,
		dataType:'json',
		success:function(r){
			if(r){
			alert('삭제성공');
			location.href="list";
			}else {
				alert("삭제 실패");
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
<div id="div1">
<form id = "delete" onsubmit="return remove()">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" name="num" value="${read.num}"> <br>
타이틀:${read.title} <br>
<br>
내용　:${read.qcontents}<br>
<br>

작성자:${read.author} <br>
<br>
작성날자:${read.bdate}<br>
<br>
<sec:authorize access="hasAuthority('ADMIN')">
<button type="submit" >삭제</button>
</sec:authorize>
</form>
</div>

<form id="pwd" name="pwd" action="modify" method="GET">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
비밀번호 <input type="password" name="pwd">
<button type="submit">수정하기</button>
</form>

<div id="link_group">
<sec:authorize access="hasAuthority('ADMIN')">
<sec:authentication property="name" var="loginId" />
<form id="reForm" onsubmit="return re();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" name="ref" value="${read.num}"> <br>
글제목 <input type="text" name="title" value="RE:"><br>
내 용  <textarea rows="5" cols="25" name="qcontents"></textarea><br>
작성자 : <input type="text" name="author" id="author" value=<sec:authorize access="isAuthenticated()">${loginId}</sec:authorize>><br>
<button type="submit" id="reple">답글쓰기</button>
 </form>
</sec:authorize>
<a href="list">목록보기</a>

 
</div>
</body>
</html>