<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
function logout() {
	$("#logout").submit();
}

function check() {
	var ch = /.{2,}/;
	 var pass = ch.test($("input[name=keyword]").val());
	if(!pass){
		$("#waring").text("2자 이상 입력해주세요");
	}
	return pass;
}
</script>
<style type="text/css">

</style>
</head>
<body>
<sec:authentication var="id" property="name"/>
<c:url var="user" value="user/info">
<c:param name="id" value="${id }"/>
</c:url>
<sec:authorize access="!isAuthenticated()">
<a href="user/join">회원가입</a>
<a href="user/login">로그인</a>
</sec:authorize>
<sec:authorize access="hasAuthority('ADMIN')">
<a href="user/join">매니저계정만들기</a>
</sec:authorize>
<sec:authorize access="hasAnyAuthority('MANAGER','ADMIN')">
<a href="book/add">도서등록</a>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
<a href="${user}">내정보보기</a>
<a href="javascript:logout();">로그아웃</a>
</sec:authorize>
<form action="book/search" method="post" onsubmit="return check();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<select name="category">
<option value="bname">제목</option>
<option value="author">저자</option>
<option value="publisher">출판사</option>
</select>
<input type="text" name="keyword">
<button type="submit">검색</button><br>
<div id="waring"></div>
</form>
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>
