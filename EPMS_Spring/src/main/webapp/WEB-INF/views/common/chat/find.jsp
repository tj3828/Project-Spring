<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <title>Find</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		var chatScroll = "${cookie.chatScroll.value}";
		if(chatScroll == null || chatScroll =="") {
			$(window).scrollTop(0);
		} else {
			$(window).scrollTop(chatScroll);
		}
		
		var notReadCount = "${notReadCount}";
		
		if(notReadCount != "0" && notReadCount != null && notReadCount != "" && notReadCount != 0)	{
			if(parent.$('body').find('.chatBt_notReadCounter').length == 0) {
				parent.$('button.chatBt').after('<span class="chatBt_notReadCounter">' + notReadCount + '</span>');
			} else {
				parent.$('.chatBt_notReadCounter').html(notReadCount);
			}
			$('.fa-comment').after('<span class="Bottom_notReadCounter">' + notReadCount + '</span>');
		} else {
			if(parent.$('body').find('.chatBt_notReadCounter').length == 1) {
				parent.$('.chatBt_notReadCounter').remove();
			}
		}
		
	});
	
	$(window).on('beforeunload', function() {
		var login = "${sessionScope.dto.id}";
		if(login == null || login == "") {
			return false;
		}
		document.cookie = "chatPage=" + escape(4) + "; path=/;";
		
		var currentScroll = $(document).scrollTop();
		document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
	});
	
	var webSocket = new WebSocket("ws://192.168.0.2:8081/b/ws");
	webSocket.onopen = function(message) {
	}
	webSocket.onerror = function() {
		alert('웹소켓 에러');
	} 
	webSocket.onmessage = function(data) {
		if(data.data != "connected Opponent") {
			var msg = JSON.parse(data.data);
			var nickname = "${sessionScope.dto.nickname}";
			if(msg.toNick == nickname && msg.content != '#$%Room Out#$%') {
				
				var Bottom_notReadCounter = $('.Bottom_notReadCounter').html() *1;
				if(Bottom_notReadCounter == null || Bottom_notReadCounter == "" || Bottom_notReadCounter == 0 || isNaN(Bottom_notReadCounter)) {
					$('.fa-comment').after('<span class="Bottom_notReadCounter"></span>');
					parent.$('button.chatBt').after('<span class="chatBt_notReadCounter"></span>');
					Bottom_notReadCounter = 0;
				}
				Bottom_notReadCounter += 1;
				parent.$('.chatBt_notReadCounter').html(Bottom_notReadCounter);
				$('.Bottom_notReadCounter').html(Bottom_notReadCounter);
				
			}
		} 
	}
</script>
<body style="padding-top: 46px;">
  <header class="top-header">
    <div class="header__bottom">
      <div class="header__column">
      </div>
      <div class="header__column">
        <span class="header__text">Friends</span>
        <span class="header__number">1</span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
  <main class="find">
    <section class="find__options">
      <div class="find__option">
        <i class="fa fa-address-book fa-lg"></i>
        <span class="find__option-title">Find</span>
      </div>
      <div class="find__option">
        <i class="fa fa-qrcode fa-lg"></i>
        <span class="find__option-title">QR Code</span>
      </div>
      <div class="find__option">
        <i class="fa fa-mobile fa-lg"></i>
        <span class="find__option-title">Shake</span>
      </div>
      <div class="find__option">
        <i class="fa fa-envelope-o fa-lg"></i>
        <span class="find__option-title">Invite via SMS</span>
      </div>
    </section>
    <section class="find__recommended">
      <header>
        <h6 class="recommend__title">Recommended Friends</h6>
      </header>
      <div class="recommended__none">
        <span class="recommended__text">You have no recommended friends.</span>
      </div>
    </section>

  </main>
  <nav class="tab-bar">
    <a href="javascript:location.replace('../chat/friend.do')" class="tab-bar__tab">
      <i class="fa fa-user"></i>
      <span class="tab-bar__title">Friends</span>
    </a>
    <a href="javascript:location.replace('../chat/chats.do')" class="tab-bar__tab">
      <i class="fa fa-comment"></i>
      <span class="tab-bar__title">Chats</span>
    </a>
    <a href="javascript:location.replace('../chat/find.do')" class="tab-bar__tab tab-bar__tab--selected">
      <i class="fa fa-search"></i>
      <span class="tab-bar__title">Find</span>
    </a>
    <a href="javascript:location.replace('../chat/more.do')" class="tab-bar__tab">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
</body>
</html>
