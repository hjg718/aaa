<%@ page contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="<c:url value="/resources/jquery.bootpag.min.js" />"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<meta charset="utf-8">
<title>수정</title>

<style type="text/css">
#contents,#title{vertical-align: text-top;}
</style>


<script type="text/javascript">
function edit(){
	
	var param = $('#editForm').serialize();
	var t = $('#title').val();
	var c = $('#contents').val();
	if(t==""||t==null){alert("제목을 입력 해주세요.");return;}
	else if(c==""||c==null){alert("내용을 입력 해주세요.");return;}
	
	$.ajax({
		url:'update',
		method:'post',
		data:param,
		dataType:'json',
		success:function(res){
			if(res){
				alert("수정 완료");
				location.href="info?num=${list.num}";
			}else{
				alert("수정 실패");
			}
		},
		error:function(xhr,status,err){alert("오류");}
	});
	return false;
}

</script>

</head>

<body>

<form id="editForm" onsubmit="return edit();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" id="num" name="num" value="${list.num}">
글 번호:${list.num}<br>
글 제목:<textarea rows="5" cols="15" id="title" name="title">${list.title}</textarea><br>
글 내용:<textarea rows="5" cols="15" id="contents" name="contents">${list.contents}</textarea><br>
작성자:${list.author}<br>
<button type="submit">수정 완료</button><button type="reset">다시 작성</button>
</form>

</body>
</html>