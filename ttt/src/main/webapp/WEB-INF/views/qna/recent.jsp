<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>저장페이지</title>
</head>
<body>
제목:${recent.getTitle()}<br>
작성자:${recent.getAuthor()}<br>
내용:${recent.getQcontents()}<br>
<a href="list">목록보기</a>
</body>
</html>