<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>

<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<script src="<c:url value='/resources/jquery.bootpag.min.js'/>"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<meta charset="utf-8">

<title>게시판 리스트</title>

<script type="text/javascript">
//로그아웃
function logout(){
	$("#logout").submit();
}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//페이지 나누기.
$(function() {
	$('#page-selection').bootpag({
		total :${total},
		page : ${curr},
		maxVisible : 5,
		leaps : true,
		firstLastUse : true,
		first : '←',
		last : '→',
		wrapClass : 'pagination',
		activeClass :'active',
		disabledClass : 'disabled',
		nextClass : 'next',
		prevClass : 'prev',
		lastClass : 'last',
		firstClass : 'first'
	}).on("page", function(event, num) { //클릭시 실행된다.
		var param = {};
	
		param.page = num;
		param.${_csrf.parameterName }='${_csrf.token }';
		
		$.ajax({
			url:'listPage',
			method:'post',
			data:param,
			dataType:'json',
			success : function(res) {
				$('#listForm').empty();
				for( var i = 0 ; i< res.length; i++){
				$('#listForm').append(res[i].num);
				$('#listForm').append("<a href = 'info?num=" +res[i].num+ "';>" + res[i].title + "</a>");
				$('#listForm').append(res[i].author);
				$('#listForm').append("<a href ='info?readCnt="+res[i].num+"';></a>"+"조회 :"+res[i].readCnt+"-");
				$('#listForm').append("추천: "+res[i].goodcnt);
				$('#listForm').append("<br>");
				}
			},
			error : function(xhr, status, err) {
				alert("오류");
			}
		});
	});
});
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//검색
function searched(){
	
	var param = $('#searchForm').serialize();
	
	$.ajax({
		url:'search',
		method:'post',
		data:param,
		dataType:'json',
		success:function(res){
			$('#listForm').empty();
			for(var i = 0 ; i<res.length; i++){
				$('#listForm').append(res[i].num);
				$('#listForm').append("<a href = 'info?num=" +res[i].num+ "';>" + res[i].title + "</a>");
				$('#listForm').append(res[i].author);
				$('#listForm').append("<a href ='info?readCnt="+res[i].num+"';></a>"+"조회 :"+res[i].readCnt+"-");
				$('#listForm').append("추천: "+res[i].goodcnt);
				$('#listForm').append("<br>");
			}
		},
		error:function(xhr,status,err){alert("다시 입력해 주세요");}
	});
	return false;
}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
</script>

</head>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ BODY ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<body>
<!-- 로그인된 아이디가 저장된다. -->
<sec:authentication property="name" var="loginId"/>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->

<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<!--  추천수 많은거 -->
<h3>추천수 많은 5개</h3>
<form id="goodListForm">
	<c:forEach var = "b" items="${goodlist}">
	<span>${b.num}</span>
	<span><a href = "info?num=${b.num}&readCnt=${b.readCnt}">${b.title}</a></span>
	<span>${b.author}</span>
	<span>조회:${b.readCnt}-</span>
	<span>추천:${b.goodcnt}</span><br>
	</c:forEach>
	<P>
</form>
<h3>자유 게시판</h3>
<!-- 자유 게시판 -->
<form id="listForm" >
<c:forEach var="b" items="${boardlist}">
<span id= "num">${b.num}</span>
<span id= "title"><a href = "info?num=${b.num}&readCnt=${b.readCnt}">${b.title}</a></span>
<span id= "author">${b.author}</span>
<span id= "readCnt">조회: ${b.readCnt} -</span>
<span id = "goodcnt">추천 : ${b.goodcnt}</span><br>
</c:forEach>
</form>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
	<!-- 페이지 번호. -->
<div id="page-selection"></div>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<!-- 검색 하기. -->
<form id="searchForm" onsubmit="return searched();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<select name="category">
		<option name="num" value="num" >글 번호</option>
		<option name="title" value="title" selected>글 제목</option>
		<option name="author" value="author" >작성자</option>
	</select>
		<input type="text" name="keyword">
		 <button type="submit">검색</button>
</form>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->


<!-- 사용 권한 -->
<!-- 로그인 안된 유저 ( GUEST) 보여지고 사용 가능하도록 한다. -->
<sec:authorize access="!isAuthenticated()">
<a href ="user/login">로그인</a>
</sec:authorize>
<!--로그인된 회원 , MANAGER , ADMIN이면 , 보여지고 사용 가능하도록 한다. -->
<sec:authorize access="isAuthenticated()">
	<a href="javascript:logout();">로그 아웃</a>
	<h6><a href = "inputPage">자유 게시판에 글 쓰기</a></h6> <br>
</sec:authorize>

<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<p>
 <a href="index.jsp">메인 페이지 바로 가기</a>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<!-- 로그 아웃 security가 자동으로 처리한다.-->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->

</body>
</html>