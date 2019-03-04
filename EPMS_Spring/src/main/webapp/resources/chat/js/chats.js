//사용자 초대하기 버튼
$('.chat-btn').click(function() {
	var opponentNick;
	Swal.fire({
	  title: '초대할 사용자의 닉네임을 입력하세요.',
	  input: 'text',
	  inputAttributes: {
		placeholder: "정확히 입력하세요.",
	    autocapitalize: 'off'
	  },
	  showCancelButton: true,
	  confirmButtonText: '초대하기',
	  showLoaderOnConfirm: true,
	  preConfirm: (searchNick) => {
	    return fetch('../chatting/chatUserSearch.do?nickname='+searchNick)
	      .then(response => {
	        if (!response.ok) {
	          throw new Error(response.statusText)
	        }
	      	return response.json();
	      })
	      .then(data => {
	    	  if(data==0) {
	    		Swal.showValidationMessage(
	      		    '해당 사용자를 찾을 수 없습니다.'
	      		);
	    	  }
	    	  opponentNick = searchNick;
	    	  return data;
	      })
	  },
	  allowOutsideClick: () => !Swal.isLoading()
	})
	.then((result) => {
	  if(result.value > 0) {
		  location.replace('../chat/chat.do?opponent=' + opponentNick);
	  }
	}); 
});

function prependList(fromNick, fromNick_profileImg, content, writeDate, notReadCount, path ) {
		$('.chats__list').prepend('<li class="chats__chat">' +
		  	'<a href="javascript:location.replace(\'../chat/chat.do?opponent=' + fromNick + '\');">' +
		          '<div class="chat__content">' + 
		          '<img src="' + path + '/resources/upload/' + fromNick_profileImg + '">' + 
	            		'<div class="chat__preview">' +
	                		'<h3 class="chat__user">' +
	            				fromNick	+
	            			'</h3>' +
	                		'<span class="chat__last-message">' + 
	                			content + 
	                		'</span>' +
	                	'</div>' +
		          '</div>' +
		          '<span class="chat__date-time">' +
		          	(notReadCount != 0 ? '<span class="notReadCounter" style="position: inherit; left:0px;">' + notReadCount + '</span>&nbsp;&nbsp;' : "") +
		          		writeDate +
		          '</span>' +
		     '</a>' +
		   '</li>');
}
	
function removeChatsList(find){
	var notReadCount = 1;
	$('.chat__user').each(function() {
		// 헤당 방을 찾아서
		if($(this).text() == find) {
			// 방의 정보를 기억한 후 제거
			var exist = $(this).closest("li").find('.notReadCounter').html() * 1;
			if(exist == null || exist == "" || exist == 0 || isNaN(exist)) {
				exist = 0;
			}
			notReadCount = exist + 1;
			$(this).closest("li").remove();
		}
	});
	return notReadCount;
}