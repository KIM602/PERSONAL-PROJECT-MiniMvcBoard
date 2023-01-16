<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 

<title>게시판</title>

<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>-->
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<!-- 페이지처리 js 임포트 -->
<script src="js/jquery.twbsPagination.js"></script>

</head>
<body>

<form id="searchForm" class="form-inline" action="#">
	<button class="btn btn-success ml-auto" type="button" disabled><i class="fa fa-search"></i></button>
	<input id="searchInput" class="form-control mr-sm-2" type="text" placeholder="Search"/>
</form>

<div id="submain">
	<h3 class="text-center text-info">게시판</h3>
	<table id="searchTable" class="table table-bordered table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>히트수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listContent}" var="dto">
				<tr>
					<td class="bid">${dto.bId}</td> <!-- bName은 user id -->
					<td>${dto.bName}</td>
					<td>
						<c:forEach begin="1" end="${dto.bIndent}">ㄴ</c:forEach>
						<a class="contentView" href="contentView?bId=${dto.bId}">${dto.bTitle}</a>
					</td>
					<td>${dto.bDate}</td> <!-- Timestamp형의 문자열로 출력 -->
					<td>${dto.bHit}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- 페이지 표시 -->
<nav aria-label="Page navigation"> <!-- aria-label은 라벨표시가 안되는 것 예방 -->
	<ul class="pagination justify-content-center" id="pagination" style="margin:20px 0;">
	</ul>
</nav>
<a id="write" class="btn btn-primary" href="writeView">글 작성</a>

<script>
//페이지 구현
//$(function() {}); 는 $(document).ready(function() {});과 동일한 단축형임
$(function() {
	window.pagObj = $("#pagination").twbsPagination({
		totalPages: 35, //총 페이지 수
		visiblePages: 10, //보여지는 페이지 수
		onPageClick: function(event, page) {
			console.info(page + ' (from options)');
			$(".page-link").on("click", function(event) { //클래스 page-link는 BS4의 pagination의 링크 A
				event.preventDefault();
				let peo = $(event.target);
				let pageNo = peo.text();
				let purl;
				let PageA;
				let PageNo1;
				let PageNo2;
				
				if(pageNo != "First" && pageNo != "Previous" && pageNo != "Next" && pageNo != "Last") {
					purl = "plist?pageNo=" + pageNo;
				}
				else if(pageNo == "Next") {
					pageA = $("li.active > a"); //li에 active클래스가 있고 a에 페이지 번호가 있음
					pageNo = pageA.text(); //페이지 번호
					pageNo1 = parseInt(pageNo);
					pageNo2 = pageNo1 - 1;
					purl = "plist?pageNo=" + pageNo2;
				}
				else if(pageNo == "Previous") {
					pageA = $("li.active > a"); //li에 active클래스가 있고 a에 페이지 번호가 있음
					pageNo = pageA.text(); //페이지 번호
					pageNo1 = parseInt(pageNo);
					pageNo2 = pageNo1 - 1;
					purl = "plist?pageNo=" + pageNo2;
				}
				else if(pageNo == "First") {
					purl = "plist?pageNo=" +1;
				}
				else if(pageNo == "Last") {
					purl = "plist?pageNo=" + 35;
				}
				else {
					return;
				}
				
				$.ajax({
					url : purl,
					type : "get",
					data : "",
					success : function(data) {
						$("#hjumbo").text("게시판입니다. " + pageNo + " 페이지입니다.");
						$("#submain").html(data);
					//	let parent = $(peo).parent(); //page-link의 부모인 page-item에 추가
					//	$(parent).addClass("active");
					},
					error : function() {				
						$("#mbody").text("서버접속 실패..");
						$("#modal").trigger("click");
					}
				}); //ajax
			}); //page-link onclick
		} //onPageClick
	}) //window.pagObj
	.on('page', function(event, page) { //chaining방식
		console.info(page + ' (from event listening)');
	});
	
	$("#write").click(function(){
		event.preventDefault();
		$.ajax({
			url : "writeView",
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("게시판 글작성 페이지입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패..");
				$("#modal").trigger("click");
			}
		});
	});
	
	$("a.contentView").click(function(event){
		event.preventDefault();
		let ceo = $(event.target);
		$.ajax ({
			url : ceo.attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("게시판 상세내용 페이지입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패..");
				$("#modal").trigger("click");
			}
		});
	});
});
</script>

<script>
$("#searchInput").on("keyup",function(){
	var value = $(this).val().toLowerCase(); //this는 이벤트가 일어난 엘리먼트(#searchInput)
	$("#searchTable tr").filter(function(){ //jquery의 filter메서드는 지정된 엘리먼트를 찾거나 걸러줄시 사용
		$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
		//this는 선택된 #searchTable tr임
		//tr에서 문자열을 소문자로 변환해서 입력한 값 value값과 비교하여 일치하는 색인번호를 구함
		//toggle메서드는 일치하는 것이 없으면 해당 tr을 버린다
	});
});

//전체 게시판 내용에서 고르기
#("#searchInput").on("focus",function(){
	console.log('focus');
	$.ajax({
		url : "searchBoard",
		type : "get",
		data : "",
		success : function(data) {
			$("#hjumbo").text("게시판 검색 페이지 입니다.");
			$("#mainRegion").html(data);
		},
		error : function() {
			$("#mbody").text("서버접속 실패!");
			$("#modal").trigger("click");
		}
	});
});
</script>
</body>
</html>

