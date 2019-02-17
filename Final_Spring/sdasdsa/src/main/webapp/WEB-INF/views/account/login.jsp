 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="../resources/css/login.css">
    <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
    <script src="../resources/js/jquery-3.3.1.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<style>
.ch, .ch1{
	display: none;
}
.ch + label {
	display: inline-block;
	width:20px;
	height: 20px;
	border: 1px solid #888;
	cursor: pointer;
	background: #fff;
	vertical-align: middle;
}
.ch:checked + label:after {
	position: relative;
	top:-15px;
	left: 0;
	content: '\2714';
	font-size: 30px;
	color: red;
}
.ch1 + label {
	display: inline-block;
	width:20px;
	height: 20px;
	border: 1px solid #888;
	cursor: pointer;
	background: #fff;
	vertical-align: middle;
}
.ch1:checked + label:after {
	position: relative;
	top:-15px;
	left: 0;
	content: '\2714';
	font-size: 30px;
	color: red;
}
</style>
<script type="text/javascript">
	function checkVal() {
		var id = $('#id').val().trim();
		var pw = $('#pw').val().trim();
		
		if(id == null || id == "") {
			swal('로그인 실패', '아이디를 입력하세요.','error');
			$('#id').focus();
			return;
		}
		
		if(pw == null || pw == "") {
			swal('로그인 실패', '비밀번호를 입력하세요.','error');
			$('#pw').focus();
			return;
		}
		
		login();
	}
	
	function login() {
		var id = $('#id').val().trim();
		var pw = $('#pw').val().trim();
		var saveId = $("input:checkbox[id='ch']").is(":checked");
		var autoLogin = $("input:checkbox[id='ch1']").is(":checked");
		
		$.ajax({
			url:"../login/loginReq.do",
			data:{"id":id, "pw":pw,"saveId":saveId, "autoLogin":autoLogin},
			type: "post",
			success: function(data) {
				if(data == 1) {
					swal('로그인 실패','존재하지 않는 아이디입니다.','error');
				} else if(data == 2) {
					swal('로그인 실패','비밀번호가 일치하지 않습니다.','error');
				} else if(data == 3) {
					location.href='../freeboard/freeboard.do';
				} else if(data == 4) {
					swal('로그인 실패','이미 로그인 중인 아이디입니다.','error');
				}
			},
			error: function() {
				swal('로그인 오류','관리자에게 문의하세요.','error');
			}
		})
	};
</script>
<body>
   
   <div class="container">
       <div class="inner">
           <div class="header">
               <a class="top-header" >Navbar</a>
           </div>
           <div class="login">
               <div class="login-type">
                   <h1>로그인</h1>
                   <input type="text" class="textInput" id="id" placeholder="아이디를 입력하세요." value="${cookie.id.value}">
                   <input type="password" class="textInput" id="pw" placeholder="비밀번호를 입력하세요.">
                   <input class="ch" id="ch" type="checkbox" <c:if test="${cookie.id.value != null }">checked="checked"</c:if>><label for="ch"></label><font style="font-weight: bolder">&nbsp;아이디 저장하기</font>&nbsp;&nbsp;&nbsp;
                   <input class="ch1"  id="ch1" type="checkbox" <c:if test="${cookie.autoLogin.value != null }">checked="checked"</c:if>><label for="ch1"></label><font style="font-weight: bolder">&nbsp;자동 로그인</font><p>
                   <a class="btn btn1" href="javascript:checkVal();">일반 로그인</a>
                   <span class="or-txt">또는</span>
                   <a class="btn btn2" href="#">이메일로 로그인</a>
                   <a class="btn btn3" href="#">네이버로 로그인</a>
                   <a class="btn btn4" href="#">페이스북으로 로그인</a>
                   <a class="btn btn5" href="#">라인으로 로그인</a>
               </div>
               <div class="footer">
                   <p class="band-first">
                       처음이신가요? <a href="../login/joinPre.do">회원가입</a>
                   </p>
               </div>
           </div>
       </div>
   </div>
    
</body>
</html>