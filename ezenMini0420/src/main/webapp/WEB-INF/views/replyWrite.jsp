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
<meta id="_csfr" name="_csrf" content="${_csrf.token}"/> 
<title>JSP</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id"/>
</sec:authorize>

<h3 class="text-center">댓글작성</h3>
<form action="reply" method="post" id="replyForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="bGroup" value="${replyView.bGroup}" />
	<input type="hidden" name="bStep" value="${replyView.bStep}" />
	<input type="hidden" name="bIndent" value="${replyView.bIndent}" />
	<div class="form-group">
		<label for="uId">게시판 번호</label>
		<input type="text" class="form-control" id="uId" name="bId" value="${replyView.bId}" readonly />
	</div>
	<div class="form-group">
		<label for="hit">히트수</label>
		<input type="text" class="form-control" id="hit" name="bHit" value="${replyView.bHit}" readonly />
	</div>
	<div class="form-group">
		<label for="uname">작성자</label>
		<input type="text" class="form-control" id="uname" name="bName" value="${user_id}" readonly />
	</div>
	<!-- 제목과 내용은 원래 것을 보여주고 수정 -->
	<div class="form-group">
		<label for="title">제목</label>
		<input type="text" class="form-control" id="title" name="bTitle" placeholder="${replyView.bTitle}" required />
	</div>
	<div class="form-group">
		<label for="content">내용:</label>
		<textarea id="content" rows="10" name="bContent" class="form-control" placeholder="${replyView.bContent}" required></textarea>
	</div>
	<button type="submit" class="btn btn-success">댓글작성</button>&nbsp;&nbsp;
	<a href="eBoard" id="replyBoard" class="btn btn-primary">목록보기</a>
</form>

<script>
$(document).ready(function(){
	$("#replyForm").submit(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#replyForm").attr("action"),
			type : $("#replyForm").attr("method"),
			data : $("#replyForm").serialize(),
			success : function(data) {
				$("#hjumbo").text("Main내부의 게시판입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버와의 접속 실패입니다.");
				$("#modal").trigger("click");
			}
		});
	});
	
	$("#replyBoard").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#replyBoard").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("Main내부의 게시판입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버와의 접속 실패입니다.");
				$("#modal").trigger("click");
			}
		});
	});
});
</script>
</body>
</html>
