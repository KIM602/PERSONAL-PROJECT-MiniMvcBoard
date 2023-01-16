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
<title>Full Calendar</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- full calendar용 api라이브러리 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.2/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.2/main.min.css' rel='stylesheet'/>
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
	<sec:authentication property="principal.username" var="userId"/>
</sec:authorize>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="container mt-1 p-0">
	<div id="hjumbo" class="jumbotron text-center mb-0 p-4">
		<h3>FullCalendar를 활용한 스케줄러로 spring security서버와 연동되어 활용합니다</h3>
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
				<a class="nav-link" href="dash">DashBoard</a>
			</li>
			
			<li class="nav-item">
				<a id="mUtil" class="nav-link" href="util">Utils</a>
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
<div id="mainRegion" class="container mt-5 p-0">
	<div id="calendar"></div> <!-- full calendar표시영역 -->
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
//EL과 c:out은 화면에 보이는 그대로의 값이므로 JS에 문자열 변수를 나타낼시는 ""안에 사용
//가능하면 EL만 사용하는 것보다는 c:out이 보안에 강하다
let calendar = null;
let user_id = '<c:out value="${userId}"></c:out>';
$(document).ready(function() {
	$(function() { // jquery에서 자동 실행 함수
		let request = $.ajax({ //calendar로 요청한 결과를 저장하는 변수 request(list가능)
			url : "calendar?cId=${userId}",
			type : "get",
			dataType : "json"
			
		})
		request.done(function(data) { //request수행 마지막 작업 처리, data는 반환된 값으로 js객체형 배열
			console.log(data);
			let calendarE1 = document.getElementById('calendar');  // 캘린더를표시하는 div 엘리먼트
			calendar = new FullCalendar.Calendar(calendarE1,{
				timeZone : "Asia/Seoul",
				headerToolbar : {
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
				},
				navLinks : true,
				editable : true,
				selectable : true,
				droppable : true,
				eventDrop : function name(info) {
					let obj = new Object();
					if(confirm("'"+info.event.title + "'의 일정을 수정하시겠습니까?")){ // confirm 메서드 확인 누르면 true가 됨
						obj.cTitle = info.event._def.title;
						obj.cStart = info.event._instance.range.start;
						obj.cEnd = info.event._instance.range.end;
						obj.cAllDay = info.event._instance.range.allDay;
						obj.cNo = info.event.extendedProps.cNo; // 추가된 속성,fullcalendar 데이터베이스의 구분번호
						obj.cId = user_id; // 사용자 아이디
						obj.oldTitle = info.oldEvent._def.title;
						obj.oldStart = info.oldEvent._instance.range.start;
						obj.oldEnd = info.oldEvent._instance.range.end;
						obj.oldAllDay = info.oldEvent._instance.range.allDay;
						console.log(obj);
						$(function modifyData() {
							$.ajax({
								url : "calendarUpdate",
								method : "post",
								dataType : "json",
								data : JSON.stringify(obj),
								contentType : 'application/json',
								beforeSend : function name(xhr) {
									xhr.setRequestHeader('X-CSRF-Token',$('input[name="${_csrf.parameterName}"]').val());
									
								}
							});
						})
					}
					else {
						info.revert(); // 원래 창 유지
					}
					location.reload(); //화면 갱신
					calendar.unselect();					
				},
				
				eventResize : function name(info) { // drag기능(수정)
					console.log(info);
					var obj = new Object();
					if(confirm("'" + info.event.title + "' 의 일정을 수정하시겠습니까?")) {
						obj.cTitle = info.event._def.title;
						obj.cStart = info.event._instance.range.start;
						obj.cEnd = info.event._instance.range.end;
						obj.cAllDay = info.event._instance.range.allDay;
						obj.cNo = info.event.extendedProps.cNo; // 추가된 속성,fullcalendar 데이터베이스의 구분번호
						obj.cId = user_id; // 사용자 아이디
						obj.oldTitle = info.oldEvent._def.title;
						obj.oldStart = info.oldEvent._instance.range.start;
						obj.oldEnd = info.oldEvent._instance.range.end;
						obj.oldAllDay = info.oldEvent._instance.range.allDay;
						console.log(obj);
						$(function modifyData(){
							$.ajax({
								url : "calendarUpdate",
								type : "post",
								dataType : "json",
								data : JSON.stringify(obj),
								contentType : 'application/json',
								beforeSend : function(xhr) {
									xhr.setRequestHeader('X-CSRF-Token',$('input[name="${_csrf.parameterName}"]').val());
								}
							});
						});
					}
					else {
						info.revert();
					}
					location.reload(); //화면 갱신
					calendar.unselect();
				},
				select : function name(arg) { // insert기능(작성 기능)
					var title = prompt("일정명을 기록하고 일정을 선택하세요.");
					if(title) {
						calendar.addEvent({
							title : title, // 입력한 값 title을 title속성에
							start : arg.start,
							end : arg.end,
							allDay : arg.allDay // boolean형태임
						});
						console.log("아그먼트값"+arg);
						var obj = new Object();
						obj.cNo = 100;
						obj.cId = user_id;
						obj.cTitle = title;
						obj.cStart = arg.start;
						obj.cEnd = arg.end;
						if(arg.allDay == true) { // 여기서는 arg.allday가 boolean형태이므로 문자열로 바꿔서 보내줌 (DB에는 boolean이없음)
							obj.cAllDay = "true"; 
						}
						else{
							obj.cAllDay = "false";
						}
						console.log(obj);
						$(function saveData() {
							$.ajax({
								url : "calendarInsert",
								type : "post",
								dataType : "json",
								data : JSON.stringify(obj),
								contentType : 'application/json',
								beforeSend : function name(xhr) {
									xhr.setRequestHeader('X-CSRF-Token',$('input[name="${_csrf.parameterName}"]').val());
								}	
							})	
						})
					}
					else{
						info.revert(); // 원래 창 유지
					}
				},
				eventClick : function name(info) { // 작성된 일정을 클릭하는 기능으로 제거 기능
					if(confirm("'" + info.event.title + "' 일정을 삭제하시겠습니까? ")) {
						info.event.remove();
						console.log(info.event);
						var obj = new Object();
						obj.cTitle = info.event._def.title;
						obj.cStart = info.event._instance.range.start;
						obj.cEnd = info.event._instance.range.end;
						obj.cAllDay = info.event._instance.range.allDay;
						obj.cNo = info.event.extendedProps.cNo; // 추가된 속성,fullcalendar 데이터베이스의 구분번호
						obj.cId = user_id; // 사용자 아이디
						console.log(obj);
						$(function deleteData(){
							$.ajax({
								url : "calendarDelete",
								type : "post",
								dataType : "json",
								data : JSON.stringify(obj),
								contentType : 'application/json',
								beforeSend : function(xhr) {
									xhr.setRequestHeader('X-CSRF-Token',$('input[name="${_csrf.parameterName}"]').val());
								}	
							});
						});
					}
					else {
						location.reload();
					}
				},
				locale : 'ko',
				events : data // 받은 결과값(js객체 배열값)을 저장하는 객체
			}); 
			calendar.render();
		});
	});
});

</script>
</body>
</html>
