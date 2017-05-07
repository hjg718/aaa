<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<c:url var="url" value="/resources/jquery.bootpag.min.js"/>
<script src="${url }"></script>
<link rel="stylesheet" 
href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
</script>
<style>
</style>
</head>
<body>
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
</body>
</html>