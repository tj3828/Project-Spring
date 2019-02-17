<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원가입</title>
	<!-- JQuery -->
    <script src="../resources/js/jquery-3.3.1.min.js"></script>
    <!-- Bootstrap -->
	<!-- font -->
	<link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
    <!-- css -->
    <link rel="stylesheet" href="../resources/css/join.css">
    <!-- js -->
    <script src="../resources/js/join.js"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
			        <font color="red">* 약관을 읽고 동의하고, 모든 내용을 입력해주세요.</font>
		        </div>
	        </div>
        	<hr/>
            <div class="form-group has-error" id="provisionOuter">
                <label for="provision" class="col-lg-2 control-label">회원가입약관</label>
                <div class="col-lg-10" id="provision">
                    <textarea class="form-control" rows="8" style="resize:none" readonly="readonly">
						약관동의
                    </textarea>
                    <div class="radio">
                        <input type="radio" id="provisionYn" class="provisionYn" name="provisionYn" value="Y">
                       	<label for="provisionYn"></label>
                       		 동의합니다.
                    </div>
                    <div class="radio">
                        <input type="radio" id="provisionYn1" class="provisionYn" name="provisionYn" value="N" checked>
                       	<label for="provisionYn1"></label>
                          	동의하지 않습니다.
                    </div>
                </div>
            </div>
            <div class="form-group has-error" id ="memberInfoOuter">
                <label for="memberInfo" class="col-lg-2 control-label">개인정보취급방침</label>
                <div class="col-lg-10" id="memberInfo">
                    <textarea class="form-control" rows="8" style="resize:none" readonly="readonly">
						개인정보의 항목 및 수집방법
                    </textarea>
                    <div class="radio">
                        <input type="radio" id="memberInfoYn" class="memberInfoYn" name="memberInfoYn" value="Y" >
                        <label for="memberInfoYn"></label>
                             	동의합니다.
                    </div>
                    <div class="radio">
                        <input type="radio" id="memberInfoYn1" class="memberInfoYn" name="memberInfoYn" value="N" checked>
                        <label for="memberInfoYn1"></label>
                            	동의하지 않습니다.
                    </div>
                </div>
            </div>
            <div class="form-group has-error" id="divId">
                <label for="inputId" class="col-lg-2 control-label">아이디</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyAlphabetAndNumber" id="id" name="id" style="width: 50%; !important; display:inline; " data-rule-required="true" placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="30">
                    <input type="button" style="width: auto !important; display:inline; " class="form-control btn btn-warning" onclick="idcheck();" value="중복 확인">
                	<span class="idCheck" ><font color='red'>중복체크를 해주세요.</font></span>
                </div>
            </div>
            <div class="form-group has-error" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="password" name="excludeHangul" data-rule-required="true" placeholder="패스워드" maxlength="30">
                </div>
            </div>
            <div class="form-group has-error" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="passwordCheck" name="pw" data-rule-required="true" placeholder="패스워드 확인" maxlength="30">
                </div>
            </div>
            <div class="form-group has-error" id="divName">
                <label for="inputName" class="col-lg-2 control-label">이름</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyHangul" id="name" name="name" data-rule-required="true" placeholder="한글만 입력 가능합니다." maxlength="15">
                </div>
            </div>
             
            <div class="form-group has-error" id="divNickname">
                <label for="inputNickname" class="col-lg-2 control-label">별명</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control" id="nickname" name="nickname" style="width: 50%; !important; display:inline; " data-rule-required="true" placeholder="별명" maxlength="15">
                    <input type="button" style="width: auto !important; display:inline; " class="form-control btn btn-warning" onclick="nicknamecheck();" value="중복 확인">
                	<span class="nicknameCheck" ><font color='red'>중복체크를 해주세요.</font></span>
                </div>
            </div>
             
            <div class="form-group has-error" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
                <div class="col-lg-10">
                    <input type="email" class="form-control" id="email" name="email" data-rule-required="true" placeholder="이메일" maxlength="40">
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
                <label for="gender" class="col-lg-2 control-label">성별</label>
                <div class="col-lg-10">
                    <select class="form-control" id="gender" name="gender">
                        <option value="M">남</option>
                        <option value="F">여</option>
                    </select>
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
</html>