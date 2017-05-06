<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<form:form action="edit" method="post" modelAttribute="userVo">
<form:hidden path="userid"/>
비밀번호 (필수입력) <input type="password" name="upwd"> <br>
변경할 비밀번호 <input type="password" name="newpwd"> <br>
이름 <form:input path="uname"/><br>
전화번호 <form:input path="phone"/><br>
이메일<form:input path="uemail"/><br>
성별 : 
<c:choose>
<c:when test="${userVo.gender=='m' }">
남자  <input type="radio" name="gender" value="m" checked="checked" >
여자  <input type="radio" name="gender" value="f"><br>
</c:when>
<c:otherwise>
남자  <input type="radio" name="gender" value="m">
여자  <input type="radio" name="gender" value="f"checked="checked"  ><br>
</c:otherwise>
</c:choose>
<button type="submit">수정하기</button>
</form:form>
</body>
</html>