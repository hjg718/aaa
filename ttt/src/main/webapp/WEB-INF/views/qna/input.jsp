<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>게시판 리스트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<style>
#proposalF {text-align: center; background-image: url("/teampj/resources/image/Q&A.jpg"); }
</style>
<script>
function save(){
	var param = $('#proposalF').serialize();
	alert(param);
	$.ajax({
	 	url:'save',
		method:'post',
		data: param,
		dataType:'json',
		success:function(r){
			if(r.save){
				alert('저장 성공');
				location.href="recent";
				}else alert("오루유");
		},
		error:function(xhr,status,err){
			alert("오류!!!!");
		}
	});
	return false;
}
</script>
<body>
<form id="proposalF" onsubmit="return save();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
제　목 : <input type="text" name="title" value="test"><br>
작성자 : <input type="text" name="author" value="123"><br>
 내　용 :  <textarea rows="7" cols="21" name="contents">책등록 요청시 저자,출판사,제목 을 제대로 기입해주세요</textarea>
 <input type="hidden" name="ref" value="0"><br>
 <button type="submit">저장</button>
</form>
</body>
</html>


