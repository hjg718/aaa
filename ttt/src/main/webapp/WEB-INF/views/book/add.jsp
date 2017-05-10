<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
</script>
<style>
</style>
</head>
<body>
<form action="addbook?${_csrf.parameterName }=${_csrf.token }"
enctype="multipart/form-data" method="post">
표지 <input type="file" name="cover"><br>
책 제목<input type="text" name="bname"><br>
글쓴이 <input type="text" name="author"><br>
목차 <textarea rows="10" cols="50" name="bindex"></textarea><br>
출판사 <input type="text" name="publisher"><br>
상세내용<textarea rows="10" cols="50" name="bcontents"></textarea><br>
출판일 <input type="date" name="pdate"><br>
<input type="checkbox" name="cate" value="소설">소설
<input type="checkbox" name="cate" value="에세이">에세이
<input type="checkbox" name="cate" value="시">시
<input type="checkbox" name="cate" value="수필">수필
<input type="checkbox" name="cate" value="자서전">자서전
<input type="checkbox" name="cate" value="여행">여행
<input type="checkbox" name="cate" value="컴퓨터">컴퓨터
<input type="checkbox" name="cate" value="사회/이슈">사회/이슈<br>
<input type="checkbox" name="cate" value="경제">경제
<input type="checkbox" name="cate" value="과학">과학
<input type="checkbox" name="cate" value="위인/전기">위인/전기
<input type="checkbox" name="cate" value="기술서">기술서
<input type="checkbox" name="cate" value="만화">만화
<input type="checkbox" name="cate" value="요리">요리
<input type="checkbox" name="cate" value="음악">음악
<input type="checkbox" name="cate" value="학습서">학습서<br>
<button type="submit">저장하기</button>
</form>
</body>
</html>