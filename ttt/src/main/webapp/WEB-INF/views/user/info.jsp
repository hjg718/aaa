<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
function secession() {
	var param =$("#seceForm").serialize();
	$.ajax({
		url : "secession",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res) {
			if(res.pass){
				alert("삭제되었습니다.");
				$("#logout").submit();
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
<sec:authentication var="id" property="name"/>
<c:url var="user" value="edit">
<c:param name="id" value="${id }"/>
</c:url>
<a href="${user}">정보수정</a>
${userVo.userid }<br>
${userVo.uname }<br>
${userVo.phone }<br>

<!-- 모달  -->
<form action="secession" method="post" id="seceForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="userid" value="${userVo.userid }">
정말 탈퇴 하실 거라면 비밀번호<input type="password" name="upwd"><br>
<button type="button" onclick="secession();">탈퇴하기</button>
</form>
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>