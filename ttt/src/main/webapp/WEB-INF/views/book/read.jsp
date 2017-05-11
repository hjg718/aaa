<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
function rental() {
	var param ={};
	param.booknum = ${book.vo.bnum};
	param.userid = "<sec:authentication property='name'/>";
	param.${_csrf.parameterName}= '${_csrf.token }';
	$.ajax({
		url : "rental",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass){
				alert("대여 되었습니다.");
				location.href = "read?bnum=${book.vo.bnum}";
			}
		},
		error : function(x,s,e) {
			alert("오류!");
		}
	});
}
</script>
<style>
</style>
</head>
<body>
<img alt="" width="100" height="100" src="img?coverName=${book.vo.coverName} "/><br>
<!--대여하기 예약하기 있어야함  -->
<c:choose>
<c:when test="${book.rentaluser!=null }">
이도서는 예약중입니다.
</c:when>
<c:otherwise>
<a href="<c:url value="javascript:rental();"/>">예약가능합니다.</a>
</c:otherwise>
</c:choose>
${book.vo.bnum }<br>
${book.vo.bname }<br>
${book.vo.bindex }<br>
${book.vo.bcontents }<br>
${book.vo.publisher }<br>
${book.vo.author }<br>
${book.vo.pdate }<br>
<c:forEach var="cate" items="${book.vo.cate }">
${cate }
</c:forEach>
<a href="<c:url value="/"/>">메인</a>
</body>
</html>