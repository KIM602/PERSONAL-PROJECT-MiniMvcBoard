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
<title>메인내의 Home</title>
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
</body>
</html>
