<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>BoardEnroll 페이지입니다.</h1>
	<a href="/board/boardList">목록페이지 이동</a>
	
	<form action="/board/boardEnroll" method="post">
		<div class="input_area">
			<label>제목</label>
			<input name="title" />
		</div>
		<div class="input_area">
			<label>내용</label>
			<textarea rows="3" name="content"></textarea>
		</div>
		<div class="input_area">
			<label>작성자</label>
			<input name="writer" />
		</div>
		<button class="btn">등록하기</button>
	</form>
</body>
</html>