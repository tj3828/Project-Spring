<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <link rel="stylesheet" href="../resources/chat/css/weather.css">
  <title>More</title>
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
			document.cookie = "chatPage=" + escape(6) + "; path=/;";
			
			var currentScroll = $(document).scrollTop();
			document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
		}
	});
	
	var webSocket = new WebSocket("wss://15.164.1.35:8443/b/ws");
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
<body style="padding-top: 46px; height: 100%; padding-bottom: 50px;">
  <header class="top-header">
    <div class="header__bottom">
      <div class="header__column">

      </div>
      <div class="header__column">
        <span class="header__text">Weather</span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
  <main class="more" style="height:100%; overflow-y: scroll; " >
    <header class="more__header">
      <div class="more-header__column">
        <div class="more-header__info">
          <h3 class="more-header__title">
            
          </h3>
          <span class="more-header__subtitle">
            해당 사이트의 특성상 오차가 존재합니다.
          </span>
        </div>
      </div>
    </header>
    <section class="more__options" style="background: gainsboro">
      <div class="more__option" style="padding:0; padding-bottom: 20px; margin-left: auto; margin-right: auto;">
         	<div class="weather">
		      <h3 class="weather_status_Title">Cloudy</h3>
		      <div class="weather_status" style="display: contents;">
			      <!-- <div class="cloudy">
			        <div class="eyes"></div>
			      </div>  -->
		      </div>
		    </div>
        <span class="more__option-title">Weather</span>
      </div>
    </section>
    <section class="more__plus-friends">
      <header class="plus-friends__header">
        <h2 class="plus-friends__title">Plus Weather</h2>
      </header>
      <div class="plus-friends__items">
        <div class="plus-friends__item">
          <i class="fas fa-wind"></i>
          <span class="plus-friends__item-title wind">바람</span>
        </div>
        <div class="plus-friends__item">
          <i class="fas fa-water"></i>
          <span class="plus-friends__item-title dust">미세먼지</span>
        </div>
        <div class="plus-friends__item">
          <i class="fas fa-sun"></i>
          <span class="plus-friends__item-title sunrise">일출</span>
        </div>
        <div class="plus-friends__item">
          <i class="fas fa-moon"></i>
          <span class="plus-friends__item-title sunset">일몰</span>
        </div>
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
      <a href="javascript:location.replace('../chat/find.do')" class="tab-bar__tab">
      <i class="fa fa-search"></i>
      <span class="tab-bar__title">Reservation</span>
    </a>
    <a href="javascript:location.replace('../chat/more.do')" class="tab-bar__tab tab-bar__tab--selected">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
</body>
	<script src="../resources/chat/js/more.js"></script>
	<script src="../resources/chat/js/navigation.js"></script>
</html>
