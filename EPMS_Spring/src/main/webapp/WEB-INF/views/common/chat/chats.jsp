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
	$(document).ready(function() {
		// 페이지 이동간 채팅 상태 유지
		var chatScroll = "${cookie.chatScroll.value}";
		if(chatScroll == null || chatScroll =="" ) {
			$("main").scrollTop(0);
		} else {
			$('main').scrollTop(chatScroll);
		}
		
		// 읽지않은 쪽지 갯수 체크
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
	
	// 페이지 없어질 때 상태에 따른 쿠키 저장
	$(window).on('beforeunload', function() {
		var login = "${sessionScope.dto.id}";
		if(login != null && login != "") {	
			document.cookie = "chatPage=" + escape(2) + "; path=/;";
			
			var currentScroll = $('main').scrollTop();
			document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
		}
	});
	
	// 웹소켓 연결
	var webSocket = new WebSocket("ws://118.130.22.175:8081/b/ws");
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
			if(msg.toNick == nickname) {
				var notReadCount = 1; 
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
					var Bottom_notReadCounter = $('.Bottom_notReadCounter').html() *1;
					if(Bottom_notReadCounter == null || Bottom_notReadCounter == "" || Bottom_notReadCounter == 0 || isNaN(Bottom_notReadCounter)) {
						$('.fa-comment').after('<span class="Bottom_notReadCounter"></span>');
						parent.$('button.chatBt').after('<span class="chatBt_notReadCounter"></span>');
						Bottom_notReadCounter = 0;
					}
					Bottom_notReadCounter += 1;
					parent.$('.chatBt_notReadCounter').html(Bottom_notReadCounter);
					$('.Bottom_notReadCounter').html(Bottom_notReadCounter);
				
				
					var path = "${pageContext.request.contextPath}";
					$('.chats__list').prepend('<li class="chats__chat">' +
					        				  	'<a href="javascript:location.replace(\'../chat/chat.do?opponent=' + msg.fromNick + '\');">' +
											          '<div class="chat__content">' + 
											          '<img src="' + path + '/resources/upload/' + msg.fromNick_profileImg + '">' + 
										            		'<div class="chat__preview">' +
										                		'<h3 class="chat__user">' +
										            				msg.fromNick	+
										            			'</h3>' +
										                		'<span class="chat__last-message">' + 
										                			msg.content + 
										                		'</span>' +
										                	'</div>' +
											          '</div>' +
											          '<span class="chat__date-time">' +
											          		'<span class="notReadCounter" style="position: inherit; left:0px;">' + notReadCount + '</span>&nbsp;&nbsp;' +
											          		msg.writeDate +
											          '</span>' +
											     '</a>' +
											   '</li>');
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
      <span class="tab-bar__title">Find</span>
    </a>
    <a href="javascript:location.replace('../chat/more.do')" class="tab-bar__tab">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
  <script src="../resources/chat/js/chat.js"></script>
</body>
</html>
