<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="chatHtml">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" href="../resources/css/chat.css">
</head>
<style>
	.circle {
		background-color: yellow;
		color: #534737;
		height: 6em;
		width: 6em;
		border-radius: 7.5em;
		-webkit-border-radius: 7.5em;
		-moz-border-radiud: 7.5e,;
		text-align: center;
		box-shadow: 1px 10px 5px rgba(0,0,0,0.2), 6px 11px 5px rgba(0,0,0,0.2);
		
	}
	.chatBt {
		border: 0;
		outline: 0;
		cursor: pointer;
	}
	.chatBt:focus {
		outline: none;
	}
	.chatView:after {
	    content: '';
	    position: absolute;
	    border-top: 20px solid ;
	    border-right: 20px solid transparent;
	    border-left: 20px solid transparent;
	    bottom: -20px;
		right: 10px;
	}
	.circle{
		transition: color 0.3s, background 0.3s, transform 0.5s ease-in-out;
	}
	
	.circle:hover {
	  color: white;
	  background: #523737;
	  transform: rotateY(1turn);
	}
</style>
<body style="height: 100%;">
	<div class="chatView" style="display: none; position: fixed; height:50%; width:348px; bottom:120px;right:30px; background-color: white; border: 1px solid; box-shadow: 1px 10px 5px rgba(0,0,0,0.2), 6px 11px 5px rgba(0,0,0,0.2);">
		<iframe id="chatPage" style="overflow-x:hidden; width: 100%; height: 100%;"></iframe>
	</div>
	<button class="chatBt circle"  style="position: fixed; width:66px; height:66px; bottom: 30px; right: 30px;"><i class="fas fa-comment"></i></button>
	
	<script type="text/javascript">
		$('.chatBt').click(function () {
			var login = "${sessionScope.id}";
			if(login == "" || login == null) {
				swal('로그인 필요','채팅을 이용하기 위해서는 로그인을 해주세요.','error');
				return false;
			}
			if($('.chatView').is(':visible')) {
				$('.chatView').hide(300);
			} else {
				$('.chatView').show(300);
			}
		});
		
		$(document).ready(function () {
			var login = "${sessionScope.id}";
			
			var chatPage = "${cookie.chatPage.value}";
			if(chatPage == null || chatPage == "") {
				$('#chatPage').attr('src', '../chat/friend.do');
				$('.chatView').hide();
			} else if (chatPage ==1) {
				$('#chatPage').attr('src', '../chat/friend.do');
				$('.chatView').show();
			} else if (chatPage == 2) {
				$('#chatPage').attr('src', '../chat/chats.do');
				$('.chatView').show();
			} else if (chatPage == 3) {
				$('#chatPage').attr('src', '../chat/chat.do');
				$('.chatView').show();
			} else if (chatPage == 4) {
				$('#chatPage').attr('src', '../chat/find.do');
				$('.chatView').show();
			} else if (chatPage == 5) {
				$('#chatPage').attr('src', '../chat/profile.do');
				$('.chatView').show();
			} else if (chatPage == 6) {
				$('#chatPage').attr('src', '../chat/more.do');
				$('.chatView').show();
			}			
			
			if(login == "" || login == null) {
				$('.chatView').hide();
				return false;
			}
		});
	</script> 
</body>
</html>