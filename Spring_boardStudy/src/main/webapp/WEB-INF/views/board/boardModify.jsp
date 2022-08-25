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
	.btn{
		font-size: 35px;
		cursor: pointer;
		border: 3px solid grey;
	}
	.btn_option{
		margin: 10px 0 0 0;
	}
	
</style>
</head>
<body>
<h1>수정페이지</h1>
	<form id="modifyForm" action="/board/boardModify" method="post">
	<div class="input_wrap">
		<label>번호</label>
		<input name="bno" value="<c:out value='${pageInfo.bno}'/>" readonly="readonly">
	</div>
	<div class="input_wrap">
		<label>제목</label>
		<input name="title" value="<c:out value='${pageInfo.title}'/>">
	</div>
	<div class="input_wrap">
		<label>내용</label>
		<textarea name="content" rows="3"><c:out value='${pageInfo.content}'/></textarea>
	</div>
	<div class="input_wrap">
		<label>작성자</label>
		<input name="writer" value="<c:out value='${pageInfo.writer}'/>">
	</div>
	<div class="input_wrap">
		<label>등록일</label>
		<input name="regdate" value="<fmt:formatDate pattern="yyyy/MM/dd" value='${pageInfo.regDate}'/>" readonly="readonly">
	</div>
	<div class="input_wrap">
		<label>수정일</label>
		<input name="updatedate" value="<fmt:formatDate pattern="yyyy/MM/dd" value='${pageInfo.updateDate}'/>" readonly="readonly">
	</div>
	</form>	
	
	<div class="btn_option">
		<a class="btn" id="list_btn">목록</a>
		<a class="btn" id="modify_btn">수정완료</a>
		<a class="btn" id="cancel_btn">취소</a>
		<a class="btn" id="delete_btn">삭제</a>
	</div>
	<form id="moveForm" action="/board/boardModify" method="get">
		<input type="hidden" id="bno" name="bno" value="<c:out value='${pageInfo.bno}'/>">
	</form>

<script>
	
	let modifyForm = $("#modifyForm");
	let moveForm = $("#moveForm");
	
	// 목록페이지 이동버튼
	$("#list_btn").on("click", function(e){
		
		moveForm.find("#bno").remove();
		moveForm.attr("action", "/board/boardList");
		moveForm.submit();
	});
	
	// 수정
	$("#modify_btn").on("click", function(e){
		
		modifyForm.submit();
	});
	
	// 취소
	$("#cancel_btn").on("click", function(e){
		
		moveForm.attr("action", "/board/boardDetail");
		moveForm.submit();
	});
	
	// 버튼 (삭제)
	$("#delete_btn").on("click", function(e){
		
		moveForm.attr("method", "POST");
		moveForm.attr("action", "/board/boardDelete");
		moveForm.submit();
		
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>
</body>
</html>