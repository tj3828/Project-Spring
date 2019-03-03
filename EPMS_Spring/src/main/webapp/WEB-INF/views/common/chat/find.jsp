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
  <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
  <link rel="stylesheet" href="../resources/css/bootstrap/bootstrap.min.css">
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
		
		var notReadCount = "${notReadCount}"*1;
		var reservationNotReadCount = "${reservationNotReadCount}"*1;
		initNotReadCount(notReadCount, reservationNotReadCount);
		
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
			var path = "${pageContext.request.contextPath}";
			if(msg.message_type == "reservation") {
				if(msg.r_status == "예약중") {
					if(msg.r_host == nickname) {
						var html = prependReservationList(2, msg.r_guest, msg.r_guest_profileImg, path, msg.r_status, msg.r_no, msg.r_from + " ~ " + msg.r_to, msg.r_lastDate, msg.r_content);
						$('.find_Response ul').prepend(html);
						changeResponseNotReadCount(1);
						changeChatsReadCounter();
						changeChatBtnCounter(2);
						changeReservationReadCounter(1);
					} else if(msg.r_guest == nickname) {
						var html = prependReservationList(1, msg.r_host, msg.r_host_profileImg, path, msg.r_status, msg.r_nom, msg.r_from + " ~ " + msg.r_to, msg.r_lastDate, msg.r_content);
						$('.find_Request ul').prepend(html);
					}
				
				} else if(msg.r_status == "예약완료") {
					$(".list"+msg.r_no).closest("li").remove();
					if(msg.r_host == nickname) {
						var html = prependReservationList(2, msg.r_guest, msg.r_guest_profileImg, path, msg.r_status, msg.r_no, msg.r_from + " ~ " + msg.r_to, msg.r_lastDate, msg.r_content);
						$('.find_Response ul').prepend(html);
					} else if(msg.r_guest == nickname) {
						var html = prependReservationList(1, msg.r_host, msg.r_host_profileImg, path, msg.r_status, msg.r_no, msg.r_from + " ~ " + msg.r_to, msg.r_lastDate, msg.r_content);
						$('.find_Request ul').prepend(html);
						changeRequestNotReadCount(1);
						changeChatsReadCounter();
						changeChatBtnCounter(2);
					}
				} else if(msg.r_status == "예약취소" || msg.r_status == "사용완료") {
					$(".list"+msg.r_no).closest("li").remove();
					var html = prependReservationListEx(msg, nickname, path);
					prependReservationListEx(html);
					
					if(msg.r_guest == nickname && msg.r_guestRead == 'false') {
						changeExpirationNotReadCount(1);
						changeChatsReadCounter();
						changeChatBtnCounter(2);
					} else if (msg.r_host == nickname && msg.r_hostRead == 'false') {
						changeExpirationNotReadCount(1);
						changeChatsReadCounter();
						changeChatBtnCounter(2);
					}
				} 
								
			} else {
				
				if(msg.toNick == nickname && msg.content != '#$%Room Out#$%') {
					changeChatBtnCounter(1);
					changeChatsReadCounter();
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
        <span class="header__text">Reservation</span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
  <c:set var="responseNotReadCount" value="0"/>
  <c:set var="requestNotReadCount" value="0"/>
  <c:set var="expirationNotReadCount" value="0"/>
  <c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
  	<c:choose>
  		<c:when test="${list.r_host == sessionScope.dto.nickname && (list.r_status == '예약중' || (list.r_status == '예약완료' && list.r_hostRead == 'false') ) }">
  			<c:set var="responseNotReadCount" value="${responseNotReadCount +1}"/>
  		</c:when>
  		<c:when test="${list.r_guest == sessionScope.dto.nickname && ((list.r_status == '예약중' && list.r_guestRead == 'false') || (list.r_status == '예약완료' && list.r_guestRead == 'false'))}">
  			<c:set var="requestNotReadCount" value="${requestNotReadCount +1 }"/>
  		</c:when>
  		<c:when test="${list.r_host == sessionScope.dto.nickname  && (list.r_status == '사용완료' || list.r_status == '예약취소') && list.r_host == 'false' }">
  			<c:set var="expirationNotReadCount" value="${expirationNotReadCount +1 }"/>
  		</c:when>
  		<c:when test="${list.r_guest == sessionScope.dto.nickname  && (list.r_status == '사용완료' || list.r_status == '예약취소') && list.r_guest == 'false' }">
  			<c:set var="expirationNotReadCount" value="${expirationNotReadCount +1 }"/>
  		</c:when>
  	</c:choose>	
  </c:forEach>
  <main class="find" style="position:fixed; width:100%;">
    <section class="find__options">
      <div class="find__option">
     	<a class="responsePageBt find__option--selected"  style="display: flex; align-items: center; flex-direction: column; text-decoration: none; position: relative;">
	      	<i class="fas fa-file-import fa-lg"></i>
	      	<c:if test="${responseNotReadCount != 0 }">
	      		<span class="responseNotReadCount">${responseNotReadCount}</span>
	      	</c:if>	
	        <span class="find__option-title">Response</span>
        </a>
      </div>
      <div class="find__option">
      	<a class="requestPageBt" style="display: flex; align-items: center; flex-direction: column; text-decoration: none; position: relative;">
	      	<i class="fas fa-file-export fa-lg"></i>
	      	<c:if test="${requestNotReadCount != 0 }">
	      		<span class="requestNotReadCount">${requestNotReadCount}</span>
	      	</c:if>	
	        <span class="find__option-title">Request</span>
	    </a>
      </div>
      <div class="find__option">
      	<a class="expirationPageBt"  style="display: flex; align-items: center; flex-direction: column; text-decoration: none; position: relative;">
	        <i class="far fa-minus-square fa-lg"></i>
	        <c:if test="${expirationNotReadCount != 0 }">
	      		<span class="expirationNotReadCount">${expirationNotReadCount}</span>
	      	</c:if>	
	        <span class="find__option-title">Expiration</span>
     	</a>
      </div>
    </section>
  </main>
  
  <!-- Response Page -->
  <div class="find_Response" style="height:100%;padding-top:80px;">
    <ul style="height:100%;  overflow-y:scroll;">
      <c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
      	<c:if test="${list.r_host == sessionScope.dto.nickname && (list.r_status == '예약중' || list.r_status == '예약완료') }">
      		<li style="">
	      		<header style="padding: 10px; display: flex; position: relative;">
			        <div class="recommend__title" style="display: flex; align-items: flex-start; ">
			        	<img src="${pageContext.request.contextPath}/resources/upload/${list.r_guest_profileImg}" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">
			        	<div>
				        	<h6 class="reservation_title" style="font-weight:bolder; margin-bottom: 5px;">
				        		${list.r_guest} &nbsp;
				        		<c:if test="${list.r_status == '예약중'}">
				        			<font color="red">예약요청</font>
				        		</c:if>
				        		<c:if test="${list.r_status == '예약완료'}">
				        			<font color="blue">요청승인</font>
				        		</c:if>
				        	</h6>
				        	<span style="color: #b4b4b4; font-size: 11px;"> ${list.r_from} ~ ${list.r_to}</span>
			        	</div>
			        </div>
			        <span class="reservation_date" style="position: absolute; right: 15px; width: 100px; text-align: right; font-size: 10px; color: #b4b4b4;" >
		          		${list.r_lastDate}
			   		</span>
			    </header>
			    <div class="recommended__none">
			    	<div style="padding-bottom:10px;">
			        	<span class="recommended__text">${list.r_content}</span>
			        </div>
			        <c:choose>
			        	<c:when test="${list.r_status == '예약중'}">
					        <div class="reservation_RequestBt">
					        	<input type="button" class="btn btn-primary" onclick="acceptReservation(${list.r_no})" value="수락">
					        	<input type="button" class="btn btn-danger" onclick="rejectReservation(${list.r_no})" value="거절">
						        <input type="hidden" class="list${list.r_no}" value="${list.r_no}">
							</div>
			        	</c:when>
			        	<c:when test="${list.r_status == '예약완료'}">
			        		<div class="reservation_RequestBt">
				        		<input type="button" class="btn btn-danger" onclick="cancelReservationHost(${list.r_no})" value="승인취소">
    							<input type="hidden" class="list${list.r_no}" value="${list.r_no}">
					        </div>	        		
			        	</c:when>
			        </c:choose>
			    </div>
		    </li>
      	</c:if>
      </c:forEach>
    </ul>
  </div>
  
  <!-- Request Page -->
  <div class="find_Request" style="height:100%;padding-top:80px; display: none;">
    <ul style="height:100%;  overflow-y:scroll;">
      <c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
      	<c:if test="${list.r_guest == sessionScope.dto.nickname && (list.r_status == '예약중' || list.r_status == '예약완료') }">
      		<li style="">
	      		<header style="padding: 10px; display: flex; position: relative;">
			        <div class="recommend__title" style="display: flex; align-items: flex-start; ">
			        	<img src="${pageContext.request.contextPath}/resources/upload/${list.r_host_profileImg}" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">
			        	<div>
				        	<h6 style="font-weight:bolder; margin-bottom: 5px;">${list.r_host} &nbsp;
				        	<c:if test="${list.r_status == '예약완료' }">
				        		<font color="blue">예약승낙</font>
				        	</c:if>
				        	<c:if test="${list.r_status == '예약중' }">
				        		<font color="red">예약중...</font>
				        	</c:if>
				        	</h6>
				        	<span style="color: #b4b4b4; font-size: 11px;"> ${list.r_from} ~ ${list.r_to}</span>
			        	</div>
			        </div>
			        <span style="position: absolute; right: 15px; width: 100px; text-align: right; font-size: 10px; color: #b4b4b4;" >
		          		${list.r_lastDate}
			   		</span>
			    </header>
			    <div class="recommended__none">
			    	<div style="padding-bottom:10px;">
			        	<span class="recommended__text">${list.r_content}</span>
			        </div>
			        <div class="reservation_RequestBt">
				        <c:if test="${list.r_guestRead == 'false'}">
					        	<input type="button" class="btn btn-primary changeGuestReadCheck" onclick="changeGuestReadCheck(${list.r_no});" value="확인">
				        </c:if>
					        	<input type="hidden" class="list${list.r_no}" value="${list.r_no}">
					        	<input type="button" class="btn btn-danger" onclick="cancelReservationGuest(${list.r_no},'${list.r_guestRead}')" value="예약취소">
			        </div>
			    </div>
		    </li>
      	</c:if>
      </c:forEach>
    </ul>
  </div>
  
  <!-- Expiration Page -->
  <div class="find_Expiration" style="height:100%;padding-top:80px; display: none;"> 
    <ul style="height:100%;  overflow-y:scroll;">
      <c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
      	<c:if test="${list.r_guest == sessionScope.dto.nickname && (list.r_status == '사용완료' || list.r_status == '예약취소') }">
      		<li style="">
	      		<header style="padding: 10px; display: flex; position: relative;">
			        <div class="recommend__title" style="display: flex; align-items: flex-start; ">
			        	<img src="${pageContext.request.contextPath}/resources/upload/${list.r_guest_profileImg}" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">
			        	<div>
			        		<span style="color: green; font-size: 11px;">신청자</span>
				        	<h6 style="font-weight:bolder; margin-bottom: 5px;">${list.r_guest}</h6>
			        	</div>
			        	<i class="fas fa-arrow-alt-circle-right fa-lg" style="margin-top: auto; margin-bottom: auto; margin-right: 10px; margin-left: 10px; color: red;"></i>
			        	<img src="${pageContext.request.contextPath}/resources/upload/${list.r_host_profileImg}" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">
			        	<div>
			        		<span style="color: purple; font-size: 11px;">대여자</span>
				        	<h6 style="font-weight:bolder; margin-bottom: 5px;">${list.r_host}</h6>
			        	</div>
			        </div>
			        <span style="position: absolute; right: 15px; width: 100px; text-align: right; font-size: 10px; color: #b4b4b4;" >
		          		${list.r_lastDate}
			   		</span>
			   		<c:if test="${list.r_status == '예약취소' }">
			   			<h3 style="position: absolute; bottom:15px; right: 15px; width: 100px; text-align: right; font-weight:bold; color: #b4b4b4;"><font color="red">${list.r_status}</font></h3> 
			   		</c:if>
			   		<c:if test="${list.r_status == '사용완료' }">
			   			<h3 style="position: absolute; bottom:15px; right: 15px; width: 100px; text-align: right; font-weight:bold; color: #b4b4b4;"><font color="blue">${list.r_status}</font></h3> 
			   		</c:if>
			    </header>
			    <div class="recommended__none">
			    	<div style="padding-bottom:10px;">
			        	<span class="recommended__text">${list.r_from} ~ ${list.r_to}</span>
			        </div>
			        <c:if test="${list.r_guestRead == 'false' }">
				        <div class="reservation_RequestBt">
				        	<input type="button" class="btn btn-primary expirationNotReadCount" onclick="changeGuestReadCheckEx(${list.r_no});" value="확인">
				        	<input type="hidden" class="list${list.r_no}" value="${list.r_no}">
				        </div>
			        </c:if>
			    </div>
		    </li>
      	</c:if>
      	<c:if test="${list.r_host == sessionScope.dto.nickname && (list.r_status == '사용완료' || list.r_status == '예약취소') }">
      		<li style="">
	      		<header style="padding: 10px; display: flex; position: relative;">
			        <div class="recommend__title" style="display: flex; align-items: flex-start; ">
			        	<img src="${pageContext.request.contextPath}/resources/upload/${list.r_guest_profileImg}" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">
			        	<div>
			        		<span style="color: green; font-size: 11px;">신청자</span>
				        	<h6 style="font-weight:bolder; margin-bottom: 5px;">${list.r_guest}</h6>
			        	</div>
			        	<i class="fas fa-arrow-alt-circle-right fa-lg" style="margin-top: auto; margin-bottom: auto; margin-right: 10px; margin-left: 10px; color: red;"></i>
			        	<img src="${pageContext.request.contextPath}/resources/upload/${list.r_host_profileImg}" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">
			        	<div>
			        		<span style="color: purple; font-size: 11px;">대여자</span>
				        	<h6 style="font-weight:bolder; margin-bottom: 5px;">${list.r_host}</h6>
			        	</div>
			        </div>
			        <span style="position: absolute; right: 15px; width: 100px; text-align: right; font-size: 10px; color: #b4b4b4;" >
		          		${list.r_lastDate}
			   		</span>
			   		<c:if test="${list.r_status == '예약취소' }">
			   			<h3 style="position: absolute; bottom:15px; right: 15px; width: 100px; text-align: right; font-weight:bold; color: #b4b4b4;"><font color="red">${list.r_status}</font></h3> 
			   		</c:if>
			   		<c:if test="${list.r_status == '사용완료' }">
			   			<h3 style="position: absolute; bottom:15px; right: 15px; width: 100px; text-align: right; font-weight:bold; color: #b4b4b4;"><font color="blue">${list.r_status}</font></h3> 
			   		</c:if>
			    </header>
			    <div class="recommended__none">
			    	<div style="padding-bottom:10px;">
			        	<span class="recommended__text">${list.r_from} ~ ${list.r_to}</span>
			        </div>
			        <c:if test="${list.r_hostRead == 'false' }">
				        <div class="reservation_RequestBt">
				        	<input type="button" class="btn btn-primary expirationNotReadCount" onclick="changeHostReadCheckEx(${list.r_no});"  value="확인">
				        	<input type="hidden" class="list${list.r_no}" value="${list.r_no}">
				        </div>
			        </c:if>
			    </div>
		    </li>
      	</c:if>
      </c:forEach>
    </ul>
  </div>
    
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
      <span class="tab-bar__title">Reservation</span>
    </a>
    <a href="javascript:location.replace('../chat/more.do')" class="tab-bar__tab">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
  <script src="../resources/js/bootstrap/bootstrap.min.js"></script>
  <script src="../resources/chat/js/navigation.js"></script>
  <script src="../resources/chat/js/find.js"></script>
</body>
</html>
