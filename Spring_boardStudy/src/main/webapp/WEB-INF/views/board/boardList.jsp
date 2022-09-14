<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<style>
* {
	margin: auto;
}

table {
	width: 80%;
	text-align: center;
}

.pageInfo {
	list-style: none;
	display: inline-block;
	margin: 50px 0 0 100px;
}

.pageInfo li {
	float: left;
	font-size: 20px;
	margin-left: 18px;
	padding: 7px;
	font-weight: 500;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}
.active{
	border: 2px solid black;
}
.search_area{
    display: inline-block;
    margin-top: 30px;
    margin-left: 260px;
}
  .search_area input{
    height: 30px;
    width: 250px;
}
.search_area button{
    width: 100px;
    height: 36px;
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
				<c:forEach items="${list}" var="li">
					<tr>
						<td>
							<a href="/board/boardDetail?bno=${li.bno}"><c:out value="${li.bno}"/></a>
						</td>
						<td><c:out value="${li.title}"/></td>
						<td><c:out value="${li.writer}"/></td>
						<td><fmt:formatDate value="${li.regDate}" pattern="yyyy/MM/dd"/></td>
						<td><fmt:formatDate value="${li.updateDate}" pattern="yyyy/MM/dd"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="search_wrap">
			<div class="search_area">
				<input type="text" name="keyword" value="${pMaker.cri.keyword}">
				<button>검색</button>
			</div>
		</div>

		<div class="pageInfo">
			<div class="pageInfo_num">
				<ul id="page_ul" class="pageInfo">
					<c:if test="${pMaker.prev}">
						<li class="pageInfo_btn prev">
							<a href="${pMaker.startPage - 1}">이전</a>
						</li>
					</c:if>
					<c:forEach var="num" begin="${pMaker.startPage}" end="${pMaker.endPage}">
						<li class="pageInfo_btn ${pMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
					</c:forEach>
					<c:if test="${pMaker.next}">
						<li class="pageInfo_btn next">
							<a href="${pMaker.endPage}">다음</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>

		<form id="moveForm" method="get">
			<input type="hidden" name="pageNum" value="${pMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pMaker.cri.amount}">
			<input type="hidden" name="keyword" value="${pMaker.cri.keyword}">
		</form>
	</div>

	<a href="/main"><img src="/resources/css/img/theBook.png"></a>

	<script type="text/javascript">
		$(document).ready(function() {

			let result = "<c:out value='${result}'/>";

			checkAlert(result);

			function checkAlert(result) {

				if (result === '') {
					return;
				}

				if (result === 'enroll success') {
					alert("등록완료.");
				}

				if (result === 'modify success') {
					alert("수정완료.");
				}

				if (result === 'delete success') {
					alert("삭제완료.");
				}
			}

		});

		let moveForm = $("#moveForm");

		$("#page_ul a").on("click", function(e) {

			e.preventDefault();

			moveForm.find("input[name=pageNum]").val($(this).attr("href"));
			moveForm.attr("action", "/board/boardList");
			moveForm.submit();
		});
		
		$('.search_area button').on('click', function(e){
			
			e.preventDefault();
			
			let key_value = $('input[name=keyword]').val();
			moveForm.find('input[name=keyword]').val(key_value);
			moveForm.find('input[name=pageNum]').val(1);
			moveForm.submit();
		});

	</script>
</body>
</html>