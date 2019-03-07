var idCheck = false;
var nicknameCheck = false;
$(function(){
	
    //모달을 전역변수로 선언
    var modalContents = $(".modal-contents");
    var modal = $("#defaultModal");
     
    $('.onlyAlphabetAndNumber').keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val($(this).val().replace(/[^_a-z0-9]/gi,'')); //_(underscore), 영어, 숫자만 가능
        }
    });
     
    $(".onlyHangul").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[a-z0-9]/gi,''));
        }
    });
 
    $(".onlyNumber").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
    });
     
    //------- 검사하여 상태를 class에 적용    
    $('.provisionYn').click(function() {
    	var provision = $('#provisionOuter');
		if($('.provisionYn:checked').val() == 'Y') {
			provision.removeClass("has-error");
            provision.addClass("has-success");
		} else {
			provision.removeClass("has-success");
            provision.addClass("has-error");
		}
	})
	
	$('.memberInfoYn').click(function() {
		var memberInfo = $('#memberInfoOuter');
		if($('.memberInfoYn:checked').val() == 'Y') {
			memberInfo.removeClass("has-error");
			memberInfo.addClass("has-success");
		} else {
			memberInfo.removeClass("has-success");
			memberInfo.addClass("has-error");
		}
	})
    
    /*$('#id').keyup(function(event){
         
        var divId = $('#divId');
         
        if($('#id').val()==""){
            divId.removeClass("has-success");
            divId.addClass("has-error");
        }else{
            divId.removeClass("has-error");
            divId.addClass("has-success");
        }
    });*/
	
	$('#id').keyup(function() {
		var divId = $('#divId');
		divId.removeClass("has-success");
	    divId.addClass("has-error");
	    idCheck = false;
	    $('.idCheck').html("");
		$('.idCheck').html("<font color='red'>중복체크를 해주세요.</font>");
	});
     
    $('#password').keyup(function(event){
         
        var divPassword = $('#divPassword');
         
        if($('#password').val()==""){
            divPassword.removeClass("has-success");
            divPassword.addClass("has-error");
        }else{
            divPassword.removeClass("has-error");
            divPassword.addClass("has-success");
        }
    });
     
    $('#passwordCheck').keyup(function(event){
         
        var passwordCheck = $('#passwordCheck').val();
        var password = $('#password').val();
        var divPasswordCheck = $('#divPasswordCheck');
         
        if((passwordCheck=="") || (password!=passwordCheck)){
            divPasswordCheck.removeClass("has-success");
            divPasswordCheck.addClass("has-error");
        }else{
            divPasswordCheck.removeClass("has-error");
            divPasswordCheck.addClass("has-success");
        }
    });
     
    $('#name').keyup(function(event){
         
        var divName = $('#divName');
         
        if($.trim($('#name').val())==""){
            divName.removeClass("has-success");
            divName.addClass("has-error");
        }else{
            divName.removeClass("has-error");
            divName.addClass("has-success");
        }
    });
     
   /* $('#nickname').keyup(function(event){
         
        var divNickname = $('#divNickname');
         
        if($.trim($('#nickname').val())==""){
            divNickname.removeClass("has-success");
            divNickname.addClass("has-error");
        }else{
            divNickname.removeClass("has-error");
            divNickname.addClass("has-success");
        }
    });*/
    
    $('#nickname').keyup(function() {
		var divNickname = $('#divNickname');
		divNickname.removeClass("has-success");
		divNickname.addClass("has-error");
	    nicknameCheck = false;
	    $('.nicknameCheck').html("");
		$('.nicknameCheck').html("<font color='red'>중복체크를 해주세요.</font>");
	});
     
     
    $('#phoneNumber').blur(function(event){
         
        var divPhoneNumber = $('#divPhoneNumber');
         
        if($.trim($('#phoneNumber').val())==""){
            divPhoneNumber.removeClass("has-success");
            divPhoneNumber.addClass("has-error");
        }else{
        	var phoneNumber = $('#phoneNumber').val();
        	if(phoneNumber.length == 11 || phoneNumber.length == 10) {
        		var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
        		if(regExp_ctn.test(phoneNumber)) {
        			phoneNumber = phoneNumber.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");
        			$('#phoneNumber').val(phoneNumber);
        			divPhoneNumber.removeClass("has-error");
        			divPhoneNumber.addClass("has-success");
        		}
        	}
        }
    });
    
    $('#addr2').keyup(function(event){
        
        var divAddress = $('#divAddress');
         
        if($.trim($('#code').val())=="" || $.trim($('#addr1').val())=="" || $.trim($('#addr2').val())==""){
        	divAddress.removeClass("has-success");
        	divAddress.addClass("has-error");
        }else{
        	divAddress.removeClass("has-error");
        	divAddress.addClass("has-success");
        }
    });
     
     
    //------- validation 검사
    $( ".joinBt" ).click(function( event ) {
         
        var provision = $('#provision');
        var memberInfo = $('#memberInfo');
        var divId = $('#divId');
        var divPassword = $('#divPassword');
        var divPasswordCheck = $('#divPasswordCheck');
        var divName = $('#divName');
        var divNickname = $('#divNickname');
        var divEmail = $('#divEmail');
        var divPhoneNumber = $('#divPhoneNumber');
         
        //회원가입약관
        if($('.provisionYn:checked').val()=="N"){
            modalContents.text("회원가입약관에 동의하여 주시기 바랍니다."); //모달 메시지 입력
            modal.modal('show'); //모달 띄우기
             
            provision.removeClass("has-success");
            provision.addClass("has-error");
            $('.provisionYn').focus();
            return false;
        }else{
            provision.removeClass("has-error");
            provision.addClass("has-success");
        }
         
        //개인정보취급방침
        if($('.memberInfoYn:checked').val()=="N"){
            modalContents.text("개인정보취급방침에 동의하여 주시기 바랍니다.");
            modal.modal('show');
             
            memberInfo.removeClass("has-success");
            memberInfo.addClass("has-error");
            $('.memberInfoYn').focus();
            return false;
        }else{
            memberInfo.removeClass("has-error");
            memberInfo.addClass("has-success");
        }
         
        //아이디 검사
        if(idCheck == false){
            modalContents.text("아이디 중복체크를 해주세요.");
            modal.modal('show');
             
            divId.removeClass("has-success");
            divId.addClass("has-error");
            $('#id').focus();
            return false;
        }
         
        //패스워드 검사
        if($('#password').val()==""){
            modalContents.text("패스워드를 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divPassword.removeClass("has-success");
            divPassword.addClass("has-error");
            $('#password').focus();
            return false;
        }else{
            divPassword.removeClass("has-error");
            divPassword.addClass("has-success");
        }
         
        //패스워드 확인
        if($('#passwordCheck').val()==""){
            modalContents.text("패스워드 확인을 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divPasswordCheck.removeClass("has-success");
            divPasswordCheck.addClass("has-error");
            $('#passwordCheck').focus();
            return false;
        }else{
            divPasswordCheck.removeClass("has-error");
            divPasswordCheck.addClass("has-success");
        }
         
        //패스워드 비교
        if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
            modalContents.text("패스워드가 일치하지 않습니다.");
            modal.modal('show');
             
            divPasswordCheck.removeClass("has-success");
            divPasswordCheck.addClass("has-error");
            $('#passwordCheck').focus();
            return false;
        }else{
            divPasswordCheck.removeClass("has-error");
            divPasswordCheck.addClass("has-success");
        }
         
        //이름
        if($('#name').val()==""){
            modalContents.text("이름을 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divName.removeClass("has-success");
            divName.addClass("has-error");
            $('#name').focus();
            return false;
        }else{
            divName.removeClass("has-error");
            divName.addClass("has-success");
        }
         
        //별명
        if(nicknameCheck == false){
            modalContents.text("닉네임 중복체크를 해주시기 바랍니다.");
            modal.modal('show');
             
            divNickname.removeClass("has-success");
            divNickname.addClass("has-error");
            $('#nickname').focus();
            return false;
        }
         
        //휴대폰 번호
        var phoneNumber = $('#phoneNumber').val().replace(/-/gi,'');
        if(phoneNumber==""){
            modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            divPhoneNumber.removeClass("has-success");
            divPhoneNumber.addClass("has-error");
            $('#phoneNumber').focus();
            return false;
        }else if(phoneNumber != null && phoneNumber != '') {
        	if(phoneNumber.length == 11 || phoneNumber.length == 10) {
        		var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
        		if(regExp_ctn.test(phoneNumber)) {
        			phoneNumber = phoneNumber.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");
        			$('#phoneNumber').val(phoneNumber);
        		} else {
        			modalContents.text("유효한 핸드폰 번호를 입력하세요.");
                    modal.modal('show');
                     
                    divPhoneNumber.removeClass("has-success");
                    divPhoneNumber.addClass("has-error");
                    $('#phoneNumber').focus();
                    return false;
        		}
        	} else {
        		modalContents.text("유효한 핸드폰 번호를 입력하세요.");
                modal.modal('show');
                 
                divPhoneNumber.removeClass("has-success");
                divPhoneNumber.addClass("has-error");
                $('#phoneNumber').focus();
                return false;
        	}
        }else {
            divPhoneNumber.removeClass("has-error");
            divPhoneNumber.addClass("has-success");
        }
        
        //주소
        if($('#code').val()=="" || $('#addr1').val()=="" || $('#addr2').val()==""){
            modalContents.text("주소를 입력하여 주시기 바랍니다.");
            modal.modal('show');
             
            $('#divAddress').removeClass("has-success");
            $('#divAddress').addClass("has-error");
            $('#divAddress').focus();
            return false;
        }else{
        	$('#divAddress').removeClass("has-error");
        	$('#divAddress').addClass("has-success");
        }
        
        $('form').submit();
        
    });
    
    $('.selectImg').click(function(event) {
		var name = $(this).attr('src').split('/');
		name = name[name.length-1];
		$('#profile_image').val(name);
		$('.profile_selected').removeClass('profile_selected');
		$(this).addClass('profile_selected');
	});
	
	$('.file_input_hidden').on("change",function(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if(!f.type.match("image.*")) {
				alert("이미지 확장자만 가능합니다.");
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$(".file_input_img_btn").attr("src", e.target.result)
			}
			reader.readAsDataURL(f);
		});
		var name = $(this).val().split('\\');
		name = name[name.length-1];
		$('#profile_image').val(name);
		$('.profile_selected').removeClass('profile_selected');
		$('.file_input_img_btn').addClass('profile_selected');
	});
	
	
	// 회원가입 유효성체크 후 회원가입 요청
	$('form').on('submit',function(event) {
		event.preventDefault();
		
		var formData = new FormData();
		var json = $('form').serializeObject();
		var file = $('#multipartFile').val();
		formData.append("serialData",new Blob([JSON.stringify(json)], {
		    type: "application/json"
		})); 
		
		formData.append("file",$("#multipartFile")[0].files[0]);
        
		$.ajax({
			type:"POST",
			url:"../join/join.do",
			processData: false,
            contentType: false,
			data: formData,
			success: function() {
				swal({
					title:"회원가입",
					text : "로그인 페이지로 이동합니다.",
					icon : "success"
				}).then((willDelete) => {
					if(willDelete) {
						location.href="../login/login.do";
					}
				})
			},
			error: function(request) {
				swal('회원가입 오류', request.responseText + '\n관리자에게 문의하세요.','error');
			}
		});
	});
});

function DaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullAddr = ''; // 최종 주소 변수
			var extraAddr = ''; // 조합형 주소 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				fullAddr = data.roadAddress;

			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				fullAddr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
			if(data.userSelectedType === 'R'){
				//법정동명이 있을 경우 추가한다.
				if(data.bname !== ''){
					extraAddr += data.bname;
				}
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName !== ''){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('code').value = data.zonecode; //5자리 새우편번호 사용
			document.getElementById('addr1').value = fullAddr;

			// 커서를 상세주소 필드로 이동한다.
			document.getElementById('addr2').focus();
		}
	}).open();
}//end

function idcheck(){
	
	if($('#id').val()==""){
        modalContents.text("아이디를 입력하여 주시기 바랍니다.");
        modal.modal('show');
         
        divId.removeClass("has-success");
        divId.addClass("has-error");
        $('#id').focus();
        return false;
    }
	
	var id = $('#id').val();
	
	$.ajax({
		url:"../join/checkId.do",
		data: {"id":id},
		type:"post",
		success: function(data) {
			var divId = $('#divId');
			if(data != 0) {
				$('.idCheck').html("");
				$('.idCheck').html("<font color='red'>이미 존재하는 아이디입니다.</font>");
		        divId.removeClass("has-success");
		        divId.addClass("has-error");
		        idCheck = false;
			} else {
				$('.idCheck').html("");
				$('.idCheck').html("<font color='green'>사용가능한 아이디입니다.</font>");
				divId.removeClass("has-error");
	            divId.addClass("has-success");
	            idCheck = true;
			}
		}
		
	})
}

function nicknamecheck() {
	
	if($('#nickname').val()==""){
        modalContents.text("닉네임을 입력하여 주시기 바랍니다.");
        modal.modal('show');
         
        divId.removeClass("has-success");
        divId.addClass("has-error");
        $('#nickname').focus();
        return false;
    }
	
	var nickname = $('#nickname').val();
	
	$.ajax({
		url:"../join/checkNick.do",
		data: {"nickname":nickname},
		type:"post",
		success: function(data) {
			var divNickname = $('#divNickname');
			if(data != 0) {
				$('.nicknameCheck').html("");
				$('.nicknameCheck').html("<font color='red'>이미 존재하는 닉네임입니다.</font>");
				divNickname.removeClass("has-success");
		        divNickname.addClass("has-error");
		        nicknameCheck = false;
			} else {
				$('.nicknameCheck').html("");
				$('.nicknameCheck').html("<font color='green'>사용가능한 닉네임입니다.</font>");
				divNickname.removeClass("has-error");
				divNickname.addClass("has-success");
				nicknameCheck = true;
			}
		}
		
	})
}











