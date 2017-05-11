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
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>

<script>
$(function() {
 	$(".reload").click(function(){
   		location.reload();
   	});
});

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
			if(res.pass==true){
				$("#rentalBody").text("대여완료!");
				$('#rentalResult').modal('show');
				
			}
			else {
				$("#rentalBody").text("대여불가!");
				$('#rentalResult').modal('show');
			}
		},
		error : function(x,s,e) {
			alert("오류!");
		}
	});
}
function booking() {
	var param ={};
	param.booknum = ${book.vo.bnum};
	param.userid = "<sec:authentication property='name'/>";
	param.${_csrf.parameterName}= '${_csrf.token }';
	$.ajax({
		url : "booking",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass==true){
				$("#bookingBody").text("예약완료!");
				$('#bookingResult').modal('show');
				
			}
			else {
				$("bookingBody").text("예약불가!");
				$('#bookingResult').modal('show');
			}
		},
		error : function(x,s,e) {
			alert("오류!");
		}
	});
}
function list() {
	$("#list").submit();	
}
</script>
<style>
</style>
</head>
<body>
<img alt="" width="100" height="100" src="img?coverName=${book.vo.coverName} "/><br>
<!--대여하기 예약하기 있어야함 -->

<sec:authentication var="id" property="name"/>
<c:set var="ok" value="false"/>
<c:forEach var="sub" items="${book.subscriber}">
<c:if test="${sub==id}">
<c:set var="ok" value="true"/>
</c:if>
</c:forEach>

<c:choose>
<c:when test="${book.rentaluser!=null||book.bookingnum>0 }">
반납 예정일 : ${book.returndate }
	<c:choose>
	<c:when test="${book.rentaluser!=id }">
	이도서는 대여중입니다.
	
		<c:choose>
		<c:when test="${ok==true }">
			<a class="btn btn-default disabled">예약중</a>
		</c:when>
		<c:when test="${book.bookingnum<5&&ok==false }">
			<sec:authorize access="hasAuthority('USER')">
			<a class="btn btn-default" href="<c:url value="javascript:booking();"/>">예약가능</a>
			</sec:authorize>
			
			<sec:authorize access="!isAuthenticated()">
			<a class="btn btn-default disabled">로그인 후 예약가능</a>
			</sec:authorize>
		</c:when>
		<c:otherwise>
			<a class="btn btn-default disabled">예약정원을 초과했습니다.</a>
		</c:otherwise>
		</c:choose>
	
	</c:when>
	<c:otherwise>
	<a class="btn btn-default disabled">대여중</a>
	</c:otherwise>
	</c:choose>
</c:when>

<c:otherwise>

<sec:authorize access="hasAuthority('USER')">
<a class="btn btn-default" href="<c:url value="javascript:rental();"/>">대여가능</a>
</sec:authorize>

<sec:authorize access="!isAuthenticated()">
<a class="btn btn-default disabled">로그인 후 대여가능</a>
</sec:authorize>

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
<a href="javascript:list();">목록보기</a>

<!--대여결과  -->
<div class="modal fade" id="rentalResult" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="rentalBody">
				</div>
				<div class="modal-footer">
					<button type="button" class="close reload" data-dismiss="modal"
					aria-label="Close">
					확인
				</button>
				</div>
			</div>
		</div>
	</div>
<!-- 예약결과  -->
<div class="modal fade" id="bookingResult" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="bookingBody">
				</div>
				<div class="modal-footer">
					<button type="button" class="close reload" data-dismiss="modal"
					aria-label="Close">
					확인
				</button>
				</div>
			</div>
		</div>
	</div>
<!-- 목록보기 폼  -->
<form action="search" method="post" id="list">
	<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }"> 
	<input type="hidden" name="category" value="${category}">				
	<input type="hidden" name="keyword" value="${keyword}">
</form>
</body>
</html>