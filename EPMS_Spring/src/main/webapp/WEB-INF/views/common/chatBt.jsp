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
<link rel="stylesheet" href="../resources/chat/css/chatBt.css">
</head>
<body style="height: 100%;">
	<div class="chatView">
		<iframe id="chatPage"></iframe>
	</div>
	<button class="chatBt circle"><i class="fas fa-comment"></i></button>
	<script type="text/javascript">
		var login = "${sessionScope.dto.id}";
		if(login != "" || login != null) {
			var webSocket = new WebSocket("wss://15.164.1.35:8443/b/wsAutoLogout");
			webSocket.onopen = function(message) {
			}
			webSocket.onerror = function() {
				alert('웹소켓 에러');
			} 
		}
	
		window.onpageshow = function(event) {
		    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
		    	window.location.reload();
		    }
		}
		
		$(window).on('beforeunload', function() {
			var login = "${sessionScope.dto.id}";
			if(login != null && login != "") {
				var flag = "";
				if($('.chatView').is(":visible")) {
					flag += "true";
				} else {
					flag += "false";
				}
				document.cookie = "chatPageOpen=" + flag + "; path=/;";
			}
		});
	
		$('.chatBt').click(function () {
			var login = "${sessionScope.dto.id}";
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
			var iframe = document.getElementById("chatPage");
			var login = "${sessionScope.dto.id}";
			if(login == "" || login == null) {
				return false;
			}
			var chatPage = "${cookie.chatPage.value}";
			var chatPageOpen = "${cookie.chatPageOpen.value}";
			if(chatPageOpen == "true") {
				$('.chatView').show();
			} else {
				$('.chatView').hide();
			}
			
			if(chatPage == null || chatPage == "") {
				iframe.contentWindow.location.replace("../chat/friend.do");
				//$('#chatPage').attr('src', '../chat/friend.do');
				$('.chatView').hide();
			} else if (chatPage ==1) {
				iframe.contentWindow.location.replace("../chat/friend.do");
			} else if (chatPage == 2) {
				iframe.contentWindow.location.replace("../chat/chats.do");
			} else if (chatPage == 3) {
				var chatOpponent = "${cookie.chatOpponent.value}";
				iframe.contentWindow.location.replace('../chat/chat.do?opponent='+chatOpponent);
			} else if (chatPage == 4) {
				iframe.contentWindow.location.replace('../chat/find.do?');
			} else if (chatPage == 5) {
				iframe.contentWindow.location.replace('../chat/profile.do?');
			} else if (chatPage == 6) {
				iframe.contentWindow.location.replace('../chat/more.do?');
			}		
		});
	</script> 
</body>
</html>