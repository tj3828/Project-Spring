<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>SNS 회원가입</title>
	<!-- JQuery -->
    <script src="../resources/js/jquery-3.3.1.min.js"></script>
    <!-- Bootstrap -->
	<!-- font -->
	<link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
    <!-- css -->
    <link rel="stylesheet" href="../resources/css/join.css">
    <!-- js -->
    <script src="../resources/js/joinSNS.js"></script>
    <script src="https://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>	
<body>
	<div class="container">
    	<!-- header -->
             
      	<div class="row">
			<div class="header">
               <a class="top-header" >Navbar</a>
           	</div>
        </div>
           
        <!-- modal -->
        <div class="modal fade" id="defaultModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">알림</h4>
                    </div>
                    <div class="modal-body">
                        <p class="modal-contents"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
	        
        
        <!-- join form -->
        <form class="form-horizontal" role="form" enctype="multipart/form-data" method="post" action=" ">
        	<div class="form-group">
	        	<h1 class="col-lg-2 labelconfig">
			        <span class="label label-danger fontset">회원가입</span>
			    </h1>
			    <div class="col-lg-10" style="margin-top:30px;" >
			        <font color="red">* 모든 내용을 입력해주세요.</font>
		        </div>
	        </div>
        	<hr/>
        	<input type="hidden" class="form-control onlyAlphabetAndNumber" id="id" name="id">
           	<input type="hidden" class="form-control onlyHangul" id="name" name="name">
           	<input type="hidden" class="form-control onlyHangul" id="pw" name="pw" value="1">
           	<input type="hidden" class="form-control onlyHangul" id="password" name="password" value="1">
           	<input type="hidden" class="form-control onlyHangul" id="passwordCheck" name="passwordCheck" value="1">
            <input type="hidden" class="form-control" id="email" name="email">
            <input type="hidden" id="gender" name="gender">
            <div class="form-group has-error" id="divNickname">
                <label for="inputNickname" class="col-lg-2 control-label">별명</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control" id="nickname" name="nickname" style="width: 50%; !important; display:inline; " data-rule-required="true" placeholder="별명" maxlength="15">
                    <input type="button" style="width: auto !important; display:inline; " class="form-control btn btn-warning" onclick="nicknamecheck();" value="중복 확인">
                	<span class="nicknameCheck" ><font color='red'>중복체크를 해주세요.</font></span>
                </div>
            </div>
            <div class="form-group has-error" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰 번호</label>
                <div class="col-lg-10">
                    <input type="tel" class="form-control onlyNumber" id="phoneNumber" name="phone" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="13">
                </div>
            </div>
            <div class="form-group has-error" id="divAddress">
                <label for="inputAddress" class="col-lg-2 control-label">주소</label>
                <div class="col-lg-10">
                	<input type="text" style="width: auto !important; display:inline; " class="form-control" id="code" name="code" readonly="readonly">
					<input type="button" style="width: auto !important; display:inline; " class="form-control" onclick="DaumPostcode()" value="우편번호 찾기"><br><br>
					<input type="text" class="form-control" id="addr1" name="addr1" readonly="readonly" ><br>
					<input type="text" placeholder="상세주소를 입력하세요." class="form-control" id="addr2" name="addr2">
				</div>
            </div>
            <div class="form-group">
                <label for="profile_image" class="col-lg-2 control-label">프로필 이미지 선택</label>
                <div class="col-lg-10">
                	<input type="hidden" value="dog1.png" id="profile_image" name="profile_img">
                    <img src="../resources/images/icon/dog1.png" class="profile_image selectImg profile_selected" alt="choice1">
                    <img src="../resources/images/icon/dog2.png" class="profile_image selectImg"  alt="choice2">
                    <img src="../resources/images/icon/dog3.png" class="profile_image selectImg" alt="choice3">
                    <img src="../resources/images/icon/peach1.png" class="profile_image selectImg" alt="choice4">
                    <img src="../resources/images/icon/peach2.png" class="profile_image selectImg" alt="choice5">
                    <img src="../resources/images/icon/peach3.png" class="profile_image selectImg" alt="choice6">
                    <img src="../resources/images/icon/duck1.png" class="profile_image selectImg" alt="choice7">
                    <img src="../resources/images/icon/duck2.png" class="profile_image selectImg" alt="choice8">
                    <img src="../resources/images/icon/duck3.png" class="profile_image selectImg" alt="choice9">
					<div class="file_input_div">
					    <img src="../resources/images/setProfileImg.png" class="file_input_img_btn profile_image" alt="open" />
					    <input type="file" class="file_input_hidden" name="multipartFile" id="multipartFile" accept="image/*"/>
					</div>
                </div>
            </div>
            
            <div class="form-group" align="center" style="margin-top:5%;">
                <div>
                    <button type="button" class="btn btn btn-primary btn-lg fontset joinBt">회원가입</button>&nbsp;&nbsp;
                    <button type="reset" class="btn btn btn-danger btn-lg fontset" onclick="window.location.reload();">다시작성</button>&nbsp;&nbsp;
                    <button type="button" class="btn btn btn-secondary btn-lg fontset" onclick="history.back();">뒤로가기</button>
                </div>
            </div>
        </form>
        </div>
    </body>
    
<script type="text/javascript">
	idCheck =true;
	var id = ${result}.response.id;
	var name = ${result}.response.name;
	var email = ${result}.response.email;
	var gender = ${result}.response.gender =='M'? '남':'여';
	$('#id').val(id);
	$('#name').val(name);
	$('#email').val(email);
	$('#gender').val(gender);
</script>
</html>
