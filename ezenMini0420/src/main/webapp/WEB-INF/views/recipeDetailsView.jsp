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

<div class="row mt-5">
	<div class="col-sm-4 border border-secondary">
		<img src="upimage/${rDetails.rPhoto}" alt="사진" class="mx-auto img-responsive mt-4" 
		style="max-width:100%; height:400px;"/>
	</div>
	<div class="col-sm-4">
		<h3 class="text-center">${rDetails.rClass}</h3>
		<h3 class="text-center">${rDetails.rtrName}</h3>
		<h3 class="text-center">${rDetails.rTitle}</h3>
		<h3 class="text-center">${rDetails.rContent}</h3>
		<h3 class="text-center">28000원</h3> <!-- 나중 DB에 rPrice추가 -->
		<br />
		<form action="#" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input type="hidden" name="rId" value="${rDetails.rId}"/>
			<div class="form-group text-center">
				<h3>
					<label for="uOrder">주문수량</label>
					<input type="number" class="form-control" id="uOrder" name="quanty" placeholder="주문수량을 입력하세요" />
				</h3>
			</div>
			<p class="text-center"><button type="submit" class="btn btn-success">주문</button></p>
		</form>
		<p class="text-center"><a href="main" class="btn btn-danger">목록으로</a></p>
	</div>
	<div class="col-sm-4">
		<h3 class="text-center">GEOLOCATION 학습 후 지도표시(DB에 주소 rAddress 추가 필요)</h3>
	</div>
</div>
</body>
</html>
