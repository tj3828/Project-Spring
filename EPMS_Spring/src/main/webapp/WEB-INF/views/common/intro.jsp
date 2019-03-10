<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차인서울 - 소개</title>
</head>
<link rel="stylesheet" href="../resources/css/freeboard.css">
<body>
<div class="wrap">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="container">
		<div class="title_label_div">
			<font class="title_label" >① 주차인서울 : What? </font>
		</div>
		<div style="background: white; border-radius: 10px; padding:20px; font-size:1.2rem; text-align: center;">
			<div style="font-size:2rem;">
				"Don't burrow, Do borrow!"
			</div>
			<br>
			<div style="font-family: sangsangBody; text-align: none;">
				주차인서울은 불법주차와 같은 사회적 문제를 해결하기 위해 거주자주차지역이나 개인의 소유로 존재하는 주차공간을 보다 효율적으로 사용하기 위한 프로젝트입니다. 더 많은 사람들이 쉽게 접근하고 거부감없이 이용할 수 있도록 무료로 이용할 수 있습니다. 
			</div>
		</div>
		<br><br>
		<div class="title_label_div">
			<font class="title_label" >② 주차인서울 : How? </font>
		</div>
		<div style="background: white; border-radius: 10px; padding:20px; font-size:1.2rem; text-align: center;">
			<div style="font-size:2rem;">
				<img src="../resources/images/epms_intro.png" style="width:50%; height: auto;">
			</div>
			<br>
			<div style="font-family: sangsangBody; text-align: left;">
				 현재 존재하는 거주자주차지역이나 개인의 소유로 존재하는 주차공간을 보다 실시간으로 활용하기 위해 어플리케이션을 통해 실시간으로 주차권한을 양도하고 또한 동시에 주차지역을 소유한 사용자의 사회적 문제인 불법주차를 해결하기 위해 지정된 차량만 인식하여 개폐하는 주차금지봉을 설치합니다. 이 주차금지봉은 자동차뿐만 아니라 권한을 가진 특정 어플리케이션 사용자와 연결되기 때문에 실시간으로 주차권한을 양도합니다.
				 <br><br> 현재는 웹 상으로 주차지역을 예약하고 양도할 수 있고, 모바일 앱과는 연동되지 않았습니다.
				
			</div>
		</div>
		
	</div>
</div>
<jsp:include page="../common/chatBt.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>