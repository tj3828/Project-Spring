<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="height:100%;">

<head>
<meta charset="UTF-8">
<title>주차관리시스템 - EPMS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="stylesheet" href="../resources/css/bootstrap/bootstrap.min.css">
<script src="../resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<style>
	.swing1 {
	    animation: swing ease-in-out 1s infinite alternate;
	    transform-origin: center -20px;
	    float:left;
	    margin-top: 15px;
	    margin-right: 0;
	    position: absolute;
	    margin-left: 0; 
	}
	
	.swing1 img  {
	    display: block;
	}
	.swing1:after{
	    content: '';
	    position: absolute;  
	    width: 40px; height: 40px;  
	    border: 2px solid #999;
	    top: -20px; left: 43%;
	    z-index: 0;
	    border-bottom: none;
	    border-right: none;
	    transform: rotate(45deg);
	}
	/* nail */
	.swing1:before{
	    content: '';
	    position: absolute;
	    width: 10px; height: 10px;
	    top: -31px;left: 51.5%;
	    z-index: 5;
	    border-radius: 50% 50%;
	    background: #000;
	}
	 
	@keyframes swing {
	    0% { transform: rotate(3deg); }
	    100% { transform: rotate(-3deg); }
	}
	
	.swing2 {
	    animation: swing ease-in-out 1s infinite alternate;
	    animation-delay: 0.3s;
	    transform-origin: center -20px;
	    float:left;
	    margin-top: 15px;
	    margin-left: 15px;
	    display:inline-table;
	    position: absolute;
	}
	
	.swing2 img  {
	    display: block;
	}
	
	.swing2:after{
	    content: '';
	    position: absolute;  
	    width: 40px; height: 40px;  
	    border: 2px solid #999;
	    top: -20px; left: 43%;
	    z-index: 0;
	    border-bottom: none;
	    border-right: none;
	    transform: rotate(45deg);
	}
	
	.swing2:before {
	    content: '';
	    position: absolute;
	    width: 10px; height: 10px;
	    top: -31px;left: 51.5%;
	    z-index: 5;
	    border-radius: 50% 50%;
	    background: #000;
	}
	
	@media screen and (max-width:510px) {
		.main-image-btns{
			width:100% !important;
		}
		.main-image-btns hr {
			width: 100% !important;
		}
		figure img {
			width:80%;
		}
		.swing1:before, .swing2:before {
		 	left:41.5%;
		}
		.swing1:after, .swing2:after {
		 	left:33%;
		}
	}
	
	@media screen and (max-width:400px) {
		.swing1 {
			margin-left: 4%;
		}
	}
	.btn-login {
		position:absolute; 
		top:20px; right:20px;
		width: 78px;height: 33px;
		border: 1px solid #2e4669; 
		line-height: 35px; 
		text-align: center; 
		font-weight: bold;
	    font-size: 14px;
	    color: #fff;
	    background: transparent;
	    cursor: pointer;
	}
</style>

<body style="height:100%; margin: 0; text-align: center; background-image: url('/b/resources/images/main-01.jpg'); background-repeat: no-repeat; background-size: cover;">
   <c:if test="${sessionScope.dto.id == null }">
   		<input type="button" class="btn-login" value="LOGIN" onclick="location.href='../login/login.do';">
   </c:if>
   <c:if test="${sessionScope.dto.id != null }">
   		<input type="button" class="btn-login logout" value="LOGOUT" onclick="location.href='../login/logout.do';">
   		<iframe width='0' height='0' name='test' id='test' frameborder='1' scrolling='yes' align='left' style="visibility:hidden;display:none"></iframe>
   </c:if>
   <div class="main-image" style="left:50%;top:50%;transform: translate(-50%,-70%); position: relative; ">
   		<div class="main-slide-image" style="display: none;">
			<div style="display: inline-flex; margin-left: 30px; ">
	    		<img src="../resources/images/mainIcon/mainlogo_ch.png" style="width: 100%; height: auto;">
	    	</div>
	    	<br>
	    	<div style="display: inline-flex; ">
	    		<img src="../resources/images/mainIcon/slogan.png" style="width: 100%; height: auto;">
	    	</div>
    	</div>
		<br>
		<div class="main-image-btns" style="width:500px; display: inline-block;" >
			<hr style="width:350px; height: 10px; border: 0; background-color: #f15e5e; margin-bottom: 0.5em !important;">
			<figure class="swing1" style="margin-left: 40px !important;">
				<img src="../resources/images/infoBtn.png" onclick="#" style="cursor:pointer;">
			</figure> 
			<figure class="swing2">
				<img src="../resources/images/reservationBtn.png" onclick="location.href='../reservationPage/showPage.do'" style="cursor:pointer;">
			</figure> 
		</div>
   </div>
   <jsp:include page="../common/chatBt.jsp"></jsp:include>
   <script>
		$('.main-slide-image').slideDown(1000);
		$('.logout').click(function() {
			document.getElementById("test").src = 'https://nid.naver.com/nidlogin.logout';
		});
   </script>
</body>
</html>
<jsp:include page="../common/footer.jsp"></jsp:include>
