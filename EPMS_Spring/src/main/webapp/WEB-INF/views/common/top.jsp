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
<style>
	.collapse .nav-item {
		margin-left: 20%; 
	}
	
	.collapse .nav-item a {
		width: max-content;
	}

	a {
	  text-decoration: none;
	  color: inherit;
	}
	
	* {
	  box-sizing: border-box;
	}
	
	.menu {
	  display: block;
	  position: relative;
	  cursor: pointer;
	}
	
	.menu-title {
	  display: block;
	  width: fit-content;
	  height: 40px;
	  background: #9dc852;
	  text-align: center;
	  color: black;
	  font-weight: bold;
	  border-radius: 10px; 
	  transition: 0.3s background-color;
	}
	
	.menu-title:before {
	  content: "";
	  display: block;
	  height: 0;
	  border-top: 5px solid #9dc852;
	  border-left: (150px / 2) solid transparent;
	  border-right: (150px / 2) solid transparent;
	  border-bottom: 0 solid #dddddd;
	  position: absolute;
	  top: 100%;
	  left: 0;
	  z-index: 101;
	  transition:
	    0.2s 0.2s border-top ease-out,
	    0.3s border-top-color;
	}
	
	.menu-title:hover { background: #8db842; }
	.menu-title:hover:before { border-top-color: #8db842; }
	
	.menu:hover > .menu-title:before {
	  border-top-width: 0;
	  transition:
	    0.2s border-top-width ease-in,
	    0.3s border-top-color;
	}
	
	.menu-title:after {
	  content: "";
	  display: block;
	  height: 0;
	  border-left: (150px / 2) solid transparent;
	  border-right: (150px / 2) solid transparent;
	  border-bottom: 0 solid #ebebeb;
	  position: absolute;
	  bottom: 0;
	  left: 0;
	  z-index: 101;
	  transition: 0.2s border-bottom ease-in;
	}
	
	.menu:hover > .menu-title:after {
	  border-bottom-width: 5px;
	  transition: 0.2s 0.2s border-bottom-width ease-out;
	}
	
	.menu-title_2nd { background: #4e96b3; }
	.menu-title_2nd:hover { background: #3e86a3; }
	.menu-title_2nd:before { border-top-color: #4e96b3; }
	.menu-title_2nd:hover:before { border-top-color: #3e86a3; }
	
	.menu-title_3rd { background: #c97676; }
	.menu-title_3rd:hover { background: #b96666; }
	.menu-title_3rd:before { border-top-color: #c97676; }
	.menu-title_3rd:hover:before { border-top-color: #b96666; }
	
	.menu-title_4th { background: #dbab58; }
	.menu-title_4th:hover { background: #cb9b48; }
	.menu-title_4th:before { border-top-color: #dbab58; }
	.menu-title_4th:hover:before { border-top-color: #cb9b48; }
	
	.menu-dropdown {
	  border-radius: 10px;
	  min-width: 100%;
	  padding: 15px 0;
	  position: absolute;
	  background: #ebebeb;
	  z-index: 100;
	  transition:
	    0.5s padding,
	    0.5s background;
	}
	
	.menu-dropdown:after {
	  content: "";
	  display: block;
	  height: 0;
	  border-top: 5px solid #ebebeb;
	  border-left: (150px / 2) solid transparent;
	  border-right: (150px / 2) solid transparent;
	  position: absolute;
	  top: 100%;
	  left: 0;
	  z-index: 101;
	  transition: 0.5s border-top;
	}
	
	.menu:not(:hover) > .menu-dropdown {
	  padding: 4px 0;
	  background: #dddddd;
	  z-index: 99;
	}
	
	.menu:not(:hover) > .menu-dropdown:after {
	  border-top-color: #dddddd;
	}
	
	.menu:not(:hover) > .menu-title:after {
	  border-bottom-color: #dddddd;
	}
	
	.menu-dropdown > * {
	  overflow: hidden;
	  height: 30px;
	  padding-left: 10px ;
	  background: rgba(0,0,0,0);
	  white-space: nowrap;
	  transition: 
	    0.5s height cubic-bezier(.73,.32,.34,1.5),
	    0.5s padding cubic-bezier(.73,.32,.34,1.5),
	    0.5s margin cubic-bezier(.73,.32,.34,1.5),
	    0.5s 0.2s color,
	    0.2s background-color;
	}
	
	.menu-dropdown > *:hover {
	  background: rgba(0,0,0,0.1);
	}
	
	.menu:not(:hover) > .menu-dropdown > * {
	  visibility: hidden;
	  height: 0;
	  padding-top: 0;
	  padding-bottom: 0;
	  margin: 0;
	  color: rgba(25,25,25,0);
	  transition: 
	    0.5s 0.1s height,
	    0.5s 0.1s padding,
	    0.5s 0.1s margin,
	    0.3s color,
	    0.6s visibility;
	  z-index: 99;
	}
	
</style>
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
						<input type="hidden" name="sessionScopeNick" id="sessionScopeNick" value="${sessionScope.dto.nickname}">
						<input type="hidden" name="sessionScopeImg" id="sessionScopeImg" value="${sessionScope.dto.profile_img}">
						<li class="nav-item top_loginState">
							<a href="#click" class="menu" style="display: table-cell; text-decoration: none;">
						      <h2 class="menu-title" style="font-family: sangsangBody; font-size: 1rem; padding: 10px;">
						      
								<img src="${pageContext.request.contextPath}/resources/upload/${sessionScope.dto.profile_img}" width="25px" height="25px">
								${sessionScope.dto.nickname}
						      </h2>
						      <ul class="menu-dropdown" style="z-index: 9000;">
						        <li>내 정보</li>
						        <li><span onclick="location.href='../myInfo/myHostPage.do'">나에게 온 예약내역</span></li>
						        <li><span onclick="location.href='../myInfo/myGuestPage.do'">내가 보낸 예약내역</span></li>
						        <li><span onclick="location.href='../myInfo/myExpirationPage.do'">만료내역</span></li>
						      </ul>
						    </a>
						</li>&nbsp;&nbsp;
						<li class="nav-item top_side" style="width: fit-content">
							<a href="../login/logout.do">로그아웃</a>&nbsp;&nbsp;|&nbsp;&nbsp;
						</li>
					</c:if>
					<li class="nav-item top_side" style="width: fit-content;"><a href="#">고객센터</a>&nbsp;&nbsp;|&nbsp;&nbsp;</li>
					<li class="nav-item top_side" style="width: fit-content;"><a href="#">이용안내</a> </li>
				</ul>
			</div>
		</div>		
	</nav>

	<!-- 네비게이션 바 -->
	<nav class="navbar nav navbar-expand-xl navbar-light bg-dark" style="z-index: 3000 !important">
		<div class="container">
			<a class="navbar-brand mb-0 text-warning" href="../main/main.do"><img class="img-fluid" src="../resources/images/mainIcon/navlogo_ch2.png" width="250"></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		    	<span class="navbar-toggler-icon"></span>
			</button>
			
		  	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		    	<ul class="navbar-nav mr-auto">
		     		<li class="nav-item active">
		     			<a class="nav-link text-muted">소개</a>
		      		</li>
					<li class="nav-item active">
						<a class="nav-link text-white" href="../reservationPage/showPage.do">주차예약</a>
		      		</li>
					<li class="nav-item active">
						<a class="nav-link text-white" href="../freeboard/freeboard.do">공지사항</a>
		      		</li>
		      		<li class="nav-item active">
		        		<a class="nav-link text-white" href="../faq/faq.do">FAQ</a>
		      		</li>
		    	</ul>
		  	</div>
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