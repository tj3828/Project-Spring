<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  
  <!-- js -->
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  
  <!-- font css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
  
  <!-- css -->
  <link rel="stylesheet" href="../resources/css/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
 
  <title>Chat</title>
</head>
<script type="text/javascript">
	window.show_leaving_warning = false;	
	$(document).ready(function() {
		
		$("main").scrollTop($("main")[0].scrollHeight);
		
		// 읽지않은 쪽지 갯수 체크
		var notReadCount = "${notReadCount}"*1;
		var reservationNotReadCount = "${reservationNotReadCount}"*1;
		var total = notReadCount + reservationNotReadCount;
		if(total != "0" && total != null && total != "" && total != 0)	{
			if(parent.$('body').find('.chatBt_notReadCounter').length == 0) {
				parent.$('button.chatBt').after('<span class="chatBt_notReadCounter">' + total + '</span>');
			} else {
				parent.$('.chatBt_notReadCounter').html(total);
			}
		} else {
			if(parent.$('body').find('.chatBt_notReadCounter').length == 1) {
				parent.$('.chatBt_notReadCounter').remove();
			}
		}
		
	});
	
	// ctrl+enter 입력시 채팅 보내지는 메크로 
	$(document).keydown(function(e) {
		if(e.which == 13 && e.ctrlKey) {
			if($('.chatSendMsg').val().trim() != "") {
				$('.record-message').trigger("click");
			} 
		}
	});
	
	// 페이지 없어질 때 상태에 따른 쿠키 저장
	$(window).on('beforeunload', function() {
		var login = "${sessionScope.dto.id}";
		if(login != null && login != "") {
			document.cookie = "chatPage=" + escape(3) + "; path=/;";
			document.cookie = "chatWho=" + escape(2) + "; path=/;";
			
			var currentScroll = $('main').scrollTop();
			var opponentNick = "${opponent}";
			document.cookie = "chatOpponent=" + escape(opponentNick) + "; path=/;";
			document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";	
		}
	});
	
	// 웹소켓 연결
	var webSocket = new WebSocket("ws://192.168.0.2:8081/b/ws");
	webSocket.onopen = function() {
		// 상대방의 채팅 메세지에 읽음 표시 삭제
		var opponentNick = "${opponent}";
		webSocket.send("connected with " + opponentNick);
	}
	webSocket.onerror = function() {
		alert('웹소켓 에러');
	} 
	webSocket.onmessage = function(data) {
		if(data.data == "connected Opponent") {
			// 상대방이 읽었을 때 읽음 상태 해제
			$('.readcheck').each(function() {
					$(this).remove();
			});
		} else {
			// 상대방에게서 메세지가 왔을 때
			var msg = JSON.parse(data.data);
			var nickname = "${sessionScope.dto.nickname}";
			var opponentNick = "${opponent}";
			var path = "${pageContext.request.contextPath}";
			
			// 메세지가 예약관련 메세지 일 떄
			if(msg.message_type == "reservation") {
				if((msg.r_guest == nickname && msg.r_host == opponentNick) || (msg.r_guest == opponentNick && msg.r_host == nickname)) {
					// 메세지 구분
					var content = "";
					if(msg.r_status == "예약중") {
						content += msg.r_guest + "님의 예약요청입니다.";
					} else if(msg.r_status == "예약완료") {
						content += msg.r_host + "님이 예약을 승인했습니다.";
					} else if(msg.r_status == "예약취소") {
						alert(msg.r_agree);
						if(msg.r_agree != "") {
							if(msg.r_hostRead == 'false') {
								content += msg.r_guest + "님이 예약을 취소했습니다.";
							} else if(msg.r_guestRead == 'false') {
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
						if(msg.r_status == "예약중") {
							appendChatListFromMe(content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt"  value="요청사항 보기">', msg.r_lastDate);
						} else if(msg.r_status == "예약완료") {
							appendChatListToMe(msg.r_host, msg.r_host_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
							changeChatBtnCounter(1);
							chatReading(msg.r_host, msg.r_guest, opponentNick);
						} else if(msg.r_status == "예약취소") {
							if(msg.r_agree != "") {
								if(msg.r_hostRead == 'false') {
									appendChatListFromMe(content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt"  value="요청사항 보기">', msg.r_lastDate);
								} else if(msg.r_guestRead == 'false') {
									appendChatListToMe(msg.r_host, msg.r_host_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
									changeChatBtnCounter(1);
									chatReading(msg.r_host, msg.r_guest, opponentNick);
								}
							} else {
								if(msg.r_hostRead == 'false') {
									appendChatListFromMe(content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt"  value="요청사항 보기">', msg.r_lastDate);
								} else if(msg.r_guestRead == 'false') {
									appendChatListToMe(msg.r_host, msg.r_host_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
									changeChatBtnCounter(1);
									chatReading(msg.r_host, msg.r_guest, msg, opponentNick);
								}
							}
						} else if(msg.r_status == "사용완료") {
							appendChatListFromMe(content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt"  value="요청사항 보기">', msg.r_lastDate);
						}
							
					// 다른 사람이 요청했을 경우
					} else if(msg.r_host == nickname ) {
						if(msg.r_status == "예약중") {
							appendChatListToMe(msg.r_guest, msg.r_guest_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
							changeChatBtnCounter(1);
							chatReading(msg.r_guest, msg.r_host, opponentNick);
						} else if(msg.r_status == "예약완료") {
							appendChatListToMe(msg.r_guest, msg.r_guest_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
						} else if(msg.r_status == "예약취소") {
							if(msg.r_agree != "") {
								if(msg.r_hostRead == 'false') {
									appendChatListToMe(msg.r_guest, msg.r_guest_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
									changeChatBtnCounter(1);
									chatReading(msg.r_guest, msg.r_host, opponentNick);
								} else if(msg.r_guestRead == 'false') {
									appendChatListFromMe(content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt"  value="요청사항 보기">', msg.r_lastDate);
								}
							} else {
								if(msg.r_hostRead == 'false') {
									appendChatListToMe(msg.r_guest, msg.r_guest_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
									changeChatBtnCounter(1);
									chatReading(msg.r_guest, msg.r_host, opponentNick);
								} else if(msg.r_guestRead == 'false') {
									appendChatListFromMe(content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt"  value="요청사항 보기">', msg.r_lastDate);
								}
							}
						} else if(msg.r_status == "사용완료") {
							appendChatListToMe(msg.r_guest, msg.r_guest_profileImg, content + '<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">', msg.r_lastDate, path);
							changeChatBtnCounter(1);
							chatReading(msg.r_guest, msg.r_host, opponentNick);
						}
					}
				// 해당 방의 상대방이 아닌 다른 사람일 때
				} else if ((msg.r_guest == nickname && msg.r_host != opponentNick) || (msg.r_guest != opponentNick && msg.r_host == nickname)) {
					if(msg.r_host == nickname ) {
						if(msg.r_status == "예약중") {
							changeChatBtnCounter(2);
						} else if(msg.r_status == "예약완료") {
							
						} else if(msg.r_status == "예약취소") {
							if(msg.r_agree != "") {
								if(msg.r_hostRead == 'false') {
									changeChatBtnCounter(2);
								} else if(msg.r_guestRead == 'false') {
								
								}
							} else {
								if(msg.r_hostRead == 'false') {
									changeChatBtnCounter(2);
								} else if(msg.r_guestRead == 'false') {
									
								}
							}
						} else if(msg.r_status == "사용완료") {
							changeChatBtnCounter(2);
						}
					} else if(msg.r_guest == nickname) {
						if(msg.r_status == "예약중") {
							
						} else if(msg.r_status == "예약완료") {
							changeChatBtnCounter(2);
						} else if(msg.r_status == "예약취소") {
							if(msg.r_agree != "") {
								if(msg.r_hostRead == 'false') {
									
								} else if(msg.r_guestRead == 'false') {
									changeChatBtnCounter(2);
								}
							} else {
								if(msg.r_hostRead == 'false') {
									
								} else if(msg.r_guestRead == 'false') {
									changeChatBtnCounter(2);
								}
							}
						} else if(msg.r_status == "사용완료") {
							
						}
					}
				}
				
			} else {
				// 자신이 보낸 메세지일 때
				if(msg.fromNick == nickname && msg.toNick == opponentNick) {
					appendChatListFromMe(msg.content, msg.writeDate);
					
				// 상대방이 보낸 매세지인데 방나간 메세지가 아닐때	
				} else if(msg.fromNick == opponentNick && msg.toNick == nickname && msg.content) {
					// 상대방의 메세지가 방나갔다는 메세지 일 때
					if(msg.content == "#$%Room Out#$%") {
						$('.chat').append('<div class="date-divider"><span class="date-divider__text">' + opponentNick + '님이 방을 나갔습니다.</span></div>');
						changeChatState();
					// 일반 메세지 일 때
					} else {
						appendChatListToMe(msg.fromNick, msg.fromNick_profileImg, msg.content, msg.writeDate, path);				
						chatReading(msg.fromNick, msg.toNick, opponentNick);
					}
						
				// 해당 방의 상대방이 아닌 다른 사용자의 메세지가 왔을 때
				} else if(msg.fromNick != opponentNick && msg.toNick == nickname) {
					// 메세지가 일반 메세지이면 버튼 카운트 +1
					changeChatBtnCounter(1);
					return false;
				}
				
			}
			// 스크롤을 맨 아래로 내림
			$("main").scrollTop($("main")[0].scrollHeight);
		}
		
	} 
</script>
<body class="body-chat">
  <header class="top-header chat-header">
    <div class="header__bottom">
      <div class="header__column">
        <a href="javascript:location.replace('../chat/chats.do');">
          <i class="fa fa-chevron-left fa-lg"></i>
        </a>
      </div>
      <div class="header__column">
        <span class="header__text">${opponent}</span>
      </div>
      <div class="header__column">
      		<i class="fas fa-door-open fa-lg"></i>
      </div>
    </div>
  </header>
<main class="chat">
  <c:if test="${list.size() == 0 }">
  	<div class="date-divider">
    	<span class="date-divider__text">대화 내용이 존재하지 않습니다. 채팅을 입력하세요.</span>
  	</div>
  </c:if>
  <c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
  	<c:choose >
  		<c:when test="${list.fromNick == sessionScope.dto.nickname}">
		  <div class="chat__message chat__message-from-me">
		    <span class="chat__message-time">
		    	<c:if test="${list.readCheck == 0}">
		    		<font class="readcheck" color="yellow"> 1 &nbsp; </font>
		    	</c:if>
		    	${list.writeDate}
		    </span>
		    <span class="chat__message-body">
		      ${list.content}
		      <c:if test="${list.messageType == 'reservationRequest'}">
		      	<br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">
		      </c:if>
		    </span>
		  </div>
  		</c:when>
  		
  		<c:when test="${list.fromNick != sessionScope.dto.nickname && list.content != '#$%Room Out#$%' }">
		  <div class="chat__message chat__message-to-me">
		    <img src="${pageContext.request.contextPath}/resources/upload/${list.fromNick_profileImg}" alt="" class="chat-message-avatar">
		    <div class="chat__message-center">
		      <h3 class="chat__message-username">${list.fromNick}</h3>
		      <span class="chat__message-body">
		        ${list.content}
		        <c:if test="${list.messageType == 'reservationRequest'}">
		      	  <br><hr class="chatBtHr"><input type="button" class="btn btn-outline-success chatReservationBt" value="요청사항 보기">
		     	</c:if>
		      </span>
		    </div>
		    <span class="chat__message-time">${list.writeDate}</span>
		  </div>
  		</c:when>
  		<c:otherwise>
	  		<div class="date-divider">
	  			<span class="date-divider__text opponentOut">${list.fromNick}님이 방을 나갔습니다.</span>
	  		</div>
  		</c:otherwise>
  	</c:choose>
  </c:forEach>
</main>
<div class="type-message">
  <i class="fa fa-plus fa-lg"></i>
  <div class="type-message__input">
    <textarea class="chatSendMsg" placeholder="ctrl+enter로 전송가능합니다."></textarea>
    <button class="record-message" disabled="disabled">
      <i class="fa fa-chevron-circle-right fa-lg"></i>
    </button>
  </div>
</div>
<script type="text/javascript">
	// 메세지 보내기 동작
	$('.record-message').click(function() {
		String.prototype.replaceAll = function(org, dest) {
		    return this.split(org).join(dest);
		}
		var content = $('.chatSendMsg').val();
		var opponentNick = "${opponent}";
		
		content = content.replaceAll('"','\\"');
		var nickname = "${sessionScope.dto.nickname}";
		var profileImg = "${sessionScope.dto.profile_img}";
		var jsonMsg = '{"messageType": "normal","fromNick":"'+nickname+'", "toNick":"'+ opponentNick +'", "content":"' + content+'", "readCheck":"0" , "fromNick_profileImg" : "' + profileImg + '"}';
		webSocket.send(jsonMsg);
		$('.chatSendMsg').val("");
		$('.chatSendMsg').focus();
		$('.record-message').attr("disabled","disabled");
	});
	
	// 방나가기 버튼 클릭
	$('.fa-door-open').click(function() {
		swal({
			  title: "방나가기",
			  text: "정말로 방을 나가시겠습니까? \n방을 나가면 채팅 기록을 확인 할 수 없습니다.",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
		 })
		 .then((willDelete) => {
			  if(willDelete) {
				  // 상대방이 방을 나가지 않은 상태일 때
				  if(!opponentOutCheck) {
					  var content = "#$%Room Out#$%";
					  var opponentNick = "${opponent}";
					  var nickname = "${sessionScope.dto.nickname}";
					  var profileImg = "${sessionScope.dto.profile_img}";
					  var jsonMsg = '{"messageType": "normal","fromNick":"'+nickname+'", "toNick":"'+ opponentNick +'", "content":"' + content+'", "readCheck":"1" , "fromNick_profileImg" : "' + profileImg + '"}';
					  webSocket.send(jsonMsg);
					  swal("잠시만 기다려주세요....", {
						  buttons: false,
						  timer: 1000,
					  });
					  setTimeout(function(){location.replace('../chat/chats.do')},1000);
			  	  } else {
			  	  // 상대방이 나간 상태일 때
			  		  var opponentNick = "${opponent}";
			  		  location.replace('../chatting/chatAllDelete.do?toNick='+opponentNick);
			  	  }
			  } else {
				  
			  }
		  });
	});
</script>
<script src="../resources/chat/js/navigation.js"></script>
<script src="../resources/chat/js/chat.js"></script>
<script src="../resources/js/bootstrap/bootstrap.min.js"></script>
</body>
</html>
