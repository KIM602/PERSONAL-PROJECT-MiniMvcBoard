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
<title>JSP</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery-->
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

<h3 class="text-center">게시판 내용보기 및 수정, 삭제</h3>
<form id="modiContent" action="modify" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="form-group">
		<label for="uId">번호</label>
		<input type="text" class="form-control" id="uId" name="bId" value="${contentView.bId}" readonly />
	</div>
	<div class="form-group">
		<label for="hit">히트수</label>
		<input type="text" class="form-control" id="hit" value="${contentView.bHit}" readonly />
	</div>
	<div class="form-group">
		<label for="uname">작성자</label>
		<input type="text" class="form-control" id="uname" name="bName" value="${contentView.bName}" readonly />
	</div>
	<div class="form-group">
		<label for="title">제목</label>
		<input type="text" class="form-control" id="title" name="bTitle" value="${contentView.bTitle}" />
	</div>
	<div class="form-group">
		<label for="content">내용</label>
		<textarea class="form-control" id="content" name="bContent" rows="10">${contentView.bContent}</textarea>
	</div>
	<button type="submit" id="modi" class="btn btn-success">수정</button>&nbsp;&nbsp;
	<a href="eBoard" id="contentBoard" class="btn btn-primary">목록보기</a>&nbsp;&nbsp;
	<a href="delete?bId=${contentView.bId}" id="contentDel" class="btn btn-primary">삭제</a>&nbsp;&nbsp;
	<a id="contentReplyView" href="replyView?bId=${contentView.bId}" class="btn btn-primary">댓글</a>
</form>
</body>

<script>
$(document).ready(function(){
	let username = '<c:out value="${user_id}"/>';
	let bname = '<c:out value="${contentView.bName}"/>';
	
	$("#contentBoard").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#eBoard").attr("href"),
			type : "GET",
			data : "",
			success : function(data) {
				$("#hjumbo").text("Main내부의 게시판입니다.");
				$("#mainRegion").html(data);
			},
			error : function(data) {
				$("#mbody").text("서버와의 접속 실패입니다.");
				$("#modal").trigger("click");
			}
		});
	});
	
	$("#modiContent").submit(function(event){
		event.preventDefault();
		if(username != bname) {
			$("#mbody").text("권한이 없습니다.");
			$("#modal").trigger("click");
			return false;	
		}
		else {
			$.ajax({
				url : "modify",
				type : "post",
				data : $("#modiContent").serialize(),
				success : function(data) {
					$("#hjumbo").text("Main내부의 게시판입니다.");
					$("#mainRegion").html(data);
				},
				error : function(data) {
					$("#mbody").text("서버와의 접속 실패입니다.");
					$("#modal").trigger("click");
				}
			});
		}
	});
	
	$("#contentDel").click(function(event){
		event.preventDefault();
		if(username != bname) {
			$("#mbody").text("권한이 없습니다.");
			$("#modal").trigger("click");
			return false; //클릭동작 해제
		}
		else {
			$.ajax({
				url : $("#contentDel").attr("href"),
				type : "get",
				data : "",
				success : function(data) {
					$("#hjumbo").text("Main내부의 게시판입니다.");
					$("#mainRegion").html(data);
				},
				error : function(data) {
					$("#mbody").text("서버와의 접속 실패입니다.");
					$("#modal").trigger("click");
				}
			});
		}
	});
	
	$("#contentReplyView").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#contentReplyView").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("Main내부의 댓글 작성창입니다.");
				$("#mainRegion").html(data);
			},
			error : function(data) {
				$("#mbody").text("서버와의 접속 실패입니다.");
				$("#modal").trigger("click");
			}
		});
	});
});
</script>
</html>
