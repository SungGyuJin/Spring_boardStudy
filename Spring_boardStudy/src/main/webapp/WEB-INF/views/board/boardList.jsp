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
	*{
		margin: auto;
	}
	
	table{
		width: 80%;
		text-align: center;
	}
</style>
</head>
<body>
	<h1>목록페이지입니다.</h1>
	<a href="/board/boardEnroll">게시판 등록페이지 이동</a>
	
	<div class="">
			<table border="1">
				<thead>
					<tr>
						<th class="bno">No</th>
						<th class="title">제목</th>
						<th class="writer">작성자</th>
						<th class="regdate">작성일</th>
						<th class="updatedate">수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="li" varStatus="count">
						<tr>
							<td><a href="/board/boardDetail?bno=${li.bno}"><%-- <c:out value="${li.bno}"/> --%>${count.count}</a></td>
							<td><c:out value="${li.title}"/></td>
							<td><c:out value="${li.writer}"/></td>
							<td><fmt:formatDate value="${li.regDate}" pattern="yyyy/MM/dd"/></td>
							<td><fmt:formatDate value="${li.updateDate}" pattern="yyyy/MM/dd"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<form id="moveForm" method="get">
				
			</form>
	</div>
	

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
			
			if(result === 'modify success'){
				alert("수정완료.");
			}
			
			if(result === 'delete success'){
				alert("삭제완료.");
			}
		}
		
	});
	
</script>
</body>
</html>