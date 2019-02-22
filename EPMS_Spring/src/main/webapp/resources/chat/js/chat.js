// 사용자 초대하기 버튼
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