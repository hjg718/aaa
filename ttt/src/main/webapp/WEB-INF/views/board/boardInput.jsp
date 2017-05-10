<%@ page contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
  <script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script> 

<meta charset="utf-8">
<title>자유 게시판 글 쓰기</title>

<script type="text/javascript">

function boardInput(){
	var param = $('#inputForm').serialize();
	
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
		error:function(xhr,status,err){alert("오류"+err);}
	});
	return false;
}
</script>

</head>

<body>
<!-- 로그인된 아이디가 저장된다. -->
<sec:authentication property="name" var="loginId"/>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<form id="inputForm" onsubmit='return boardInput();'>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
글 제목:<textarea rows="5" cols="15" id="title" name="title" >(제목 없음)</textarea><br>
글 내용:<textarea rows="5" cols="15" id="contents" name="contents">내용을 입력해주세요.</textarea><br>
	<input type="hidden" name="author" value="${loginId}">
작성자:${loginId}<br>
<button type="submit">[글 올리기]</button><button type="reset">[다시 작성]</button>
</form>

<h6><a href = "boardListStart">목록 바로 가기</a></h6>

</body>
</html>