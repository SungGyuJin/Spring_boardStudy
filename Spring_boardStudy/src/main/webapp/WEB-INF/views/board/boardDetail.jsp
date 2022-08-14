<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<style>
	
	.input_wrap{
	}
	input{
		width: 15%;
		height: auto;
	}
	textarea{
		width: 800px;
		height: 200px;
		font-size: 25px;
	}
	label{
		display: block;
		margin: 10px 0;		
		font-size: 25px;
	}
	
</style>
</head>
<body>
	<h1>수정페이지</h1>
	<div class="input_wrap">
		<label>번호</label>
		<input name="bno" value="<c:out value='${dList.bno}'/>" readonly="readonly">
	</div>
	<div class="input_wrap">
		<label>제목</label>
		<input name="bno" value="<c:out value='${dList.title}'/>" readonly="readonly">
	</div>
	<div class="input_wrap">
		<label>내용</label>
		<textarea name="bno" rows="3" readonly="readonly"><c:out value='${dList.content}'/></textarea>
	</div>
	<div class="input_wrap">
		<label>작성자</label>
		<input name="bno" value="<c:out value='${dList.writer}'/>" readonly="readonly">
	</div>
	<div class="input_wrap">
		<label>등록일</label>
		<input name="bno" value="<c:out value='${dList.regDate}'/>" readonly="readonly">
	</div>
	<div class="input_wrap">
		<label>수정일</label>
		<input name="bno" value="<c:out value='${dList.updateDate}'/>" readonly="readonly">
	</div>

<script>

</script>
</body>
</html>