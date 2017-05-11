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
function returnBook(num) {
	$("input[name=num]").val(num);
	var param = $("#returnForm").serialize();
	$.ajax({
		url : "<c:url value='/book/returnBook'/>",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass){
				alert("반납완료!");
				$("#"+num).remove();
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
${info.vo.userid }<br>
${info.vo.uname }<br>
${info.vo.phone }<br>
<c:forEach items="${info.bvoList }" var="book" varStatus="i">
<div id="${info.rvoList[i.index].num}">
책이름 : ${book.bname }
대여일 : ${info.rvoList[i.index].rendate }
반납 예정일 : ${info.rvoList[i.index].returndate }
남은 대여일 : ${info.rvoList[i.index].day }
<a href="javascript:returnBook(${info.rvoList[i.index].num });">반납하기</a>
</div>
</c:forEach>



<!-- 모달  -->
<form  id="seceForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="userid" value="${userVo.userid }">
정말 탈퇴 하실 거라면 비밀번호<input type="password" name="upwd"><br>
<button type="button" onclick="secession();">탈퇴하기</button>
</form>
<form  id="returnForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="num">
<input type="hidden" name="id" value="${id }">
</form>
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>