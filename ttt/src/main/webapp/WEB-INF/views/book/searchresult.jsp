<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<c:url var="url" value="/resources/jquery.bootpag.min.js"/>
<script src="${url }"></script>
<link rel="stylesheet" href="<c:url value='/resources/assets/css/fancybox/jquery.fancybox.css'/>">


<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>

<script>
$(function(){
    $('#pageNav').bootpag({
        total: ${book.tpg},      
        page:  ${book.page},           
        maxVisible: 5,     
        leaps: true,
        firstLastUse: true,
        first: '←',
        last: '→',
        wrapClass: 'pagination',
        activeClass: 'active',
        disabledClass: 'disabled',
        nextClass: 'next',
        prevClass: 'prev',
        lastClass: 'last',
        firstClass: 'first'
    }).on("page", function(event, num){
    	var param ={};
    	param.page = num;
    	param.${_csrf.parameterName } = '${_csrf.token }';
    	param.category = '${category}';
    	param.keyword = '${keyword}';
    	$.ajax({
    		url : "searchPage",
    		method : "post",
    		data : param,
    		dataType : "json",
    		success : function(res){
    			$("#result").empty();
    			for(var i=0;i<res.length;i++){
    				var img = $("<img alt='' width='100' height='100' src='img?coverName="
    						+res[i].coverName+"'/>");
    				$("#result").append(img);
    				$("#result").append("<a href='read?bnum="+res[i].bnum+"'>"+res[i].bname+"</a> ");
    				$("#result").append(res[i].author+" ");
    				$("#result").append(res[i].publisher+" ");
    				$("#result").append("<br>");
    			}
    		},
    		error : function(x,s,e){
    			alert("오류!");
    		}
    	});
    });
    });
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
<style>
</style>
</head>
<body>
<header>
<div id="navigation" class="navbar navbar-inverse navbar-fixed-top default" role="navigation">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.html">Groovin</a>
    </div>
	<div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"><nav>
      <ul class="nav navbar-nav navbar-right">
     	<sec:authentication var="id" property="name"/>
     	<c:url var="user" value="/user/info">
		<c:param name="id" value="${id }"/>
	 	</c:url>
	  	<sec:authorize access="!isAuthenticated()">
        <li><a href="<c:url value="/user/join"/>">회원가입</a></li>
        <li><a href="#myModal" data-toggle="modal" >로그인</a></li>
        </sec:authorize>
        <sec:authorize access="hasAuthority('ADMIN')">
		<li><a href="<c:url value="/user/join"/>">매니저계정만들기</a></li>
		</sec:authorize>
		<sec:authorize access="hasAnyAuthority('MANAGER','ADMIN')">
		<li><a href="<c:url value="/book/add"/>">도서등록</a></li>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
		<li><a href="${user}">내정보보기</a></li>
		<li><a href="javascript:logout();">로그아웃</a></li>
		</sec:authorize>
      </ul></nav>
    </div><!-- /.navbar-collapse -->
	</div>
  </div>
</div>
</header>
<form action="search" method="post" onsubmit="return check();">
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
<c:if test="${book==nill }">검색 내용이 없습니다.</c:if>
<div id ="result">
<c:forEach var="vo" items="${book.list }">
<img alt="" width="100" height="100" src="img?coverName=${vo.coverName}"/>
<a href="read?bnum=${vo.bnum}">${vo.bname }</a>
${vo.author }
${vo.publisher}<br>
</c:forEach>
</div>
<div id="pageNav"></div>
<!-- 로그인 모달  -->
<div class="modal fade" id="myModal" tabindex="-1"  aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
       <form  action='<c:url value="/user/login"/>' method="post" id="loginForm"> 
      <div class="modal-body">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		ID <input type="text" name="id" value="11">
		PWD <input type="password" name="pwd" value="123">
      </div>
      <div class="modal-footer">
     	<button type="submit"  class="btn btn-success">로그인</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
		</form>
    </div>
  </div>
</div>
<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>