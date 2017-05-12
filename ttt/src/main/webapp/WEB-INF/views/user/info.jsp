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
	$("#returnForm input[name=num]").val(num);
	var param = $("#returnForm").serialize();
	$.ajax({
		url : "<c:url value='/book/returnBook'/>",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass){
				alert("반납완료!");
				$("#ren"+num).remove();
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}
function cancel(num) {
	$("#cancelForm input[name=num]").val(num);
	var param = $("#cancelForm").serialize();
	$.ajax({
		url : "<c:url value='/book/cancel'/>",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass){
				alert("예약취소");
				$("#boo"+num).remove();
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}
function rental(booknum,bookingnum) {
	var param ={};
	param.booknum = booknum;
	param.bookingnum = bookingnum;
	param.userid = "<sec:authentication property='name'/>";
	param.${_csrf.parameterName}= '${_csrf.token }';
	$.ajax({
		url : "<c:url value='/book/bookingrental'/>",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass==true){
				alert("대여완료");
				
			}
			else {
				alert("최대 대여수를 초과했습니다.");
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
<sec:authentication var="id" property="name"/>
<c:url var="user" value="edit">
<c:param name="id" value="${id }"/>
</c:url>
<a href="${user}">정보수정</a>
${info.vo.userid }<br>
${info.vo.uname }<br>
${info.vo.phone }<br>
<c:forEach items="${info.rvoList }" var="ren" >
<div id="ren${ren.num}">
책이름 : ${ren.bookname}
대여일 : ${ren.rendate }
반납 예정일 : ${ren.returndate }
남은 대여일 : ${ren.day }
<a href="javascript:returnBook(${ren.num });">반납하기</a>
</div>
</c:forEach>
예약
<br>
<c:forEach items="${info.bvoList }" var="boo" >
<div id="boo${boo.num}">
책이름 : ${boo.bookname}
<c:choose>
<c:when test="${!boo.ok }">
대여일 : ${boo.rendate }
예정 반납일 : ${boo.returndate }
남은 대여일 : ${boo.day }
</c:when>
<c:otherwise>
<a class="btn btn-default" href="<c:url value="javascript:rental(${boo.booknum },${boo.num});"/>">대여하기</a>
</c:otherwise>
</c:choose>

<a href="javascript:cancel(${boo.num });">예약취소</a>
</div>
</c:forEach>



<!-- 모달  -->
<form  id="seceForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="userid" value="${userVo.userid }">
정말 탈퇴 하실 거라면 비밀번호<input type="password" name="upwd"><br>
<button type="button" onclick="secession();">탈퇴하기</button>
</form>
<!--반납  -->
<form  id="returnForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="num">
<input type="hidden" name="id" value="${id }">
</form>
<!--예약 취소  -->
<form  id="cancelForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="num">
</form>
<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>