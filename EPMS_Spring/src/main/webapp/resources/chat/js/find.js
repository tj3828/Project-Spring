$('.responsePageBt').click(function () {
	$('.find__option a').removeClass('find__option--selected');
	$(this).addClass('find__option--selected');
	$('.find_Request').hide();
	$('.find_Expiration').hide();
	$('.find_Response').show();
});

$('.requestPageBt').click(function () {
	$('.find__option a').removeClass('find__option--selected');
	$(this).addClass('find__option--selected');
	$('.find_Response').hide();
	$('.find_Expiration').hide();
	$('.find_Request').show();
});

$('.expirationPageBt').click(function () {
	$('.find__option a').removeClass('find__option--selected');
	$(this).addClass('find__option--selected');
	$('.find_Response').hide();
	$('.find_Request').hide();
	$('.find_Expiration').show();
});

function changeGuestReadCheck(r_no){
	$.ajax({
		url : "../reservation/changeGuestReadCheck.do",
		type: "post",
		data : {"r_no":r_no},
		success: function() {
			var cnt = $('.requestNotReadCount').html()*1; 
			$('.requestNotReadCount').html(cnt-1);
			if(cnt == 1) {
				$('.requestNotReadCount').remove();
			}
			changeChatBtnCounter(-1);
			changeReservationReadCounter(-1);
			$(".list"+r_no).closest("div").find('.changeGuestReadCheck').remove();
		}
	});
}

function changeGuestReadCheckEx(r_no){
	$.ajax({
		url : "../reservation/changeGuestReadCheck.do",
		type: "post",
		data : {"r_no":r_no},
		success: function() {
			var cnt = $('.expirationNotReadCount').html()*1; 
			$('.expirationNotReadCount').html(cnt-1);
			if(cnt == 1) {
				$('.expirationNotReadCount').remove();
			}
			changeChatBtnCounter(-1);
			changeReservationReadCounter(-1);
			$(".list"+r_no).closest("div").find('.expirationNotReadCount').remove();
		}
	});
}

function changeHostReadCheck(r_no){
	$.ajax({
		url : "../reservation/changeHostReadCheck.do",
		type: "post",
		data : {"r_no":r_no},
		success: function() {
			var cnt = $('.responseNotReadCount').html()*1; 
			$('.responseNotReadCount').html(cnt-1);
			if(cnt == 1) {
				$('.responseNotReadCount').remove();
			}
			changeChatBtnCounter(-1);
			changeReservationReadCounter(-1);
			$(".list"+r_no).closest("div").remove();
		}
	});
}

function changeHostReadCheckEx(r_no){
	$.ajax({
		url : "../reservation/changeHostReadCheck.do",
		type: "post",
		data : {"r_no":r_no},
		success: function() {
			var cnt = $('.expirationNotReadCount').html()*1; 
			$('.expirationNotReadCount').html(cnt-1);
			if(cnt == 1) {
				$('.expirationNotReadCount').remove();
			}
			changeChatBtnCounter(-1);
			changeReservationReadCounter(-1);
			$(".list"+r_no).closest("div").find('.expirationNotReadCount').remove();
		}
	});
}

function cancelReservationGuest(r_no,readCheck){
	if(readCheck == 'false') {
		changeChatBtnCounter(-1);
		changeReservationReadCounter(-1);
		changeRequestNotReadCount(-1);
	}
	
	webSocket.send("ReservationCancelGuest#"+r_no);
}

function cancelReservationHost(r_no){	
	webSocket.send("ReservationCancelHost#"+r_no);
}

function acceptReservation(r_no) {
	
	changeChatBtnCounter(-1);
	changeReservationReadCounter(-1);
	changeResponseNotReadCount(-1);
	webSocket.send("ReservationAccept#"+r_no);
	
	/*$.ajax({
		url : "../reservation/acceptReservation.do",
		type: "post",
		data : {"r_no":r_no},
		dataType: "json",
		success: function(data) {
			var cnt = $('.responseNotReadCount').html()*1; 
			$('.responseNotReadCount').html(cnt-1);
			if(cnt == 1) {
				$('.responseNotReadCount').remove();
			}
			changeChatBtnCounter(-1);
			changeReservationReadCounter(-1);
			
			alert(data.dto.r_guest + " / " + data.dto.r_lastDate);
			var container = $(".list"+r_no).closest("li");
			$('.find_Response ul').prepend(container);
			container.find('.reservation_title').html(data.dto.r_guest+' &nbsp;<font color="blue">요청승인</font>');
			container.find('.reservation_date').html(data.dto.r_lastDate);
			
			$(".list"+r_no).closest("div").html(''+
					'<input type="button" class="btn btn-danger" onclick="cancelReservation('+r_no+')" value="승인취소">' +
    				'<input type="hidden" class="list'+r_no+'" value="'+r_no+'">');
		}
	});*/
}

