<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
	<h1>BoardList 페이지입니다.</h1>
	<a href="/board/boardEnroll">게시판 등록페이지 이동</a>

<script>
	$(document).ready(function(){
		
		let result = "<c:out value='${result}'/>";
		
		checkAlert(result);
		
		function checkAlert(result){
			
			if(result === ''){
				return;
			}
			
			if(result === 'enroll success'){
				alert("등록완료.");
			}
		}
	});
</script>
</body>
</html>