<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
  <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <title>Chats</title>
</head>
<script type="text/javascript">
	window.show_leaving_warning = false;
	$(document).ready(function() {
		// 페이지 이동간 채팅 상태 유지
		var chatScroll = "${cookie.chatScroll.value}";
		if(chatScroll == null || chatScroll =="" ) {
			$("main").scrollTop(0);
		} else {
			$('main').scrollTop(chatScroll);
		}
		
		// 읽지않은 쪽지 갯수 체크
		var notReadCount = "${notReadCount}"*1;
		var reservationNotReadCount = "${reservationNotReadCount}"*1;
		initNotReadCount(notReadCount, reservationNotReadCount);
		
	});
	
	// 페이지 없어질 때 상태에 따른 쿠키 저장
	$(window).on('beforeunload', function() {
		var login = "${sessionScope.dto.id}";
		if(login != null && login != "") {	
			document.cookie = "chatPage=" + escape(2) + "; path=/;";
			
			var currentScroll = $('main').scrollTop();
			document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
		}
	});
	

	var notReadCount; 
	
	// 웹소켓 연결
	var webSocket = new WebSocket("wss://118.130.22.175:8443/b/ws");
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
				// 메세지 구분
				var content = "";
				if(msg.r_status == "예약중") {
					content += msg.r_guest + "님의 예약요청입니다.";
				} else if(msg.r_status == "예약완료") {
					content += msg.r_host + "님이 예약을 승인했습니다.";
				} else if(msg.r_status == "예약취소") {
					if(msg.r_agree != "") {
						if(msg.r_hostRead == 'false') {
							content += msg.r_guest + "님이 예약을 취소했습니다.";
						} else if (msg.r_guestRead == 'false') {
							content += msg.r_host + "님이 예약을 취소했습니다.";
						}
					} else { 
						if(msg.r_hostRead == 'false') {
							content += msg.r_guest + "님이 예약을 취소했습니다.";
						} else if(msg.r_guestRead == 'false') {
							content += msg.r_host + "님이 예약을 거절했습니다.";
						}
					}
				} else if(msg.r_status == "사용완료") {
					content += msg.r_guest + "님이 사용완료하였습니다.";
				}
				
				// 내가 예약 요청한 메세지 일 때
				if(msg.r_guest == nickname) {
					notReadCount = removeChatsList(msg.r_host);
					if(msg.r_status == "예약중") {
						prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount -1, path);
					} else if(msg.r_status == "예약완료") {
						prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount, path);
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
					} else if(msg.r_status == "예약취소") {
						if(msg.r_agree != "") {
							if(msg.r_hostRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount-1, path);
							} else if(msg.r_guestRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount, path);
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							}
							
						} else {
							if(msg.r_hostRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount-1, path);
							} else if(msg.r_guestRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount, path);
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							}
						}
					} else if(msg.r_status == "사용완료") {
						prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount, path);
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
					}
						
				// 다른 사람이 요청했을 경우
				} else if(msg.r_host == nickname ) {
					notReadCount = removeChatsList(msg.r_guest);
					if(msg.r_status == "예약중") {
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
						prependList(msg.r_guest, msg.r_guest_profileImg, content, msg.r_request, notReadCount, path);
					} else if(msg.r_status == "예약완료") {
						prependList(msg.r_guest, msg.r_guest_profileImg, content, msg.r_request, notReadCount-1, path);
					} else if(msg.r_status == "예약취소") {
						if(msg.r_agree != "") {
							if(msg.r_hostRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount, path);
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							} else if (msg.r_guestRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount-1, path);
							}
							prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount-1, path);
						} else {
							if(msg.r_hostRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount, path);
								changeChatBtnCounter(2);
								changeChatsReadCounter();
								changeReservationReadCounter(1);
							} else if(msg.r_guestRead == 'false') {
								prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount-1, path);
							}
						}
					} else if(msg.r_status == "사용완료") {
						prependList(msg.r_host, msg.r_host_profileImg, content , msg.r_request, notReadCount, path);
						changeChatBtnCounter(2);
						changeChatsReadCounter();
						changeReservationReadCounter(1);
					}
				}
				
			// 일반 메세지 타입일 경우
			} else {
				// 채팅방에서의 상황은 내가 받는 경우 밖에 없기 떄문에
				if(msg.toNick == nickname) {
					$('.chat__user').each(function() {
						if($(this).text() == msg.fromNick) {
							// 나에게 온 메세지인데 방나갔다는 메세지 일 경우
							if(msg.content == '#$%Room Out#$%') {
								$(this).closest("li").find('.chat__last-message').html(msg.fromNick + "님이 나갔습니다.");
								return false;
							}
							var exist = $(this).closest("li").find('.notReadCounter').html() * 1;
							if(exist == null || exist == "" || exist == 0 || isNaN(exist)) {
								exist = 0;
							}
							notReadCount = exist + 1;
							$(this).closest("li").remove();
						}
					});
					
					// 메세지이지만 방나간 메세지를 제외하고
					if(msg.content != '#$%Room Out#$%') {
						changeChatBtnCounter(1);
						changeChatsReadCounter();
						prependList(msg.fromNick, msg.fromNick_profileImg, msg.content, msg.writeDate, notReadCount, path);
					}
				}
			}
		}
	} 
