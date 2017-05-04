<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
function check(){
	if($("#p").val()==""){
		alert("아이디를 입력해주세요"); return;
	}
	var param={};
	param.id= $("#p").val();
	param.${_csrf.parameterName}= '${_csrf.token }';
	$.ajax({
		url : "check",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.ok){
				alert("해당 아이디로 가입가능!");
			}
			else{
				alert("이미 사용중인 아이디입니다.");
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
		
	});
}
</script>
<style>
</style>
</head>
<body>
<form:form action="join" commandName="userVo" method="post">
ID<form:input path="id" id="p"/><form:errors path="id"/>
<button type="button" onclick="check()">중복검사</button>
<c:if test="${overlap }">중복된아이디입니다.</c:if><br>
PWD<form:input path="pwd"/><form:errors path="pwd"/><br>
이름 <input type="text" name="name"><br>
전화번호 <input type="tel" name="phone"><br>
이메일<input type="email" name="email"><br>
성별 : 남자  <input type="radio" name="gender" value="m">
여자  <input type="radio" name="gender" value="f"><br>
<button type="submit">가입</button>
</form:form>
</body>
</html>