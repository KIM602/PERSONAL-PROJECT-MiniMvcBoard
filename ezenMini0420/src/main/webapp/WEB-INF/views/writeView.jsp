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
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<title>글 작성</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
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

<h3 class="text-center">게시판 작성</h3>
<form action="bWrite" method="post" id="fwrite">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="form-group">
		<label for="uname">이름:</label>
		<input type="text" class="form-control" id="uname" name="bName" required value="${user_id}" readonly />
	</div>
	<div class="form-group">
		<label for="title">제목:</label>
		<input type="text" class="form-control" id="title" placeholder="Enter Title" name="bTitle" required/>
	</div>
	<div class="form-group">
		<label for="content">내용:</label>
		<textarea class="form-control" name="bContent" id="content" placeholder="Enter Content" rows="10"></textarea>
	</div>
	<button type="submit" class="btn btn-success">작성</button>
	<a id="writelink" href="eBoard" class="btn btn-primary">목록보기</a>
</form>

<script>
$(document).ready(function(){
	$("#fwrite").submit(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#fwrite").attr("action"),
			type : "post",
			data : $("#fwrite").serialize(),
			success : function(data) {
				$("#hjumbo").text("리스트창입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!");
				$("#modal").trigger("click");
			}
		});
	});
	
	$("#writelink").click(function(event){
		event.preventDefault();
		$.ajax({
			url : "eBoard",
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("리스트창입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!");
				$("#modal").trigger("click");
			}
		});
	});
	
});
</script>
</body>
</html>
