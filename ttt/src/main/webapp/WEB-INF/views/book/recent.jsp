<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<img alt="" width="100" height="100" src="img?coverName=${book.coverName} "/><br>
${book.bnum }<br>
${book.bname }<br>
${book.bindex }<br>
${book.bcontents }<br>
${book.publisher }<br>
${book.author }<br>
${book.pdate }<br>
<c:forEach var="cate" items="${book.cate }">
${cate }
</c:forEach>
<a href="add">추가등록하러 가기</a>

<a href="<c:url value="/"/>">메인</a>
</body>
</html>