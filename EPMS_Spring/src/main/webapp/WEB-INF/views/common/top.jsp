<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/main.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
</head>
<body>
	<!-- top 부가기능 -->
	<nav class="navbar navbar-expand-sm navbar-light bg-white">
		<div class="nav-top-div">
			<div class="container"> 
				<ul class="navbar-nav nav-top" >
					<c:if test="${sessionScope.dto.id == null}">
						<li class="nav-item top_side" style="width: fit-content;">
							<a href="../login/login.do">로그인</a>&nbsp;&nbsp;|&nbsp;&nbsp;
						</li>
					</c:if>
					<c:if test="${sessionScope.dto.id != null}">
						<li class="nav-item top_loginState">
							<img src="${pageContext.request.contextPath}/resources/upload/${sessionScope.dto.profile_img}" width="25px" height="25px">
							<a>${sessionScope.dto.nickname}</a>
						</li>&nbsp;&nbsp;
						<li class="nav-item top_side" style="width: fit-content">
							<a href="../login/logout.do">로그아웃</a>&nbsp;&nbsp;|&nbsp;&nbsp;
						</li>
					</c:if>
					<li class="nav-item top_side" style="width: fit-content;"><a href="../freeboardDetail/chat.do">고객센터</a>&nbsp;&nbsp;|&nbsp;&nbsp;</li>
					<li class="nav-item top_side" style="width: fit-content;"><a href="#">이용안내</a> </li>
				</ul>
			</div>
		</div>		
	</nav>

	<!-- 네비게이션 바 -->
	<nav class="navbar nav navbar-expand-xl navbar-light bg-dark">
		<a class="navbar-brand mb-0 text-warning" href="../main/main.do"><img class="img-fluid" src="../resources/images/mainIcon/navlogo1.png" width="250"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    	<span class="navbar-toggler-icon"></span>
		</button>
		
	  	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	    	<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<div class="dropdown">
					  <a class="dropdown-toggle nav-link text-white" href="" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					  	Home 
					  </a>
					  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					    <a class="dropdown-item" href="#">Action</a>
					    <a class="dropdown-item" href="#">Another action</a>
					    <a class="dropdown-item" href="#">Something else here</a>
					  </div>
					</div>
				</li>
	     		<li class="nav-item">
	        		<a class="nav-link text-white" href="../freeboard/freeboard.do">&nbsp;&nbsp;|&nbsp;&nbsp; FreeBoard &nbsp;&nbsp;|&nbsp;&nbsp;</a>
	      		</li>
	      		<li class="nav-item">
	        		<a class="nav-link disabled text-muted">Disabled</a>
	      		</li>
	    	</ul>
	  	</div>
	</nav>
	
<!-- wrap end -->

<!-- script -->
 	<script src="../resources/js/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="../resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="../resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
</body>
</html>