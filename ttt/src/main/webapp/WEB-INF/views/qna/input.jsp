<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>게시판 리스트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<style>
#proposalF {text-align: center; background-image: url("/teampj/resources/image/Q&A.jpg"); }
#qcontents {vertical-align: text-top;}
</style>
<script type="text/javascript">

function save(){
	var param = $('#proposalF').serialize();
	alert(param);
	var t = $('#title').val();
	var a = $('#author').val();
	var c = $('#qcontents').val();
	var p = $('#pwd').val();
	if(t==""||t==null){
		alert("제목을 입력하세요 ");
		 $('#author').val(a);
		 $('#qcontents').val(c);
		 $('#pwd').val(p);
			return;
	}if(a==""||a==null){
		$('#title').val(t);
		$('#qcontents').val(c);
		alert("작성자를 입력하세요 ");
		$('#pwd').val(p);
		return;
	}if(c==""||c==null){
		$('#title').val(t);
		$('#author').val(a);
		alert("내용을 입력하세요 ");
		$('#pwd').val(p);
		return;
	}if(p==""||p==null){
		$('#title').val(t);
		$('#author').val(a);
		$('#qcontents').val(c);
		alert("비밀번호 숫자 4자리를 입력하세요")
	}
	$.ajax({
	 	url:'save',
		method:'post',
		data: param,
		dataType:'json',
		success:function(r){
			if(r.save){
				alert('저장 성공');
				location.href="recent";
				}else alert("오루유");
		},
		error:function(xhr,status,err){
			alert("오류!!!!");
		}
	});
}
</script>
<body>
<sec:authentication property="name" var="loginId" />
<form id="proposalF" >
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
제　목 : <input type="text" name="title" id="title"><br>
내　용 :  <textarea rows="7" cols="22" name="qcontents" id="qcontents"></textarea><br>
작성자 : <input type="text" name="author" id="author" value="<sec:authorize access="!isAuthenticated()">손님</sec:authorize>
<sec:authorize access="isAuthenticated()">${loginId }</sec:authorize>"><br>
비밀번호 : <input type="password" name="pwd" id="pwd"> <br>
 <input type="hidden" name="ref" value="0"><br>
 <button type="button"  onclick="save();">저　장 </button>
 <button type="reset"  onclick="save();">리　셋</button>
 <h3><a href="list">Q&A 목록보기</a></h3>
</form>
</body>
</html>


