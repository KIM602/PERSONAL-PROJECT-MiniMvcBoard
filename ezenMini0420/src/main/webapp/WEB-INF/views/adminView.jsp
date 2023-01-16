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
<title>admin</title>
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
<h3 class="text-center">관리자페이지</h3>
<h3 id="authText" class="text-center"></h3>
<form action="authAdmin" method="post" id="authForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="form-group">
		<label for="uId">아이디</label>
		<input type="email" class="form-control" name="pid" placeholder="E-mail 주소입력" id="uId" required/>
	</div>
	<div class="form-check-inline">
		<label class="form-check-label" for="radio1">
			<input type="radio" class="form-check-input" id="radio1" name="auth" value="ROLE_USER" checked />회원
		</label>
	</div>
	<div class="form-check-inline">
		<label class="form-check-label" for="radio2">
			<input type="radio" class="form-check-input" id="radio2" name="auth" value="ROLE_MANAGE" checked />매니저
		</label>
	</div>
	<div class="form-check-inline">
		<label class="form-check-label" for="radio3">
			<input type="radio" class="form-check-input" id="radio3" name="auth" value="ROLE_ADMIN" checked />총책임자
		</label>
	</div>
	<p><button type="submit" class="btn btn-success">권한 등록</button></p>
</form>

<script>
$(document).ready(function(){
	$("#authForm").submit(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#authForm").attr("action"),
			type : $("#authForm").attr("method"),
			data : $("#authForm").serialize(),
			success : function(data) {
				if(data.search("success") > -1) {
					$("#authText").text("권한등록 성공");
				}
				else
					$("#authText").text("권한등록 실패")
			},
			error : function(data) {
				$("#mbody").text("서버와의 접속 실패입니다.");
				$("#modal").trigger("click");
			}
		});
	});
});
</script>
</body>
</html>
