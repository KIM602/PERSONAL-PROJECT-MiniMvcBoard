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
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<title>Home</title>
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
/*브라우저별 상이함을 통일*/
html, body {
	height: 2000px;
	margin: 0px;
	padding: 0px;
}
#mainRegion {
	heihgt: auto;
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
</style>
</head>
<body>

<!-- 로그인 id반환 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id"/>
</sec:authorize>

<div class="container mt-1 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h3>Homepage로 BS4, jQuery, Ajax를 이용하고 있으며 서버는 spring, security, mybatis, oracle을 사용합니다.</h3>
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
				<a id="about" class="nav-link" href="about">About</a>
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
	<div class="row">
		<div class="col-sm-4">
				<h2>오늘의 hot place</h2>
				<h5>Photo of me:</h5>
				<div class="fakeimg">
					<img src="data:image/png;base64,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" style="width:100%; height:200px;">
				</div>
				<p>My name is 602. <br/>
				I'm twenty-nine years old.
				</p>
				<h3>Some Links</h3>
				<p>수직메뉴 만들기</p>
				<div>
				<ul class="nav nav-pills flex-column">
					<li class="nav-item">
						<a class="nav-link active" href="#">Link</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">Link</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">Link</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">Link</a>
					</li>
				</ul>
			</div>
		</div>
	
	<div class="col-md-8">
				<h2>오늘의 hop recipe</h2>
				<h5>Title description, Dec 7, 2017</h5>
				<div class="fakeimg">
					<img src="https://t1.daumcdn.net/cfile/tistory/99531D415E170D2918?original" alt=""  class="w-100 h-100"/>
				</div>
				<p>Some text..</p>
				<p>Some text.. Some text.. Some text..</p>
				<br />
				<h2>오늘의 hot pet</h2>
				<h5>Title description, Dec 7, 2017</h5>
				<div class="fakeimg">
					<img src="https://t1.daumcdn.net/cfile/tistory/9918BA415E170D2B1B?original" alt=""  class="w-100 h-100"/>
				</div>
				<p>Some text..</p>
				<p>Some text.. Some text.. Some text..</p>
				<br />
		</div>
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
	
	$("#about").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#about").attr("href"),
			type : "get", 
			data : "",
			success : function(data) {
				$("#mainRegion").html(data);
				$("#hjumbo").text("우리 회사의 정보창입니다.")
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
