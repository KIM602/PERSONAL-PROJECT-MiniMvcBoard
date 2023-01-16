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

<h3 class="text-center">서버 센트 이벤트</h3>
<button type="button" id="sebtn" class="btn btn-primary">싱글이벤트</button>&nbsp;&nbsp;
<button type="button" id="mebtn" class="btn btn-primary">멀티이벤트</button>&nbsp;&nbsp;
<br /><br />
<!-- 이벤트 출력창 -->
<h4 class="text-center">싱글이벤트 내용</h4>
<div id="sseDisp1"></div>
<h4 class="text-center">멀티이벤트 내용1</h4>
<div id="sseDisp2"></div>
<h4 class="text-center">멀티이벤트 내용2</h4>
<div id="sseDisp3"></div>

<script>
$(document).ready(function(){
	$("#sebtn").click(function(){
		//이벤트소스를 받기위한 이벤트소스 객체 생성
		let eventSource = new EventSource("seventEx"); //seventEx는 컨트롤러의 경로
		eventSource.onmessage = function(event) { //이벤트 업데이트마다 message이벤트 발생, event객체는 서버의 이벤트내용 객체
			$("#sseDisp1").text(event.data);
		}
	});
	
	$("#mebtn").click(function(){
		//이벤트소스를 받기위한 이벤트소스 객체 생성
		let eventSource = new EventSource("meventEx"); //seventEx는 컨트롤러의 경로
		eventSource.addEventListener("upVote",function(event){
			 
		},false);
		//upVote는 서버에서 정한 이벤트 종류, 이벤트 처리 필수, false는 캡쳐링으로 버블링 방식
	});
});
</script>

</body>
</html>
