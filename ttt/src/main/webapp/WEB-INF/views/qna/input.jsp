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
#qcontents {vertical-align: text-top;}
</style>
<script type="text/javascript">

function save(){
	var param = $('#proposalF').serialize();
	var t = $('#title').val();
	var a = $('#author').val();
	var c = $('#qcontents').val();
	if(t==""||t==null){
		alert("제목을 입력하세요 ");
		 $('#author').val(a);
		 $('#qcontents').val(c);
			return;
	}if(t==""||t==null){
		alert("제목을 입력하세요 ");
		 $('#author').val(a);
		 $('#qcontents').val(c);
			return;
	}if(a==""||a==null){
		$('#title').val(t);
		$('#qcontents').val(c);
		alert("작성자를 입력하세요 ");
		return;
	}if(c==""||c==null){
		$('#title').val(t);
		$('#author').val(a);
		alert("내용을 입력하세요 ");
		return;
	}
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
}
</script>
<body>
<form id="proposalF" >
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
제　목 : <input type="text" name="title" id="title"><br>
작성자 : <input type="text" name="author" id="author"><br>
 내　용 :  <textarea rows="7" cols="21" name="qcontents" id="qcontents"></textarea>
 <input type="hidden" name="ref" value="0"><br>
 <input type="button" value="저장" onclick="save();">
</form>
</body>
</html>


