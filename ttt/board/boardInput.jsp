<%@ page contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script> 
<meta charset="utf-8">

<title>자유 게시판 글 쓰기</title>
<style type="text/css">
#contents,#title{vertical-align: text-top;}
</style>
<script type="text/javascript">
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function boardInput(){
	var param = $('#inputForm').serialize();

	var c = $('#contents').val();
	var t = $('#title').val();
		if(c==""||c==null){alert("내용을 입력 하세요.");return;}
		else if(t==""||t==null){alert("제목을 입력 하세요.");return;}

	$.ajax({
		url:"boardInput",
		method:"post",
		data:param,
		dataType:"json",
		success:function(res){
			if(confirm("작성하신 글을 저장 저장 하시겠습니까?")){
				if(res.ok){
					alert("글이 저장 되었습니다.게시판으로 이동 합니다.");
					location.href = "boardListStart";
				}else{
					alert("글 저장 실패");
				}
			}
		},
		error:function(xhr,status,err){alert("오류");}
	});
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
</script>

</head>

<body>
<!-- 로그인된 아이디가 저장된다. -->
<sec:authentication property="name" var="loginId"/>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<form id="inputForm"'>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
제 목:<input type="text" id="title" name="title"><br>
내 용:<textarea type="text" rows="7" cols="22" id="contents" name="contents"></textarea><br>
	<input type="hidden" name="author" value="${loginId}">
작성자:${loginId}<br>
<button type="button" onclick="boardInput();">저　장</button>
<button type="reset">리　셋</button>
</form>

<h6><a href = "boardListStart">자유게시판 목록 바로 가기</a></h6>

</body>
</html>