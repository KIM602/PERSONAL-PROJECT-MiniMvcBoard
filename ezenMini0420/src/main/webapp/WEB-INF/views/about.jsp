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
<style>
#searchPanel {
	width: 65%;
	position: relative;
	top: 60px;
	z-index: 5;
	background-color: #FFFFFF;
	padding: 5px;
	margin: auto;
}

#address {
	padding: 10px;
}

#googleMap {
	width: 100%;
	height: 600px;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>

<h3 class="text-center">About</h3>
<div id="searchPanel"> <!-- 지도에서 주소로 위치를 찾는 위치 입력창 -->
	<input type="text" id="address" placeholder="주소를 입력하세요" size="70px"/>
	<button id="submit" type="button" class="btn btn-primary" value="Geocode">지도검색</button>
</div>
<div id="googleMap" class="mx-auto mb-5"></div> <!-- 구글 지도 표시 영역 -->

<!-- 연락처 정보 -->
<div class="row">
	<div class="col-md-4 d-flex flex-column"> <!-- d-flex는 flex형식으로 배치 flex-column 수직배치 -->
		<div class="d-flex flex-row"> <!-- flex-row는 수평배치 -->
			<div>
				<i class="fa fa-home" aria-hidden="true"></i> <!-- aria-hidden은 스크린리더 제한 기능 -->
			</div>
			<div>
				<h5>Binghamton, New York</h5>
				<p>4343 Hinkle Deegan Lake Road</p>
			</div>
		</div>
		<div class="d-flex flex-row">
			<div>
				<i class="fa fa-headphones" aria-hidden="true"></i>
			</div>
			<div>
				<h5>00 (958) 9865 562</h5>
				<p>Mon to Fri 9am to 6pm</p>
			</div>
		</div>
		<div class="d-flex flex-row">
			<div>
				<i class="fa fa-envelope" aria-hidden="true"></i>
			</div>
			<div>
				<h5>support@colorlib.com</h5>
				<p>Send us your query anytime!</p>
			</div>
		</div>
	</div>
	<div class="col-md-8">
		<form class="text-right" id="myForm" action="" method="post">
			<div class="row">
				<div class="col-md-6 form-group"> <!-- 그리스 6칸 차지함 -->
					<input type="text" name="name" placeholder="Enter your name" onfocus="this.placholder = ''"
						onblur="this.placeholder = 'Enter your name'" class="mb-20 form-control"/>
					<input type="email" name="email" placeholder="Enter email address" pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{1,63}$"
					onfocus="this.placholder = ''" onblur="this.placeholder = 'Enter your name'" class="mb-20 form-control"/> <!-- pattern은 입력형식을 regEx(정규식)으로 지정 -->
					<input type="text" name="subject" placeholder="Enter subject" onfocus="this.placholder = ''"
						onblur="this.placeholder = 'Enter your name'" class="mb-20 form-control"/>
				</div>
				<div class="col-md-6 form-group"> <!-- 그리드 6칸 -->
					<textarea class="form-control" name="message" placeholder="Enter Message" onfocus="this.placholder = ''" onblur="this.placeholder = 'Enter your name'" rows="5"></textarea>
				</div>
				<div class="col-md-12"> <!-- 총 그리드 수가 12를 넘었으므로 다음줄에 생김 -->
					<div style="text-align: left;"></div>
					<button class="btn btn-primary" style="float: right;">Send Message</button>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- 개발자가 구현하는 부분 -->
<script>
//Google Map API 주소의 callback 파라미터와 동일한 이름의 함수이다.
//Google Map API에서 콜백으로 실행시킨다.
function initMap() {
	console.log('Map is initialZized.');
	let map;
	getLocation();
	function getLocation() {
		if(navigator.geolocation) {
			navigator.geolocation.watchPosition(showPosition);
			//watchPosition(showPosition)은 이동시 사용자의 위치를 계속하여 업데이트 하며 반환
			//getCurrentPosition(showPosition)는 이용자의 위치반환
			//리턴값은 파라메터인 showPosition()함수에 좌표를 반환해 준다
			//clearWatch()는 중단
		}
		else {
			map = $("#googleMap");
			map.text("Geolocation is not supported by this browser.");
		}
	}
	
	function showPosition(position) {
		//watchPosition(showPosition)의 콜백함수
		lati = position.coords.latitude; //위도
		longi = position.coords.longitude; //경도
		//지도를 표시해줄 객체는 지도를 표시할 객체와 배율, 중앙에 보여줄 위치를 파라메터로 하여 생성
		map = new google.maps.Map(document.getElementById('googleMap'),{
			zoom: 16, //배율
			center: new google.maps.LatLng(lati,longi) //중앙위치 LatLng(위도, 경도)는 위치를 표시
		});
		//위치를 표시해 주는 아이콘
		let marker = new google.maps.Marker({
			position: new google.maps.LatLng(lati,longi),
			map: map,
			title: 'Hello World!' //마커에 붙는 글자
		});
	}
	
	//Google Geocoding을 사용하여 Google Map API에 포함되어 있으며 번지를 지도위 위치로 변경
	let geocoder = new google.maps.Geocoder();
	//번지 입력후 submit 버튼 클릭 이벤트 실행
	document.getElementById('submit').addEventListener('click', function(){
		console.log('submit 버튼 클릭 이벤트 실행');
		geocodeAddress(geocoder, map);
	});
	
	function geocodeAddress(geocoder, resultMap) {
		console.log('geocodeAddress 함수 실행');
		let address = document.getElementById('address').value;
		//geocoder.geocode()메서드는 입력받은 주소로 좌표에 맵 마커를 찍는다.
		//파라메터는 입력받은 주소값과 콜백함수, 주소는 JSON 객체 형식
		geocoder.geocode({'address' : address},function(result,status){
			console.log(result);
			console.log(status);
				if (status === 'OK') {
					resultMap.setCenter(result[0].geometry.location); //주소에 의해 변경된 위치값을 중앙으로 설정
					resultMap.setZoom(18); //맵의 확대 정도를 설정한다.
					//마커설정
					let marker = new google.maps.Marker({
						map: resultMap,
						position: result[0].geometry.location,
						title: 'Hello World!'
					});
					console.log('위도(latitude) : ' + marker.position.lat());
					console.log('경도(longitude) : ' + marker.position.lng());
				}
				else {
					alert('지오코드가 다음의 이유로 성공하지 못했습니다 : ' + status);
				}
		});
	}
}
</script>

<!--
async의 defer는 백그라운드에서 다운로드를 하여 html파싱을 방해하지 않음
defer는 html파싱이 종료시까지 실행을 멈춤
async는 실행시에는 html파싱이 멈춤
-->

<!-- 구글맵의 map자바스크립트를 가져오는 부분 -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB-Iyv44CvpHGEx1zTYvED8bxLIPQjdfnc&callback=initMap&v=weekly&channel=2">
</script>

</body>
</html>
