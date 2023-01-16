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
<title>레시피 등록</title>
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
<h3 class="text-center">요리 등록</h3>
	<!-- file보내기시는 csrf를 action 뒤에 주고 enctype을 주어야 함 -->
	<form action="recipeWrite?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
		<h5>레시피 구분</h5>
		<div class="form-check-inline">
			<label class="form-check-label" for="radio1">
				<input type="radio" class="form-check-input" id="radio1" name="rClass" value="Korean" checked />한식
			</label>
		</div>
		<div class="form-check-inline">
			<label class="form-check-label" for="radio2">
				<input type="radio" class="form-check-input" id="radio2" name="rClass" value="Japanese" />일식
			</label>
		</div>
		<div class="form-check-inline">
			<label class="form-check-label" for="radio3">
				<input type="radio" class="form-check-input" id="radio3" name="rClass" value="Chinese" />중식
			</label>
		</div>
		<div class="form-check-inline">
			<label class="form-check-label" for="radio4">
				<input type="radio" class="form-check-input" id="radio4" name="rClass" value="Europe" />양식
			</label>
		</div>
		<div class="form-check-inline">
			<label class="form-check-label" for="radio5">
				<input type="radio" class="form-check-input" id="radio5" name="rClass" value="Fusion" />퓨전
			</label>
		</div>
		<br /><br />
		<div class="form-group">
			<label for="rname">식당명</label>
			<input type="text" class="form-control" id="rname" placeholder="식당명" name="rtrName"  required/>
		</div>
		
		<div class="form-group">
			<label for="title">요리이름</label>
			<input type="text" class="form-control" id="title" placeholder="레시피명" name="rTitle"  required/>
		</div>
		
		<div class="form-group">
			<label for="photo">레시피사진</label>
			<input type="file" class="form-control" id="photo" placeholder="레시피 사진" name="rPhoto"  required/>
		</div>
		
		<div class="form-group">
			<label for="content">요리설명</label>
			<textarea class="form-control" name="rContent" id="content" placeholder="레시피 설명"  rows="10"  required></textarea>
		</div>
		
		<button type="submit" class="btn btn-success">레시피 등록</button>&nbsp;&nbsp;
		<a href="main" class="btn btn-primary">목록보기</a>
	</form>
</body>
</html>