function rejectReservation(r_no) {
	changeChatBtnCounter(-1);
	changeReservationReadCounter(-1);
	changeResponseNotReadCount(-1);
	webSocket.send("ReservationInject#"+r_no);
}

function prependReservationList(type, nick, nick_profile_Img, path, status, num, term, writeDate, content) {
	var title_html = nick + " ";
	var typeBt_html = "";
	
	// type=1 - 요청한 것, type=2 - 요청 받은 것, type=3 - 만료
	if(status == '예약중') {
		if(type == 1) {
			title_html += '<font color="red">예약중...</font>';
			typeBt_html += '' +
				'<div class="reservation_RequestBt">' +
		        	'<input type="hidden" class="list'+ num +'" value="'+ num +'">' +
		        '</div>';
		} else if(type == 2) {
			title_html += '<font color="red">예약요청</font>';
			typeBt_html += '' +
				'<div class="reservation_RequestBt">' +
			    	'<input type="button" class="btn btn-primary" onclick="acceptReservation(' + num + ')" value="수락">' + 
			    	'<input type="button" class="btn btn-danger" onclick="rejectReservation(' + num + ')" value="거절">' +
			        '<input type="hidden" class="list'+ num +'" value="'+ num +'">' +
				'</div>';
		}
		
	} else if(status == '예약완료') {
		if(type == 2) {
			title_html += '<font color="blue">요청승인</font>';
			typeBt_html += '' +
				'<div class="reservation_RequestBt">' +
					'<input type="button" class="btn btn-danger" onclick="cancelReservationHost('+ num +')" value="승인취소">' +
					'<input type="hidden" class="list'+ num +'" value="'+ num +'">' +
				'</div>';	
		} else if(type == 1) {
			title_html += '<font color="blue">예약승낙</font>';
			typeBt_html += '' +
				'<div class="reservation_RequestBt">' +
					'<input type="button" class="btn btn-primary changeGuestReadCheck" onclick="changeGuestReadCheck('+ num +');" value="확인">' +
					'<input type="button" class="btn btn-danger" onclick="cancelReservationGuest('+ num +',\'false\')" value="예약취소">' +
					'<input type="hidden" class="list'+ num +'" value="'+ num +'">' +
				'</div>';
		}
	}
	
	var list = '' +
  			'<li style="">' +
      			'<header style="padding: 10px; display: flex; position: relative;">' +
      				'<div class="recommend__title" style="display: flex; align-items: flex-start; ">' +
      					'<img src="' + path + '/resources/upload/' + nick_profile_Img + '" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">' +
      					'<div>' +
	      					'<h6 class="reservation_title" style="font-weight:bolder; margin-bottom: 5px;">' +
				        		title_html +
				        	'</h6>' +
				        	'<span style="color: #b4b4b4; font-size: 11px;"> ' + term + ' </span>' +
				         '</div>' +
				      '</div>' +
				      '<span class="reservation_date" style="position: absolute; right: 15px; width: 100px; text-align: right; font-size: 10px; color: #b4b4b4;" >' +
				        	writeDate +
				      '</span>' +
				 '</header>' +
				 '<div class="recommended__none">' +
			    	 '<div style="padding-bottom:10px;">' +
			         	'<span class="recommended__text">' + content + '</span>' +
			         '</div>' +
			         typeBt_html +
			     '</div>' +
			 '</li>'; 
	
	return list;
}

