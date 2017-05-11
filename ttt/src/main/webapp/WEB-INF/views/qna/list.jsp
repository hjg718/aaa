<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>게시판 리스트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
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
	      },
	      error : function(x, s, e) {
	         alert(e);
	      }
	   });
	   return false;
	}
$(function(){
         $('#page-selection').bootpag({
            total:${sessionScope.total},        
             page:${sessionScope.curr},   
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
             $("#content").html("Page" + num); // or some ajax content loading...
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

</script>
<style>
#box {
text-align: center;
}

table {
   margin: 0px auto;
   border: 1px solid black;
   width: 800px;
}

tr:NTH-CHILD(2n+1) {
   background-color: rgb(200, 200, 174);
}

th {
   font-size: 20pt;
   border-bottom: 1px solid black;
   text-align: center;
}

td {
text-align: center;
   font-size: 13pt;
}

a {
   text-decoration: none;
}

a:LINK {
   color: black;
}

a:VISITED {
   color: black;
}

#serch {
   width: 500px;
   margin: 5px auto;
}

#select {
   height: 25px;
}

#chPage {
   display: inline;
 }

#page {
   text-align: center;
}
</style>
</head>
<body>
   <table>
      <tr>
         <th>번호</th>
         <th>제목</th>
         <th>글쓴이</th>
      </tr>
      <c:forEach var="qna" items="${requestScope.list}"> <!-- req list -->
         <tr class="cell">
         <td>${qna.num}</td>
         <td><a href="read?num=${qna.num}">${qna.title}</a></td>
         <td>${qna.author}</td>
      </tr>
      </c:forEach>
   </table>
<br>
<p>
<div id="box">
<div id="page-selection"></div><br>
<form id="searchF" onsubmit="return search();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
 <select name="category">
    <option value="title" selected>제목</option>
    <option value="author">작성자</option>
    <option value="contents">내용</option>
 </select>
 <input type="text" name="keyword">
 <button type="submit">검색</button>
</form>
<a href="save">글쓰기</a>
</div>
</body>
</html>


