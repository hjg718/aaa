<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>Q&amp;A게시판 리스트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<script>
function search() {
	   var param = $("#searchF").serialize();
	   $.ajax({
	      url : "find",
	      method : "post",
	      data : param,
	      dataType : "json",
	      success : function(r) {
	         alert("성공");
	         $(".cell").remove();
	         for (var i = 0; i < r.length; i++) {
	            var tr = $("<tr class=cell></tr>");
	            var td = $("<td>" + r[i].num + "</td>");
	            tr.append(td);
	            td = $("<td><a href='/team/qb/read?num="+r[i].num+"'>"
	                  + r[i].title + "</a></td>");
	            tr.append(td);
	            td = $("<td>" + r[i].author + "</td>");
	            tr.append(td);
	            $("table").append(tr);
	         }
	         $('#page-selection').empty();
	          $('#page-selection').off("page");
	           $('#page-selection').bootpag({
	                 total: r[0].total,        /* total pages */
	                 page:  r[0].curr,           /* current page */
	                 maxVisible: 5,      /* Links per page */
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
	                var param={};
	                param.pgnum = num;
	                param.category = $("select[name=category]").val();
	                param.keyword=$("input[name=keyword]").val();
	                param.${_csrf.parameterName} = '${_csrf.token }';
	                $.ajax({
	                   url : 'find',
	                   method : 'post',
	                   data : param,
	                   dataType : 'json',
	                   success : function(r){
	                      $("#tb1").empty();
	                      for(var i=1;i<r.length;i++){
	                      var cell = $("<div class='cell'></div>");
	                      var col = $("<span class='col'>"+r[i].num+"</span>")
	                      cell.append(col);
	                      col=$("<span class='tt'><a href='javascript:read("+r[i].num+")'>"+r[i].title+"</a></span>");
	                      cell.append(col);   
	                      col=$("<span class='col' id='desc'>"+r[i].author+"</span>");
	                      cell.append(col);   
	                      $("#tb1").append(cell);
	                      }
	                   },
	                   error : function(x,s,e){
	                      alert('여기!');
	                   }
	                });
	            });
	                
	      },
	      error : function(x,s,e) {
	         alert("여기오!");
	      }
	      
	   });
	   return false;
	}
$(function(){
         $('#page-selection').bootpag({
            total:"${list[0].totalpages}",        
             page:"${list[0].page}",   
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
             var param = {};
             param.${_csrf.parameterName}= '${_csrf.token }';
             param.pgnum = num;
             $.ajax({
              url : "page",
              method : "post",
              data : param,
              dataType : "json",
              success : function(r){
                 $(".cell").remove();
               for (var i=0; i < r.length; i++) {
                  var tr = $("<tr class=cell></tr>");
                  var td = $("<td>" + r[i].num + "</td>");
                  tr.append(td);
                  td = $("<td><a href='read?num="+r[i].num+"'>"
                        + r[i].title + "</a></td>");
                  tr.append(td);
                  td = $("<td>" + r[i].author + "</td>");
                  tr.append(td);
                  $("table").append(tr);
                  
               }
              },
              error : function(x, s, e) {
                 alert("오류");
              }
           });
           return false;
         });
   });
function logout() {
	$("#logout").submit();
}
</script>
<style>
</style>
</head>
<body>
<header>
<div id="navigation" class="navbar navbar-inverse navbar-fixed-top default" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="<c:url value="/"/>">Groovin</a>
    </div>
	<div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<nav>
<ul class="nav navbar-nav navbar-left">
<sec:authorize access="hasAuthority('ADMIN')">
<li><a href="<c:url value="/user/join"/>">매니저계정만들기</a></li>
</sec:authorize>
<sec:authorize access="hasAnyAuthority('MANAGER','ADMIN')">
<li><a href="<c:url value="/book/add"/>">도서등록</a></li>
</sec:authorize>
</ul>
<ul class="nav navbar-nav navbar-right" id="mynav">
<sec:authentication var="id" property="name" />
<c:url var="user" value="/user/info">
<c:param name="id" value="${id }" />
</c:url>
<sec:authorize access="isAuthenticated()">
<li><a href="javascript:logout();">로그아웃</a></li>
<li><a href="${user}">내정보보기</a></li>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
<li><a href="#myModal" data-toggle="modal">로그인</a></li>
<li><a href="<c:url value="/user/join"/>">회원가입</a></li>
</sec:authorize>
<li><a href="qna/list">Q&amp;A게시판</a></li>
<li><a href="boardListStart">자유게시판</a></li>
</ul>
</nav>
</div>
</div>
</div>
</div>
</header>
<section id="infoResult" class="section gray">
<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
<div class="heading">
<h3>Q&amp;A.</h3>
</div>
<P></P>		
<div id="result">
<table class="table table-striped table-hover">
<tr>
<th>번호</th>
<th>제목</th>
<th>글쓴이</th>
</tr>
<c:forEach var="qna" items="${list }">
 <tr class="cell">
<td>${qna.num}</td>
<td><a href="read?num=${qna.num}">${qna.title}</a></td>
<td>${qna.author}</td>
</tr>
</c:forEach>
</table>
</div>
</div>
</div>
</div>
</section>
<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>


