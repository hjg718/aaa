<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

</head>
<body>
<a href="user/join">회원가입</a>
<sec:authorize access="!isAuthenticated()">
<a href="user/login">로그인</a>
</sec:authorize>
<sec:authorize access="hasAuthority('ADMIN')">
<a href="user/login">aaaa</a>
</sec:authorize>
<form action="book/search" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<select name="category">
<option value="bname">제목</option>
<option value="author">저자</option>
<option value="publisher">출판사</option>
</select>
<input type="text" name="keyword">
<button type="submit">검색</button>
</form>
</body>
</html>
