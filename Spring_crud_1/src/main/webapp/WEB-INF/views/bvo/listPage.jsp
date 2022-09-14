<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>글쓴이</th>
			<th>등록일</th>
			<th>수정일</th>
		</tr>
		<tbody>
			<c:forEach items="${list}" var="list">
				<tr>
					<td><c:out value="${list.bno}"/></td>
					<td>
						<a class="move" href="<c:out value='${list.bno}'/>"><c:out value="${list.title}"/></a>
					</td>
					<td><c:out value="${list.content}"/></td>
					<td><c:out value="${list.writer}"/></td>
					<td><fmt:formatDate value="${list.regDate}" pattern="yyyy/MM/dd"/></td>
					<td><fmt:formatDate value="${list.updateDate}" pattern="yyyy/MM/dd"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<form id="moveForm" method="get">
		
	</form>
	
	
<script type="text/javascript">
	
	let mForm = $('#moveForm');
	
	$('.move').on("click", function(e){
		
		e.preventDefault();
		
		mForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		mForm.attr("action", "/bvo/detailPage");
		mForm.submit();
	});
	
	
	
</script>
</body>	
</html>