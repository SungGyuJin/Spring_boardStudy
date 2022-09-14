<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div>
		<label>번호</label>
		<input type="text" name="bno" value="${list.bno}">
	</div>
	<div>
		<label>제목</label>
		<input type="text" name="title" value="${list.title}">
	</div>
		<label>내용</label>
		<input type="text" name="content" value="${list.content}">
	<div>
	</div>
		<label>글쓴이</label>
		<input type="text" name="writer" value="${list.writer}">
	<div>
	</div>
		<label>등록일</label>
		<input type="text" name="regDate" value="${list.regDate}">
	<div>
		<label>수정일</label>
		<input type="text" name="updateDate" value="${list.updateDate}">
	</div>
</body>
</html>