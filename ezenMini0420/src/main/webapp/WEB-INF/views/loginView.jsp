<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
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
<style>
html, body {
	height: 2000px;
	margin: 0px;
	padding: 0px;
}

.navbar {
	border-radius: 0px;
	margin-bottom: 0px;
}
.carousel-inner img {
    width: 100%;
    height: 100%;
  }
 
.fakeimg {
	height: 200px;
	background: #aaaaaa;
}
#mainRegion {
	height: auto;
}
</style>
</head>
<body>
<!-- 로그인 id반환 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id"/>
</sec:authorize>

<div class="container mt-1 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h3>Homepage로 BS4, jQuery, Ajax를 이용하고 있습니다.</h3>
	</div>
</div>

<nav class="navbar navbar-expand-md bg-dark navbar-dark container sticky-top font-weight-bold">
	<a class="navbar-brand" href="#">
		<img src="images/bird.jpg" alt="logo" style="width:40px" />
	</a>
	
	<!-- 콜랩스용 버튼(화면 축소시 생기는 상병 계급장 표시) -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="home">
					<i class="fas fa-home" style="font-size:30px; color:white;"></i>
				</a>
			</li>
			
			<li class="nav-item">
				<a class="nav-link" href="place">Hot Place</a>
			</li>
			
			<li class="nav-item">
				<a class="nav-link" href="main">Hot Recipe</a>
			</li>
			
			<li class="nav-item">
				<a class="nav-link" href="pet">Hot pet</a>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">알림판</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="notice">공지사항</a>
					<a class="dropdown-item" href="board">게시판</a>
					<a class="dropdown-item" href="qna">Q&A</a>
				</div>
			</li>

			<li class="nav-item">
				<a class="nav-link" href="dash">DashBoard</a>
			</li>
			
			<li class="nav-item">
				<a class="nav-link" href="util">Utils</a>
			</li>
			
			<li class="nav-item">
				<a class="nav-link" href="about">About</a>
			</li>
			
			<sec:authorize access="isAnonymous()">
				<li class="nav-item">
					<a id="joinView" class="nav-link" href="joinView">회원가입</a>
				</li>
			</sec:authorize>
			
			<sec:authorize access="isAuthenticated()">
				<li class="nav-item">
					<a class="nav-link" href="#">${user_id}</a>
				</li>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li class="nav-item">
					<a id="adminView" class="nav-link" href="adminView">Admin</a>
				</li>
			</sec:authorize>
		</ul>
		
		<ul class="navbar-nav ml-auto">
			<sec:authorize access="isAnonymous()"> <!-- 로그인 안한 상태면 로그인 버튼 보임 -->
				<li class="nav-item">
					<a class="nav-link" href="loginView">로그인</a>
				</li>
			</sec:authorize>
			
			<sec:authorize access="isAuthenticated()"> <!-- 로그인 한 상태면 로그아웃 버튼 보임 -->
				<li class="nav-item">
					<a class="nav-link" href="logoutView">로그아웃</a>
				</li>
			</sec:authorize>
		</ul>
	</div>
</nav>

<div class="container border border-secondary p-0">
	<div id="demo" class="carousel slide" data-ride="carousel" data-interval="4000">
	<ul class="carousel-indicators">
    		<li data-target="#demo" data-slide-to="0" class="active"></li>
    		<li data-target="#demo" data-slide-to="1"></li>
    		<li data-target="#demo" data-slide-to="2"></li>
  	</ul>
  	
  	  <div class="carousel-inner margin-top">
    		<div class="carousel-item active">
      			<img src="https://bootstrapious.com/tutorial/carousel/img/carousel1.jpg"  class="img-fluid" alt="chania" >
      				<div class="carousel-caption">
        				<h3>Carousel in a container</h3>
       					 <p>This is a demo for the Bootstrap Carousel Guide.</p>
      				</div>   
    		</div>
    		<div class="carousel-item">
      			<img src="https://bootstrapious.com/tutorial/carousel/img/carousel2.jpg" class="img-fluid" alt="flower" >
      				<div class="carousel-caption">
        				<h3>SKY</h3>
        				<p>We love Sky!</p>
      				</div>   
    		</div>
    		<div class="carousel-item">
      			<img src="https://bootstrapious.com/tutorial/carousel/img/carousel3.jpg"alt="flower2" class="img-fluid">
      				 <div class="carousel-caption">
        				<h3>MOUNTAIN</h3>
        				<p>We love mountain!</p>
      				</div>   
    		</div>
	</div>
	
			<a class="carousel-control-prev" href="#demo" data-slide="prev">
    			<span class="carousel-control-prev-icon"></span>
  			</a>
  			<a class="carousel-control-next" href="#demo" data-slide="next">
    			<span class="carousel-control-next-icon"></span>
  			</a>
	</div>
