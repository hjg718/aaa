<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
</script>
<style>
</style>
</head>
<body>
<c:if test="${join==true}">
가입을 환영합니다.
</c:if>
<c:if test="${param.error==true }">
    로그인 실패
</c:if>
<form  action='<c:url value="/user/login"/>' method="post" id="loginForm"> 
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
ID <input type="text" name="id" value="11">
PWD <input type="password" name="pwd" value="123">
<button type="submit" >로그인</button>
</form>
</body>
</html>