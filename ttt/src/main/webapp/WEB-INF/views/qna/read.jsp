<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

function re() {
	   var param = $("#reForm").serialize();
	   $.ajax({
	      url : "reple",
	      method : "post",
	      data : param,
	      dataType : "json",
	      success : function(r) {
	         alert("답글 달기성공");
	         location.href="recent";
	      },
	      error : function(x, s, e) {
	         alert(e);
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
<input type="hidden" name="num" value="${read.vo.num}"> <br>
타이틀:${read.vo.title} <br>
<br>
내용　:${read.vo.qcontents}<br>
<br>

작성자:${read.vo.author} <br>
<br>
작성날자:${read.vo.bdate}<br>
<br>
<button type="submit">삭제</button>
</form>
</div>

<div id="link_group">
<a href="list">목록보기</a>
<a href="modify?num=${read.vo.num}">수정하기</a>

<form id="reForm" onsubmit="return re();">
<input type="hidden" name="num" value="${read.vo.num}"> <br>
글제목 <input type="text" name="title" value="RE:"><br>
작성자<input type="text" name="author"><br>
내 용  <textarea rows="5" cols="25" name="contents"></textarea><br>
<button type="submit">답글쓰기</button>
 </form>

 
</div>
</body>
</html>