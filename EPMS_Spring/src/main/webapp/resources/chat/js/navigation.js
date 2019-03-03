function changeChatBtnCounter(count){
	var chatBt_notReadCounter = parent.$('.chatBt_notReadCounter').html() *1;

	if(chatBt_notReadCounter == null || chatBt_notReadCounter == "" || chatBt_notReadCounter == 0 || isNaN(chatBt_notReadCounter)) {
		parent.$('button.chatBt').after('<span class="chatBt_notReadCounter"></span>');
		chatBt_notReadCounter = 0;
	}
	
	chatBt_notReadCounter += count;
	
	if(chatBt_notReadCounter == 0) {
		parent.$('.chatBt_notReadCounter').remove();
		return false;
	}
	
	parent.$('.chatBt_notReadCounter').html(chatBt_notReadCounter);
}

function changeChatsReadCounter(){
	var Bottom_notReadCounter = $('.Bottom_notReadCounter').html() *1;
	
	if(Bottom_notReadCounter == null || Bottom_notReadCounter == "" || Bottom_notReadCounter == 0 || isNaN(Bottom_notReadCounter)) {
		$('.tab-bar a .fa-comment').after('<span class="Bottom_notReadCounter"></span>');
		Bottom_notReadCounter = 0;
	}
	Bottom_notReadCounter += 1;
	
	$('.Bottom_notReadCounter').html(Bottom_notReadCounter);
}

function changeReservationReadCounter(count){
	var Bottom_reservationNotReadCount = $('.Bottom_reservationNotReadCount').html() *1;
	
	if(Bottom_reservationNotReadCount == null || Bottom_reservationNotReadCount == "" || Bottom_reservationNotReadCount == 0 || isNaN(Bottom_reservationNotReadCount)) {
		$('.tab-bar a .fa-search').after('<span class="Bottom_reservationNotReadCount"></span>');
		Bottom_reservationNotReadCount = 0;
	}
	Bottom_reservationNotReadCount += count;
	
	if(Bottom_reservationNotReadCount == 0) {
		$('.Bottom_reservationNotReadCount').remove();
		return false;
	}
	
	$('.Bottom_reservationNotReadCount').html(Bottom_reservationNotReadCount);
}

function initNotReadCount(notReadCount, reservationNotReadCount) {
	var total = reservationNotReadCount + notReadCount;
	if(total == 0) {
		if(parent.$('body').find('.chatBt_notReadCounter').length == 1) {
			parent.$('.chatBt_notReadCounter').remove();
		}
	} else {
		if(parent.$('body').find('.chatBt_notReadCounter').length == 0) {
			parent.$('button.chatBt').after('<span class="chatBt_notReadCounter">' + total + '</span>');
		} else {
			parent.$('.chatBt_notReadCounter').html(total);
		}
		
		if(notReadCount != "0" && notReadCount != null && notReadCount != "" && notReadCount != 0)	{
			$('.fa-comment').after('<span class="Bottom_notReadCounter">' + notReadCount + '</span>');
		}
	
		if(reservationNotReadCount != "0" && reservationNotReadCount != null && reservationNotReadCount != "" && reservationNotReadCount != 0)	{
			$('.tab-bar a .fa-search').after('<span class="Bottom_reservationNotReadCount">' + reservationNotReadCount + '</span>');
		}
	
	}
}