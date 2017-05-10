<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>저장페이지</title>
</head>
<body>
작성자:${pj.getVo().getAuthor()}<br>
제목:${pj.getVo().getTitle()}<br>
내용:${pj.getVo().getContents()}<br>
<c:forEach var="fname" items="${pj.getFlist()}">
파일 이름:［${fname.getFname1()}］<br>
</c:forEach>
<a href="list">목록보기</a>
</body>
</html>