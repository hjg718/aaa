<%@ page contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
<title>제목 클릭시 읽기</title>

<style type="text/css">
#contents,#title{vertical-align: text-top;}
</style>

<script type="text/javascript">
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//수정
function edit(num){
	if(confirm("수정 하시겠습니까?")){
		location.href = "edit?num="+num;
	}
}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//삭제 (댓글 달린글은 삭제가 불가능 하다.)
function deleteNum(){

	var param = $('#deleteForm').serialize();
	
	$.ajax({
		url:'delete',
		method:'post',
		data:param,
		dataType:'json',
		success:function(res){
			if(confirm("삭제 하시겠습니까 ?")){
			if(res.ok){
				alert("삭제 되었습니다.");//false
				location.href = "boardListStart";
			}else{
				alert("댓글이 달린글은 삭제가 불가능 합니다."); //true
			}
			}
		},
		error:function(xhr,status,err){alert("오류");}
	});
	
}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//댓글

	function saveRepl(){
		   var param = $('#refForm').serialize();
		   
		   $.ajax({
		      url : "boardRepl",
		      method : "post",
		      data : param,
		      dataType : "json",
		      success : function(res){
		    	  if(confirm("댓글을 저장 하시겠습니까?")){
		         	if(res){
		            	alert("작성하신 댓글을 정상적으로 저장했습니다.게시판으로 이동합니다.");
		            	location.href="boardListStart";         
		         	}else{
		        		 alert("저장 실패");
		         	}
		    	  }
		      },
		      error : function(xhr, status, err){alert("오류");}
		   });
		   return false;
		}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//추천
function goodClick(){
	var param = $('#goodForm').serialize();
	
	$.ajax({
		url:'good',
		method:'post',
		data:param,
		dataType:'json',
		success:function(res){
			if(res.ok){
				alert("추천 했습니다.");
			}else{
				alert("중복 추천은 불가능 합니다.");
			}
		},error:function(xhr,status,err){alert("추천 오류");}
	});
	return false;
}
</script>

</head>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ  BODY ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<body>
<!-- 로그인된 아이디가 저장된다. -->
<sec:authentication property="name" var="loginId"/>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡ 제목 클릭시 상세내용 보여주기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<span>글 번호:${list.num}</span><br>
<span>글 제목:${list.title}</span><br>
<span>글 내용:${list.contents}</span><br>
<span>작성자:${list.author}</span><br>
<span>작성일:${list.regdate}</span><br>
<span>조회수:${list.readCnt}</span><br>

<p>
<!-- 추천 -->
<form id = "goodForm" onsubmit="return goodClick();">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name ="num" value="${list.num }">
	<input type="hidden" name="goodname"value="${loginId}">
	<input type="hidden" name="goodnum" value="${list.num}">
	<input type="hidden" id="goodcnt" name ="goodcnt" value="${list.goodcnt}">
</form>

<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<!-- 로그인된 아이디와 작성자 아이디와 동일해야 한다. -->
<sec:authentication property="name" var="secName"/>
<sec:authorize access="${secName==list.author}">
   <button><a href="javascript:edit('${list.num}')">수정</a></button>
	<button><a href="javascript:deleteNum()">삭제</a></button><br>
</sec:authorize>

<!-- 삭제 -->
<form id= "deleteForm">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden"  name ="num" value="${list.num }">
</form>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->




<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->


<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<br>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->


<!-- 사용 권한 -->
<!-- 권한이 MANAGER, ADMIN이면 , (삭제),(수정) 보여지고 사용 가능하도록 한다. -->
<sec:authorize access="hasAnyAuthority('MANAGER,ADMIN')">
	<button><a href="javascript:deleteNum()">삭제</a></button>
	 <button><a href="javascript:edit('${list.num}')">수정</a></button><br>
</sec:authorize>
<!-- 로그인된 사람 이라면  ,(댓글) 보여지고 사용 가능하도록 한다.-->
<sec:authorize access="isAuthenticated()">
<button><a href ="javascript:goodClick();">추천</a></button>
<form id="refForm" onsubmit="return saveRepl();"> <!-- 댓글 -->
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="ref" value="${list.num}">
   	답글 제목 :<textarea type="text"id="title" name="title" >Re:</textarea><br>
   	답글 내용 :<textarea type="text"id="contents" name="contents" >Re:</textarea><br>
   	작성자 :${loginId}<input type="hidden" name="author" value="${loginId}"><br>
 	<button type="button" onclick="saveRepl();">답글쓰기</button>
</form>
</sec:authorize>



<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->

<h6><a href = "boardListStart">목록 바로 가기</a></h6>

</body>
</html>