function prependReservationListEx(msg, nickname, path) {
	var title_html = "";
	var typeBt_html = "";
	
	if(msg.r_status == '예약취소') {
		title_html += '<h3 style="position: absolute; bottom:15px; right: 15px; width: 100px; text-align: right; font-weight:bold; color: #b4b4b4;"><font color="red">' + msg.r_status + '</font></h3>';
	} else if(msg.r_status == '사용완료') {
		title_html += '<h3 style="position: absolute; bottom:15px; right: 15px; width: 100px; text-align: right; font-weight:bold; color: #b4b4b4;"><font color="blue">' + msg.r_status + '</font></h3>';
	}
	
	if(msg.r_guest == nickname && msg.r_guestRead == 'false') {
		typeBt_html += '<div class="reservation_RequestBt">' +
        					'<input type="button" class="btn btn-primary expirationNotReadCount" onclick="changeGuestReadCheckEx(' + msg.r_no + ');" value="확인">' +
        					'<input type="hidden" class="list' + msg.r_no + '" value="' + msg.r_no + '">' +
        				'</div>';
	} else if(msg.r_host == nickname && msg.r_hostRead == 'false') {
		typeBt_html += '<div class="reservation_RequestBt">' +
							'<input ty+pe="button" class="btn btn-primary expirationNotReadCount" onclick="changeHostReadCheckEx(' + msg.r_no + ');" value="확인">' +
							'<input type="hidden" class="list' + msg.r_no + '" value="' + msg.r_no + '">' +
					    '</div>';
	}
	
	var list = '' +
  			'<li style="">' +
      			'<header style="padding: 10px; display: flex; position: relative;">' +
      				'<div class="recommend__title" style="display: flex; align-items: flex-start; ">' +
      					'<img src="' + path + '/resources/upload/' + msg.r_guest_profileImg + '" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">' +
      					'<div>' +
	      					'<span style="color: green; font-size: 11px;">신청자</span>' +
				        	'<h6 style="font-weight:bolder; margin-bottom: 5px;">' + msg.r_guest + '</h6>' +
				         '</div>' +
				         '<i class="fas fa-arrow-alt-circle-right fa-lg" style="margin-top: auto; margin-bottom: auto; margin-right: 10px; margin-left: 10px; color: red;"></i>' +
				         '<img src="' + path + '/resources/upload/' + msg.r_host_profileImg + '" alt="" height="37px" style="margin-right: 5px;"class="chat-message-avatar">' +
      					 '<div>' +
	      					'<span style="color: green; font-size: 11px;">대여자</span>' +
				        	'<h6 style="font-weight:bolder; margin-bottom: 5px;">' + msg.r_host + '</h6>' +
				         '</div>' +
				      '</div>' +
				      '<span style="position: absolute; right: 15px; width: 100px; text-align: right; font-size: 10px; color: #b4b4b4;" >' +
				        	msg.r_lastDate +
				      '</span>' +
				      title_html +
				 '</header>' +
				 '<div class="recommended__none">' +
			    	 '<div style="padding-bottom:10px;">' +
			         	'<span class="recommended__text">' + msg.r_from + " ~ " + msg.r_to + '</span>' +
			         '</div>' +
			         typeBt_html +
			     '</div>' +
			 '</li>'; 
	
	return list;
}

function changeResponseNotReadCount(num){
	var cnt = $('.responseNotReadCount').html()*1; 
	if(cnt == null || cnt == "" || cnt == 0 || isNaN(cnt)) {
		$('.find__option a .fa-file-import').after('<span class="responseNotReadCount"></span>');
		cnt = 0;
	}
	cnt += num;
	if(cnt == 0) {
		$('.responseNotReadCount').remove();
		return false;
	}
	$('.responseNotReadCount').html(cnt);
}

function changeRequestNotReadCount(num){
	var cnt = $('.requestNotReadCount').html()*1; 
	if(cnt == null || cnt == "" || cnt == 0 || isNaN(cnt)) {
		$('.find__option a .fa-file-export').after('<span class="requestNotReadCount"></span>');
		cnt = 0;
	}
	cnt += num;
	if(cnt == 0) {
		$('.requestNotReadCount').remove();
		return false;
	}
	$('.requestNotReadCount').html(cnt);
}

function changeExpirationNotReadCount(num){
	var cnt = $('.expirationNotReadCount').html()*1; 
	if(cnt == null || cnt == "" || cnt == 0 || isNaN(cnt)) {
		$('.find__option a .fa-minus-square').after('<span class="expirationNotReadCount"></span>');
		cnt = 0;
	}
	cnt += num;
	if(cnt == 0) {
		$('.expirationNotReadCount').remove();
		return false;
	}
	$('.expirationNotReadCount').html(cnt);
}