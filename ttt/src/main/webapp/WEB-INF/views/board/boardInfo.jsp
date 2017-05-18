<%@ page contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<meta charset="utf-8">
<title>제목 클릭시 읽기</title>

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
				alert("댓글달린글은 삭제가 불가능 합니다."); //true
			}
			}
		},
		error:function(xhr,status,err){alert("오류");}
	});
	
}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
//댓글
$(function(){ 
	   $('#refForm').hide(); // refForm을 숨긴다.
	});
	function showRepl(){
	   $("#refForm").toggle(); // 댓글을 클릭하면 refForm이 보여진다.
	}
	function saveRepl(){
		   //if(!confirm('답글을 저장 하시겠습니까?')) return false;
		   // ajax가 폼을 전송하기 때문에 다른 전송방식은 false로 해야 한다.
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
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<!-- 로그인된 아이디와 작성자 아이디와 동일해야 한다. -->
<sec:authentication property="name" var="secName"/>
<sec:authorize access="${secName==list.author}">
   <button><a href="javascript:edit('${list.num}')">수정</a></button>
	<button><a href="javascript:deleteNum()">삭제</a></button><br>
</sec:authorize>

<button><a href="javascript:showRepl();">답글 달기</a></button>

<!-- 삭제 -->
<form id= "deleteForm">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden"  name ="num" value="${list.num }">
</form>



<!-- ㅡㅡㅡㅡㅡ댓글 달기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<form id="refForm" onsubmit="return saveRepl();">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="ref" value="${list.num}">
   	답글 제목 :<textarea type="text" name="title" >Re:</textarea><br>
   	답글 내용 :<textarea type="text" name="contents" >Re:</textarea><br>
   	작성자 :<input name="author" value="${loginId}"><br>
 	<button type="submit">저장</button> <button type="reset">다시 작성</button>
</form>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
<br>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->


<!-- 사용 권한 -->
<!-- 로그인된 사람 이라면  , 보여지고 사용 가능하도록 한다.-->
<sec:authorize access="isAuthenticated()">

</sec:authorize>

<!-- 운영자 ADMIN이면 , 보여지고 사용 가능하도록 한다. -->
<sec:authorize access="hasAuthority('ADMIN')">
	<button><a href="javascript:deleteNum()">삭제</a></button><br>
</sec:authorize>
<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->

<h6><a href = "boardListStart">목록 바로 가기</a></h6>

</body>
</html>