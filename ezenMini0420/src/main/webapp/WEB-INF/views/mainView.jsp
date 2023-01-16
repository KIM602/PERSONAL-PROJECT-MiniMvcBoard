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
<title>Main 레시피</title>
<!-- 그래픽표처리용 Chart.js API 라이브러리 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js"></script>
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
	<div id="hjumbo" class="jumbotron text-center mb-0 p-4">
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
				<a id="mHome" class="nav-link" href="home">
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
					<a id="eBoard" class="dropdown-item" href="eBoard">게시판</a>
					<a class="dropdown-item" href="qna">Q&A</a>
				</div>
			</li>
		
			<li class="nav-item">
				<a id="dashBoard" class="nav-link" href="dash">DashBoard</a>
			</li>
			
			<li class="nav-item">
				<a id="mUtil" class="nav-link" href="util">Utils</a>
			</li>
			
			<li class="nav-item">
				<a id=mAbout class="nav-link" href="about">About</a>
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
			
			<!-- Auth가 ROLE_ADMIN이면 활성화 -->
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
<!-- 메인 레시피화면 -->
<!-- 이페이지는 recipe의 첫 페이지 이므로 요리 리스트를 보여줌 -->
<div id="mainRegion" class="container mt-3">
	<a id="rwriteView" class="btn btn-success" href="rwriteView">레시피등록</a>
	<h3 class="text-center text-info">레시피</h3>
	<div class="row mb-4" >
		<c:forEach items="${recipeList}" var="dto">
			<div class="col-md-4" style="height:auto;">
				<div class="card">
					<h5 class="text-center">${dto.rClass}</h5> <!-- 요리구분 -->
					<img class="card-img-top" src="upimage/${dto.rPhoto}" alt="Card image" style="width:100%; height:280px; margin:auto;"/>
					<div class="card-body">
						<h5 class="card-title">식당명 : ${dto.rtrName}</h5>
						<h5 class="card-text">요리명 : ${dto.rTitle}</h5>
						<a href="recipeDetails?rId=${dto.rId}" class="pclick btn btn-primary stretched-link">자세히보기
						</a>
					</div>
				</div>
			</div>
		</c:forEach>
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
	//레시피 등록창
	$("#rwriteView").click(function(event){
		event.preventDefault();
		$.ajax({
			url : "rwriteView",
			type : "get",
			data : "",
			success : function(data) {
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!");
				$("#modal").trigger("click");
			}
		});
	});
	
	//상세정보 보기
	$(".pclick").click(function(event){
		event.preventDefault();
		let evo = $(event.target);
		let url = evo.attr("href");
		$.ajax({
			url : url,
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("레시피 상세정보창입니다.")
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!");
				$("#modal").trigger("click");
			}
		});
	});
});

	$(document).ready(function(){
		$("#adminView").click(function(event){
			event.preventDefault();
			$.ajax({
				url : "adminView",
				type : "get", 
				data : "",
				success : function(data) {
					$("#hjumbo").text("관리자페이지 입니다..");
					$("#mainRegion").html(data);
				},
				error : function(data) {
					$("#mbody").text("서버와의 접속 실패입니다.");
					$("#modal").trigger("click");
				}
			});
		});
		
		$("#mHome").click(function(event){
			event.preventDefault();
			$.ajax({
				url : "mHome",
				type : "get",
				data : "",
				success : function(data) {
					$("#hjumbo").text("관리자페이지 입니다..");
					$("#mainRegion").html(data);
				},
				error : function(data) {
					$("#mbody").text("서버와의 접속 실패입니다.");
					$("#modal").trigger("click");
				}
			})
		});
		
		$("#eBoard").click(function(event){
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
		
		$("#mUtil").click(function(event){
			event.preventDefault();
			$.ajax({
				url : $("#mUtil").attr("href"),
				type : "get",
				data : "",
				success : function(data) {
					$("#hjumbo").text("Utility모음 입니다.");
					$("#mainRegion").html(data);
				},
				error : function(data) {
					$("#mbody").text("서버와의 접속 실패입니다.");
					$("#modal").trigger("click");
				}
			});
		});
		
		$("#mAbout").click(function(event){
			event.preventDefault();
			$.ajax({
				url : $("#mAbout").attr("href"),
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
		
		$("#dashBoard").click(function(event){
			event.preventDefault();		
			$.ajax({
				url : $("#dashBoard").attr("href"),
				type : "get",
				data : "",
				success : function(data) {
					$("#hjumbo").text("DashBoard페이지 입니다.");
					$("#mainRegion").html(data);
				},
				error : function() {
					$("#mbody").text("서버접속 실패!.");
					$("#modal").trigger("click");	
				}
			});
		});	
	});
</script>
</body>
</html>
