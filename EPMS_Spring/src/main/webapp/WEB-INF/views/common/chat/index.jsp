<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <title>Friends</title>
</head>
<script type="text/javascript">
	window.show_leaving_warning = false;
	$(document).ready(function() {
		var chatScroll = "${cookie.chatScroll.value}";
		if(chatScroll == null || chatScroll =="") {
			$(window).scrollTop(0);
		} else {
			$(window).scrollTop(chatScroll);
		}
		
		// 읽지않은 쪽지 갯수 체크
		var notReadCount = "${notReadCount}"*1;
		var reservationNotReadCount = "${reservationNotReadCount}"*1;
		initNotReadCount(notReadCount, reservationNotReadCount);
	});
	
	$(window).on('beforeunload', function() {
		var login = "${sessionScope.dto.id}";
		if(login != null && login != "") {
			document.cookie = "chatPage=" + escape(1) + "; path=/;";
			
			var currentScroll = $(document).scrollTop();
			document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
		}
	});
	
	var webSocket = new WebSocket("wss://192.168.0.2:8443/b/ws");
	webSocket.onopen = function(message) {
	}
	webSocket.onerror = function() {
		alert('웹소켓 에러');
	} 
	webSocket.onmessage = function(data) {
		if(data.data != "connected Opponent") {
			// 메세지형태 일 때만 처리
			var msg = JSON.parse(data.data);
			var nickname = "${sessionScope.dto.nickname}";
			var path = "${pageContext.request.contextPath}";
			var notReadCount = 1; 
			
			// 메세지가 예약관련 메세지 일 떄
			if(msg.message_type == "reservation") {
				
				// 내가 예약 요청한 메세지 일 때
				if(msg.r_guest == nickname) {
					
					if(msg.r_status == "예약중") {
						
					} else if(msg.r_status == "예약완료") {
						
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
					} else if(msg.r_status == "예약취소") {
						if(msg.r_agree != "") {
							if(msg.r_hostRead == 'false') {
								
							} else if(msg.r_guestRead == 'false') {
								
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							}
							
						} else {
							if(msg.r_hostRead == 'false') {
								
							} else if(msg.r_guestRead == 'false') {
								
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							}
						}
					} else if(msg.r_status == "사용완료") {
						
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
					}
						
				// 다른 사람이 요청했을 경우
				} else if(msg.r_host == nickname ) {
					
					if(msg.r_status == "예약중") {
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
						
					} else if(msg.r_status == "예약완료") {
						
					} else if(msg.r_status == "예약취소") {
						if(msg.r_agree != "") {
							if(msg.r_hostRead == 'false') {
								
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							} else if (msg.r_guestRead == 'false') {
								
							}
							
						} else {
							if(msg.r_hostRead == 'false') {
								
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							} else if(msg.r_guestRead == 'false') {
								
							}
						}
					} else if(msg.r_status == "사용완료") {
						
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
					}
				}
				
			// 일반 메세지 타입일 경우
			} else {
				// 채팅방에서의 상황은 내가 받는 경우 밖에 없기 떄문에
				if(msg.toNick == nickname) {
					
					// 메세지이지만 방나간 메세지를 제외하고
					if(msg.content != '#$%Room Out#$%') {
						changeChatBtnCounter(1);
						changeChatsReadCounter();
						
					}
				}
			}
		}
	}
</script>
<body style="padding-top: 50px;">
  <header class="top-header">
  
    <div class="header__bottom">
      <div class="header__column">
      </div>
      <div class="header__column">
        <span class="header__text">Friends</span>
        <span class="header__number"></span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
  <main class="friends">
    <div class="search-bar">
      <i class="fa fa-search"></i>
      <input type="text" placeholder="친구찾기 기능 곧 서비스하겠습니다." disabled="disabled">
    </div>
    <section class="friends__section">
      <header class="friends__section-header">
        <h6 class="friends_profile-title">My Profile</h6>
      </header>
      <div class="friends__section-rows">
        <div class="friends__section-row">
          <a href="javascript:location.replace('../chat/profile.do')">
            <img src="${pageContext.request.contextPath}/resources/upload/${sessionScope.dto.profile_img}">  
            ${sessionScope.dto.nickname}
          </a>
        </div>
      </div>
    </section>
    <section class="friends__section">
      <header class="friends__section-header">
        <h6 class="friends__section-title">Friends</h6>
      </header>
      <div class="friends__section-rows">
      	<div style="padding-top: 30px; text-align: center;">친구기능 준비중입니다.</div>
        <!-- <div class="friends__section-row with-tagline">
          <div class="friends__section-column">
            <img src="../resources/chat/images/avatar.png" alt="">
            <span class="friends__section-name">Minji Lee</span>
          </div>
            <span class="friends__section-tagline">Life is short. so live your life.</span>
        </div> -->
      </div>
    </section>
  </main>
  <nav class="tab-bar">
    <a href="javascript:location.replace('../chat/friend.do')" class="tab-bar__tab tab-bar__tab--selected">
      <i class="fa fa-user"></i>
      <span class="tab-bar__title">Friends</span>
    </a>
    <a href="javascript:location.replace('../chat/chats.do')" class="tab-bar__tab">
      <i class="fa fa-comment"></i>
      <span class="tab-bar__title">Chats</span>
    </a>
    <a href="javascript:location.replace('../chat/find.do')" class="tab-bar__tab">
      <i class="fa fa-search"></i>
      <span class="tab-bar__title">Reservation</span>
    </a>
    <a href="javascript:location.replace('../chat/more.do')" class="tab-bar__tab">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
  <script src="../resources/chat/js/navigation.js"></script>
</body>
</html>