</div>

<!-- ajax로 처리시 나타내줄 메인 페이지 영역 -->
<div id="mainRegion" class="container mt-3">
	<h3>${kakao_url}</h3>
	<h3 class="text-center text-info">로그인</h3>
	<div id="div1" class="text-center text-danger mb-3"></div>
	<!-- 로그인 관련 메세지를 서버에서 받아 작성 -->
	<form id="frm1" name="frm1" method="post" action="login">
		<!-- security에서 action은 login으로 기본설정하면 컨트롤러로 요청하는게 아니고 security의
				login-processing-url = "/login"으로 요청 -->
		<!-- csrf를 방지하기위한 헤더부분을 숨겨서 추가 -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="form-group">
			<label for="uId">아이디</label>
			<input type="email" class="form-control" name="pid" placeholder="E-mail 주소입력" id="uId" required/>
		</div>
		<div class="form-group">
			<label for="uPw">비밀번호</label>
			<input type="password" class="form-control" name="ppw" id="uPw" placeholder="비밀번호 입력" required/>
		</div>
		<!-- 로그아웃 안하고 접속 단절 후 일정시간 로그인 없이 재접속 -->
		<div class="form-group form-check">
			<input type="checkbox" class="form-check-input" id="remeberMe" name="remember-me" checked/>
			<label class="form-check-label" for="remeberMe" aria-describedby="rememberMeHelp">remember-me</label><br />
			<!-- aria-describedby는 스크린리더에서 설명을 할 내용 -->
			<button type="submit" class="btn btn-success">로그인</button>
		</div>
	</form>
	<div class="d-flex mt-4 m-auto" style="width:21%;">
		<a id="klog" href="${kakao_url}" class="btn btn=primary">
			<img width="50" src="images/k_logo.png"/>
		</a>&nbsp;
		<a id="nlog" href="${naver_url}" class="btn btn=primary">
			<img width="50" src="images/n_logo.png"/>
		</a>&nbsp;
		<a id="glog" href="${google_url}" class="btn btn=primary">
			<img width="50" src="images/g_logo.png"/>
		</a>
	</div>
</div>

<!-- modal -->
<div class="container mt-3">
	<button id="modal" type="button" class="btn btn-primary d-none" data-toggle="modal" data-target="#myModal">
		Open modal
	</button>
</div>

<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header bg-info">
				<h4 class="modal-title multiEffect"><i class="fa fa-info-circle" aria-hidden="true">Info</i></h4>
				<button type="button" class="close mclose" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<h4 id="mbody" class="text-center multiEffect">가입을 축하합니다</h4>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary mclose" data-dismiss="modal">Close</button>
			</div>
		</div>		
	</div>
</div>

<!-- footer영역 -->
<footer class="container mt-5 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h3 class="text-center">Online Store Copyright</h3>
		<form action="#" method="POST">
			<div class="form-group">
				<label for="email">&nbsp;&nbsp;Get deals</label>
				<input type="email" class="form-control" placeholder="Enter email" id="email"/>
			</div>
			<button type="submit" class="btn btn-danger">Sign up</button>
		</form>
	</div>
</footer>
<script>
$(document).ready(function name() {
	<c:choose>
		<c:when test="${not empty log}">
			$("#div1").text("Welcome!!");
		</c:when>
		<c:when test="${not empty logout}">
			$("#div1").text("getOut!");
		</c:when>
		<c:when test="${not empty error}"> // 로그인실패시
			$("#div1").text("fail!");
		</c:when>
		<c:otherwise>
			$("#div1").text("welcome!"); // 로그인 성공시
		</c:otherwise>
	</c:choose>
});

$(document).ready(function(){
	$("#joinView").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#joinView").attr("href"),
			type : "get", 
			data : "",
			success : function(data) {
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
</body>
</html>