</script>
<body class="chats_body">
  <header class="top-header">
  	
    <div class="header__bottom">
      <div class="header__column">
      </div>
      <div class="header__column">
        <span class="header__text">Chat List</span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
  <main class="chats">
    <div class="search-bar">
      <i class="fa fa-search"></i>
      <input type="text" placeholder="방찾기 기능 곧 서비스하겠습니다." disabled="disabled">
    </div>
    <ul class="chats__list">
	  	<c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
	  		<c:if test="${!(list.fromNick == sessionScope.dto.nickname && list.content == '#$%Room Out#$%') }">
		  		<c:choose>
		  			<c:when test="${list.fromNick == sessionScope.dto.nickname}">
		  				<c:set var="opponentNick" value="${list.toNick}"/>
		  			</c:when>
		  			<c:otherwise>
		  				<c:set var="opponentNick" value="${list.fromNick }"/>
		  			</c:otherwise>
		  		</c:choose>
		  		<li class="chats__chat">
			        <a href="javascript:location.replace('../chat/chat.do?opponent=${opponentNick}');">
			          <div class="chat__content">
			          	<c:choose>
			          		<c:when test="${opponentNick == list.fromNick}">
					            <img src="${pageContext.request.contextPath}/resources/upload/${list.fromNick_profileImg}">
			          		</c:when>
			          		<c:otherwise>
			          			<img src="${pageContext.request.contextPath}/resources/upload/${list.toNick_profileImg}">
			          		</c:otherwise>
			          	</c:choose>
			            <div class="chat__preview">
			                <h3 class="chat__user">${opponentNick}</h3>
			                <c:choose>
			                	<c:when test="${list.content == '#$%Room Out#$%'}">
			               			<span class="chat__last-message">${opponentNick}님이 나갔습니다.</span>
			               		</c:when>
			               		<c:otherwise>
			               			<span class="chat__last-message">${list.content}</span>
			               		</c:otherwise>
			                </c:choose>
			            </div>
			          </div>
			          <span class="chat__date-time">
			          	<c:if test="${list.notReadCheck != 0}">
			          		<span class="notReadCounter">${list.notReadCheck}</span>&nbsp;&nbsp;
			          	</c:if>
			            ${list.writeDate}
			          </span>
			        </a>
			      </li>
		      </c:if>
	  	</c:forEach>
    </ul>
    <div class="chat-btn">
      <i class="fa fa-plus fa-lg"></i>
    </div>
  </main>
  <nav class="tab-bar">
    <a href="javascript:location.replace('../chat/friend.do')" class="tab-bar__tab">
      <i class="fa fa-user"></i>
      <span class="tab-bar__title">Friends</span>
    </a>
    <a href="javascript:location.replace('../chat/chats.do')" class="tab-bar__tab tab-bar__tab--selected">
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
  <script src="../resources/chat/js/chats.js"></script>
  <script src="../resources/chat/js/navigation.js"></script>
</body>
</html>
