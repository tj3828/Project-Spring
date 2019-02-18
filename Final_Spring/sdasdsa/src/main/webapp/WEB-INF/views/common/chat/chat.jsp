<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" style="height: 100%;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <title>Chat</title>
</head>
<style>
	pre {
		font-family: "Open Sans", sans-serif;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var chatScroll = "${cookie.chatScroll.value}";
		if(chatScroll == null || chatScroll =="") {
			$(window).scrollTop(0);
		} else {
			$(window).scrollTop(chatScroll);
		}
		
		
	});

	$(window).on('beforeunload', function() {
		var login = "${sessionScope.id}";
		if(login == null || login == "") {
			return false;
		}
		document.cookie = "chatPage=" + escape(3) + "; path=/;";
		document.cookie = "chatWho=" + escape(2) + "; path=/;";
		
		var currentScroll = $('main').scrollTop();
		document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
	});
	
	var webSocket = new WebSocket("ws://192.168.0.2:8081/b/ws");
	webSocket.onopen = function(message) {
	}
	webSocket.onerror = function() {
		alert('웹소켓 에러');
	} 
	webSocket.onmessage = function(data) {
		var msg = JSON.parse(data.data);
		var nickname = "${sessionScope.nickname}";
		if(msg.fromNick == nickname) {
			$('.chat').append('<div class="chat__message chat__message-from-me">' + 
					    		  '<span class="chat__message-time">' + msg.writeDate + '</span>' + 
						    		  '<span class="chat__message-body">' + 
						    		  	'<pre>' + msg.content + '</pre>' +
						      	   '</span>' + 
				  			  '</div>');
		} else {
			$('.chat').append('<div class="chat__message chat__message-to-me">' + 
				  	'<img src="../resources/chat/images/avatar.png" alt="" class="chat-message-avatar">' +
	              	'<div class="chat__message-center">' +
	      				'<h3 class="chat__message-username">'+ msg.fromNick + '</h3>' +
	      				'<span class="chat__message-body">' +
	      					'<pre>' + msg.content + '</pre>' +
	      				'</span>' +
	      			'</div>' +
	      			'<span class="chat__message-time">' + msg.writeDate + '</span>' +
	      		  '</div>');
		}
		$("main").scrollTop($("main")[0].scrollHeight);
	} 
</script>
<body class="body-chat" style="padding-top: 48px; padding-bottom: 45px; height:100%;">
  <header class="top-header chat-header">
    <div class="header__bottom">
      <div class="header__column">
        <a href="../chat/chats.do">
          <i class="fa fa-chevron-left fa-lg"></i>
        </a>
      </div>
      <div class="header__column">
        <span class="header__text">Friends</span>
        <span class="header__number">1</span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
<main class="chat" style="overflow-y:scroll; height:100%; animation:none;">
  <div class="chat__message chat__message-from-me">
    <span class="chat__message-time">17:55</span>
    <span class="chat__message-body">
      Hello! This is a test message.
    </span>
  </div>
  <div class="chat__message chat__message-to-me">
    <img src="../resources/chat/images/avatar.png" alt="" class="chat-message-avatar">
    <div class="chat__message-center">
      <h3 class="chat__message-username">LYNN</h3>
      <span class="chat__message-body">
        And this is an answer.
      </span>
    </div>
    <span class="chat__message-time">19:35</span>
  </div>
</main>
<div class="type-message">
  <i class="fa fa-plus fa-lg"></i>
  <div class="type-message__input">
    <textarea class="chatSendMsg" style="resize: none; width: 100%; height: 37.39px; margin-right: 15px; padding: 10px;"></textarea>
    <button class="record-message" style="outline: none;" disabled="disabled">
      <i class="fa fa-chevron-circle-right fa-lg"></i>
    </button>
  </div>
</div>
<div class="bigScreenText">
  Please make your screen smaller
</div>
<script type="text/javascript">
	$('.chatSendMsg').change(function() {
		if($('.chatSendMsg').val() == "" || $('.chatSendMsg').val() == null) {
			$('.record-message').attr("disabled","disabled");
		} else {
			$('.record-message').removeAttr("disabled" );
		}
	});
	$('.record-message').click(function() {
		String.prototype.replaceAll = function(org, dest) {
		    return this.split(org).join(dest);
		}
		var content = $('.chatSendMsg').val();
		content = content.replaceAll('"','\\"');
		var nickname = "${sessionScope.nickname}";
		var jsonMsg = '{"fromNick":"'+nickname+'", "toNick":"you", "content":"' + content+'", "readCheck":"false"}';
		alert(jsonMsg);
		webSocket.send(jsonMsg);
		$('.chatSendMsg').val("");
		$('.chatSendMsg').focus();
		$('.record-message').attr("disabled","disabled");
	});
</script>
</body>
</html>
