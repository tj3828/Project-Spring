// 상대방이 나갔는지 체크
var opponentOutCheck = false;

// 상대방이 나갔다고 하는 메세지가 있을 경우 처리
if($('body').find('.opponentOut').length != 0) {
	changeChatState();
}

// 상대방이 나갔을 때 동작
function changeChatState() {
	$('.record-message').attr("disabled","disabled");
	$('.chatSendMsg').attr("placeholder","상대방이 나갔습니다.");
	$('.chatSendMsg').attr("readonly","readonly");
	$('.chatSendMsg').css("outline","none");
	opponentOutCheck = true;
}

// 메세지입력 시에만 버튼 활성화
$('.chatSendMsg').change(function() {
	if($('.chatSendMsg').val() == "" || $('.chatSendMsg').val() == null) {
		$('.record-message').attr("disabled","disabled");
	} else {
		$('.record-message').removeAttr("disabled" );
	}
});