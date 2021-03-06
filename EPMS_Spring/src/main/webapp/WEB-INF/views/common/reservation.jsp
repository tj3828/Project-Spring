<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="height: 100%; padding: 0; margin: 0;">
<head>
<meta charset="UTF-8">
<title>주차공간- EPMS</title>
</head>
<link rel="stylesheet" href="../resources/css/reservation.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<jsp:include page="../common/top.jsp"></jsp:include>
<style>/
	/* #pano{
		width:100% !important;
		height: 100% !important;
	} */
</style>
<body style="height: inherit; padding: 0; margin: 0; position: relative;">
	<div class="main-body">
		<!-- ModalSearchRequest -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" style="left:50%; top:50%; transform:translate(-50%,-50%); margin: 0; max-width: 80%;" role="document"> 
		    <div class="modal-content"> 
		      <div class="modal-header">
		        <h3 class="modal-title" style="font-family: sangsangBody;" id="exampleModalLabel1">지역 검색</h3>
		       	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body" style="text-align: left; font-family: sangsangBody; font-size: 1rem;">
		      	<h1 style="text-align: center"><span class="badge badge-danger searchModalTitle" ></span></h1>
				<table style="width:100%; height:40%;" >
					<tr style="border-top: 1px solid #444444;">
						<td style="width:50%; height:20%; vertical-align: top; padding:10px; text-align:left;">
							<h2 style="display:inline-block;"><span class="badge badge-danger" >기간 선택</span></h2>
							<font style="font-size: 1.5rem; font-weight:bold;">&nbsp;&nbsp;① 원하는 날짜와 시간을 선택한 후 검색을 누르세요.</font> <br>
							<input type="text" style="width:70%;  display: inline-block;" class="datetimes form-control" name="datetimes" onchange="resetSearchList();" />&nbsp;&nbsp;
							<input type="button" class="btn btn-outline-primary" style=" display: inline-block;"value="검색" onclick="searchList();">
						</td>
						<td class="panotd" style="border-left: 1px solid #444444; width:50%; height:500px; vertical-align: top; padding-top: 10px; padding-left:10px;padding-right:10px;" rowspan="2">
							<div id="pano" style="width:100% !important;height:100% !important;"></div>
						</td>
					</tr>
	    			<tr>
		    			<td style="border-top: 1px solid #444444; vertical-align: top; padding: 10px;  text-align:left;" align="top" >
		    				<h2 style="display:inline-block;"><span class="badge badge-danger" >자리 선택</span></h2>
		    				<font style="font-size: 1.5rem; font-weight:bold;">&nbsp;&nbsp;② 희망 자리를 우측 로드뷰에서 확인 후 선택하세요.</font><br>
		    				<div style="overflow-y:scroll; margin:10px; margin-top:15px; padding:10px; border: 1px solid gray; display:inline-block;" class="reservationList"></div>
		    			</td>
	    			</tr>
	   			</table>
		      </div>
		    </div>
		  </div>
		</div>
	
		<!-- ModalRequest -->
		<div class="modal fade" id="exampleModal1" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel1" aria-hidden="true">
		  <div class="modal-dialog modal-sm" style="left:50%; top:50%; transform:translate(-50%,-50%); margin: 0; max-width: 50%;" role="document"> 
		    <div class="modal-content"> 
		      <div class="modal-header">
		        <h3 class="modal-title" style="font-family: sangsangBody;" id="exampleModalLabel1">예약 요청</h3>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body" style="text-align: left; font-family: sangsangBody; font-size: 1rem;">
		      		<input type="hidden" class="hostName" value="">
			      	<strong style="font-family: sangsangBody;">요청 시간 : </strong><span class="requestTime" style="font-family: sangsangBody;"></span><br><br>
			      	<strong style="font-family: sangsangBody;">요청 지역 : </strong><span class="requestAddress" style="font-family: sangsangBody;"></span><br><br>
			      	<strong style="font-family: sangsangBody;">주차 구역 : </strong><span class="requestArea" style="font-family: sangsangBody;"></span><br> <br>
			      	<strong style="font-family: sangsangBody;">메시지 : </strong> &nbsp;<textarea class="requestMessage" style="font-family: sangsangBody; width: 100%; resize: none; border: 1px solid;" rows="3" placeholder="전송하고자하는 메시지를 입력하세요."></textarea><br><br>
			      	<input type="button" class="btn btn-primary" value="예약 요청하기" style="font-family: sangsangBody; float:right;" onclick="requestReservation();">
		      </div>
		    </div>
		  </div>
		</div>
		<div class="container main-container">
			<div class="main-logo">
				<div class="main-logo-img">
					<div class="logo_left"></div>
					<img class="img-fluid" src="../resources/images/mainIcon/mainlogo_ch.png" width="15%" height="auto"> 
					<div class="logo_right"></div>
				</div>
			</div>
			<div class="box">
				<div class="content reservation_first" style="display: flex;">
					<div class="main_left" style="width: 50%; ">
						<h1 style="color: #F3C209; font-size: 5vmin; margin-bottom: 2rem; font-family: sangsangTitle;">예약 서비스</h1>
						<div class="mapSelect kr_Seoul" >
							<ul> 
								<li class="map1" style="display: none; "><img src="../resources/images/map2/img_map_01.png" alt="서울특별시 노원구"></li>
								<li class="map2" style="display: none;"><img src="../resources/images/map2/img_map_02.png" alt="서울특별시 도봉구"></li>
								<li class="map3" style="display: none;"><img src="../resources/images/map2/img_map_03.png" alt="서울특별시 강북구"></li>
								<li class="map4" style="display: none;"><img src="../resources/images/map2/img_map_04.png" alt="서울특별시 중랑구"></li>
								<li class="map5" style="display: none;"><img src="../resources/images/map2/img_map_05.png" alt="서울특별시 동대문구"></li>
								<li class="map6" style="display: none;"><img src="../resources/images/map2/img_map_06.png" alt="서울특별시 성북구"></li>
								<li class="map7" style="display: none;"><img src="../resources/images/map2/img_map_07.png" alt="서울특별시 종로구"></li>
								<li class="map8" style="display: none;"><img src="../resources/images/map2/img_map_08.png" alt="서울특별시 서대문구"></li>
								<li class="map9" style="display: none;"><img src="../resources/images/map2/img_map_09.png" alt="서울특별시 은평구"></li>
								<li class="map10" style="display: none;"><img src="../resources/images/map2/img_map_10.png" alt="서울특별시 광진구"></li>
								<li class="map11" style="display: none;"><img src="../resources/images/map2/img_map_11.png" alt="서울특별시 성동구"></li>
								<li class="map12" style="display: none;"><img src="../resources/images/map2/img_map_12.png" alt="서울특별시 중구"></li>
								<li class="map13" style="display: none;"><img src="../resources/images/map2/img_map_13.png" alt="서울특별시 용산구"></li>
								<li class="map14" style="display: none;"><img src="../resources/images/map2/img_map_14.png" alt="서울특별시 마포구"></li>
								<li class="map15" style="display: none;"><img src="../resources/images/map2/img_map_15.png" alt="서울특별시 강동구"></li>
								<li class="map16" style="display: none;"><img src="../resources/images/map2/img_map_16.png" alt="서울특별시 송파구"></li>
								<li class="map17" style="display: none;"><img src="../resources/images/map2/img_map_17.png" alt="서울특별시 강남구"></li>
								<li class="map18" style="display: none;"><img src="../resources/images/map2/img_map_18.png" alt="서울특별시 서초구"></li>
								<li class="map19" style="display: none;"><img src="../resources/images/map2/img_map_19.png" alt="서울특별시 동작구"></li>
								<li class="map20" style="display: none;"><img src="../resources/images/map2/img_map_20.png" alt="서울특별시 관악구"></li>
								<li class="map21" style="display: none;"><img src="../resources/images/map2/img_map_21.png" alt="서울특별시 금천구"></li>
								<li class="map22" style="display: none;"><img src="../resources/images/map2/img_map_22.png" alt="서울특별시 영등포구"></li>
								<li class="map23" style="display: none;"><img src="../resources/images/map2/img_map_23.png" alt="서울특별시 구로구"></li>
								<li class="map24" style="display: none;"><img src="../resources/images/map2/img_map_24.png" alt="서울특별시 양천구"></li>
								<li class="map25" style="display: none;"><img src="../resources/images/map2/img_map_25.png" alt="서울특별시 강서구"></li>
							</ul>
							<img src="../resources/images/map2/img_map_area.png" alt="" usemap="#Map2" class="imgMap" border="0" width="220" height="169">
							<map name="Map2" id="Map2">
								<area shape="poly" coords="152,4,146,6,146,7,146,9,146,10,146,11,146,12,146,14,146,14,146,15,145,16,144,17,144,19,144,21,144,22,145,24,145,26,146,27,146,28,147,29,147,30,148,32,148,34,149,35,149,37,148,38,147,39,146,39,144,38,144,38,144,38,142,40,142,41,142,42,143,43,143,44,143,45,143,46,143,47,145,50,148,51,148,51,150,51,153,52,153,52,156,52,158,51,161,50,163,49,165,49,168,50,168,50,170,49,172,49,172,48,173,45,175,45,176,43,176,40,176,37,176,35,174,33,171,33,168,33,166,33,165,32,164,28,164,26,164,25,166,22,167,20,168,17,168,17,167,14,165,12,165,11,166,9,167,9,167,7,166,7,165,7,163,7,162,6,162,4,162,3,160,3,158,3,157,3,155,4,154,4,154,4,153,3,151,4,150,6,148,7,147,8,146,10,146,11"  title="서울특별시 노원구">
								<area shape="poly" coords="125,3,122,7,123,7,123,9,123,9,124,10,125,11,125,12,126,13,126,13,126,14,127,15,127,15,128,16,128,16,129,18,128,19,128,20,128,20,128,21,127,22,126,23,126,24,126,25,126,26,127,27,127,28,127,29,127,30,128,30,129,30,130,30,131,30,131,30,131,30,131,32,132,33,132,34,134,34,134,34,134,33,134,34,134,34,135,35,135,35,135,35,136,36,137,37,137,37,138,37,138,38,139,39,140,39,140,40,140,41,140,41,142,38,142,38,142,36,143,36,144,35,145,34,145,34,146,34,146,34,146,34,146,34,147,33,146,33,146,32,146,31,146,30,145,28,145,27,145,26,144,24,144,22,143,21,143,19,143,18,142,17,142,16,142,13,143,11,144,9,144,7,144,6,144,3,141,3,141,3,140,3,139,3,138,4,137,4,137,4,137,5,136,6,136,6,135,3,134,1,134,1,133,1,132,0,131,0,130,0,129,0,128,0,127,1,129,0,129,0,129,0,130,0,131" title="서울특별시 도봉구">
								<area shape="poly" coords="118,14,115,18,115,20,114,20,113,22,111,24,110,25,109,27,109,28,109,30,110,31,111,33,111,34,110,34,110,35,109,36,109,38,110,38,112,38,114,40,116,41,117,42,120,44,121,45,122,46,123,47,123,49,124,51,126,52,128,53,130,54,132,54,134,55,134,55,135,56,137,54,139,53,143,49,141,45,140,44,138,44,136,42,135,41,133,39,131,36,130,34,130,33,126,32,123,32,122,30,122,28,124,24,125,21,128,21,128,18,127,18,124,17,122,14,122,13,121,10,121,8,118,9,115,11,114,14,113,15,112,16,112,18,112,19,116,9,117,9,117,9"  title="서울특별시 강북구">
								<area shape="poly" coords="158,54,162,48,164,49,164,50,167,51,169,52,174,51,180,52,180,53,180,56,180,59,179,61,179,63,180,65,182,65,182,67,179,68,177,71,177,73,177,75,173,75,173,77,172,78,172,80,169,81,164,82,161,83,159,82,160,74,160,73,160,71,157,70,155,68,156,66,156,59,157,57,160,55,162,54,167,51,169,50"  title="서울특별시 중랑구">
								<area shape="poly" coords="153,60,142,65,141,66,138,68,138,72,137,73,135,76,133,78,132,80,132,81,133,82,134,82,137,82,141,80,143,80,144,80,147,82,147,82,150,84,152,86,155,87,156,87,157,88,158,87,159,84,160,83,160,80,160,77,157,74,156,73,154,72,153,71,152,68,152,67,152,65,152,65,155,65,155,62,155,60,155,58,153,58,152,59,150,60,147,61,145,62,143,63,142,64,139,66,139,68,139,69"  title="서울특별시 동대문구">
								<area shape="poly" coords="110,42,110,48,112,50,113,52,114,54,115,57,115,60,115,64,114,64,112,65,111,65,110,66,116,67,119,67,121,67,123,70,125,72,128,74,131,75,132,76,135,75,138,72,140,69,140,66,140,64,143,62,145,62,147,60,151,58,156,57,153,56,151,56,149,54,148,53,146,51,144,48,144,48,141,52,139,55,138,57,137,58,134,58,129,57,126,54,123,53,122,51,121,48,120,47,117,45,113,42"  title="서울특별시 성북구">
								<area shape="poly" coords="105,45,94,49,94,52,95,54,96,57,96,61,97,63,101,65,101,65,101,69,101,72,101,77,99,79,101,83,104,82,110,80,116,80,124,81,129,81,132,81,133,79,130,78,125,76,123,74,122,74,120,71,120,69,120,67,115,68,114,68,111,68,108,65,106,61,107,59,109,58,110,56,110,52,108,48,104,45,104,43,100,42,100,42"  title="서울특별시 종로구">
								<area shape="poly" coords="77,75,76,79,76,79,78,80,81,80,82,81,83,82,84,84,85,84,87,87,88,89,91,90,94,90,98,88,102,88,103,86,104,85,104,83,103,82,102,83,99,80,98,80,97,78,95,77,95,73,97,73,98,71,97,69,97,67,97,65,98,62,98,62,96,61,95,59,95,58,95,57,92,57,91,59,90,62,89,63,87,63,87,63,87,64,85,65,84,67,83,68,83,70,82,71,80,72,80,73,79,75,78,75,77,75"  title="서울특별시 서대문구">
								<area shape="poly" coords="93,27,78,32,78,34,78,34,75,34,74,34,73,33,72,32,72,32,71,35,73,38,73,40,73,41,72,43,72,44,71,46,72,48,72,50,71,51,69,52,69,56,69,59,69,62,69,65,69,67,68,68,66,68,62,67,61,67,60,67,60,68,61,70,63,72,66,73,67,75,71,79,73,76,76,70,76,69,77,69,78,71,80,72,83,71,84,68,84,65,86,63,88,61,91,59,93,58,94,57,95,51,94,47,94,46,96,45,97,45,101,44,104,43,106,42,103,40,101,37,99,34,99,32,97,30,93,28,91,27,90,27,88,28,86,31,84,32,81,34,78,35,77,35,77,35"  title="서울특별시 은평구">
								<area shape="poly" coords="172,81,157,85,156,89,156,93,154,96,154,99,152,102,151,103,151,105,152,107,156,108,160,108,165,108,168,107,168,102,171,99,173,97,175,95,176,93,177,87,178,85,175,88,174,88,172,87,171,84,172,81,172,80,171,80,165,81,160,81,159,84,157,85"  title="서울특별시 광진구">
								<area shape="poly" coords="142,82,131,86,131,86,131,88,128,90,125,93,125,96,125,97,127,98,131,100,132,98,136,97,138,98,142,99,145,99,147,102,149,102,152,100,153,95,157,89,157,88,153,87,149,87,144,85,142,83,138,80,138,79,138,79"  title="서울특별시 성동구">
								<area shape="poly" coords="111,83,103,87,103,88,106,88,108,88,112,89,115,89,116,91,117,94,121,95,124,93,125,93,126,94,127,94,128,91,128,88,130,88,131,86,132,84,132,82,130,81,127,81,125,81,123,81,120,81,117,81,113,82,111,82,109,82,109,82,108,81,108,81,110,83,110,83,111,84,112,84,115,86,118,86,121,85,122,84,125,83,127,83,132,83,121,84,120,84,117,84,116,84,114,84,114,84,112,84,112,85,114,84,116,84,118,85,118,85"  title="서울특별시 중구">
								<area shape="poly" coords="103,91,99,96,98,98,97,100,96,102,96,105,95,106,95,107,95,109,96,109,97,110,99,111,103,111,106,112,109,113,110,115,114,116,118,114,121,112,123,109,124,107,127,105,130,103,130,101,126,101,125,101,123,95,122,94,119,93,116,93,116,95,115,96,114,95,112,94,110,93,107,93,105,91,104,91,103,92,102,94,102,96,101,98,99,100,98,101,98,102"  title="서울특별시 용산구">
								<area shape="poly" coords="61,72,53,76,52,76,51,77,54,79,56,80,57,81,59,82,61,85,65,87,71,91,73,92,77,96,78,97,85,96,88,96,90,97,91,99,93,100,94,102,96,102,99,99,100,98,101,95,103,93,102,90,102,89,98,88,95,90,94,90,92,91,87,92,86,92,84,89,81,88,79,87,79,85,81,84,76,83,75,81,70,80,69,78,68,77,67,75,61,71,60,70,58,67,57,69,57,69,56,71,53,74,52,74,52,74"  title="서울특별시 마포구">
								<area shape="poly" coords="208,76,197,80,196,81,194,83,191,83,188,83,186,83,186,82,185,85,184,87,183,89,182,92,181,96,180,98,179,100,181,101,181,101,183,102,184,104,184,105,183,107,186,108,187,108,190,110,193,111,194,112,197,112,198,109,200,104,201,100,199,98,200,97,205,96,207,94,213,94,214,94,214,92,213,89,210,84,208,81,208,78,208,77,205,76,205,73,205,72,203,73,202,73"  title="서울특별시 강동구">
								<area shape="poly" coords="164,115,157,120,159,121,161,122,164,123,168,124,173,127,175,129,178,131,181,133,182,139,183,141,186,143,187,144,191,143,190,140,189,139,188,137,186,137,187,136,191,136,193,136,195,134,199,133,202,130,203,129,201,124,200,121,195,120,192,120,191,116,191,115,191,114,193,115,193,114,190,112,188,111,186,111,185,110,183,108,181,107,179,107,179,107,178,105,178,103,183,104,183,103,183,101,182,100,179,99,178,99,178,99,177,99,176,98,176,98,177,102,177,103,177,105,177,107,176,108,172,109,169,110,168,111,167,112,166,114,163,116,162,115,159,114,159,114"  title="서울특별시 송파구">
								<area shape="poly" coords="135,104,128,109,129,111,131,113,131,115,132,118,133,119,134,123,135,126,136,129,137,131,139,133,141,134,142,134,144,137,146,140,147,141,148,142,153,143,156,141,159,141,162,140,165,139,167,142,167,145,167,147,168,147,173,148,177,147,179,148,182,149,183,149,184,145,184,144,180,143,179,140,178,138,176,136,175,134,174,131,174,130,168,127,167,126,163,125,160,125,158,125,157,124,152,120,152,120,152,118,152,117,153,115,152,113,151,112,146,109,142,106,138,105,136,105"  title="서울특별시 강남구">
								<area shape="poly" coords="127,114,119,118,118,119,115,120,113,121,111,121,111,122,112,125,113,126,113,129,112,132,111,135,111,137,111,141,111,142,113,143,114,146,114,149,115,149,117,149,119,146,119,144,121,145,123,146,124,148,125,150,127,151,128,152,131,153,135,150,136,149,138,147,140,151,141,153,141,156,140,159,140,160,140,161,142,163,145,164,150,164,157,164,161,164,160,163,157,158,157,158,157,157,160,158,163,159,164,158,165,156,167,154,169,152,170,150,165,146,162,141,161,140,159,139,155,142,151,144,145,145,144,144,142,137,140,136,137,134,134,133,133,129,132,126,131,122,130,120,129,114,127,113,126,110,126,110"  title="서울특별시 서초구">
								<area shape="poly" coords="93,116,83,121,83,121,82,123,81,126,79,127,78,127,76,130,74,132,72,135,76,133,79,133,80,129,82,127,85,126,86,126,89,127,91,129,93,129,98,128,102,128,104,130,104,133,105,135,111,138,111,139,112,138,112,133,112,130,112,130,110,127,110,124,109,123,106,121,104,120,102,118,99,117,96,115,95,115,92,114,90,115,90,116,88,117,88,117,85,118,84,119,83,122,83,123,82,123" title="서울특별시 동작구">
								<area shape="poly" coords="82,133,74,137,75,138,77,140,77,141,77,143,77,147,79,149,80,150,82,151,85,152,86,155,88,159,92,162,92,164,95,164,99,161,103,161,106,159,107,157,111,156,113,152,114,151,114,148,114,145,112,143,109,140,107,139,104,138,102,138,99,136,99,133,99,132,100,132,98,131,96,129,94,130,92,130,87,130,86,131,85,130,84,129,84,129,81,131,79,134,75,136,75,136"  title="서울특별시 관악구">
								<area shape="poly" coords="64,138,58,140,59,144,60,146,62,147,64,149,66,152,67,156,70,159,72,160,72,163,73,165,79,165,82,162,83,160,84,158,84,154,79,152,78,151,76,151,76,149,77,148,76,145,74,142,72,138,74,140,75,139,75,138,72,138,69,139,65,139,61,137"  title="서울특별시 금천구">
								<area shape="poly" coords="62,95,59,93,62,101,63,102,63,104,64,106,64,108,61,110,61,112,61,114,62,115,65,116,67,117,68,119,69,122,69,126,70,129,71,132,73,131,76,128,79,126,80,125,82,117,83,114,85,113,88,113,90,112,91,112,88,108,85,106,81,104,78,103,74,104,72,104,70,101,65,98"  title="서울특별시 영등포구">
								<area shape="poly" coords="69,135,52,120,37,120,36,122,34,122,27,122,28,124,25,125,24,126,24,128,27,130,29,131,29,134,28,136,26,139,28,141,31,141,35,137,37,137,40,139,43,140,44,139,46,133,48,131,49,130,52,129,53,128,55,129,60,133,65,135,66,135,66,135,67,136"  title="서울특별시 구로구">
								<area shape="poly" coords="55,97,50,102,51,103,51,105,51,107,49,108,46,109,41,110,37,110,36,107,34,103,32,99,29,102,30,103,32,106,33,109,32,113,31,115,31,118,37,120,37,120,37,122,39,120,45,119,50,117,53,119,54,119,55,122,57,120,59,117,59,114,58,110,58,107,59,106,61,106,63,106,65,103,64,99,61,97,58,97,56,96,51,96,51,95"  title="서울특별시 양천구">
								<area shape="poly" coords="18,65,16,69,16,73,12,77,10,79,8,83,7,86,7,89,5,91,2,91,0,91,1,94,4,96,17,96,16,96,15,98,15,99,16,101,17,102,20,103,20,98,24,98,29,100,31,99,34,97,36,97,37,101,39,105,40,106,42,108,46,107,49,106,51,105,51,103,51,100,51,96,51,94,54,92,55,95,57,95,56,92,53,90,50,86,42,84,41,83,39,79,35,78,32,75,29,71,25,69,22,67,19,64,18,62"  title="서울특별시 강서구">
							</map>
						</div>
						<h4 style="color: white; margin-top: 30px; font-family: sangsangTitle; font-size: 1.1rem;">* <a href="../login/login.do" style="color: #F3C209; font-family: sangsangTitle; text-decoration: underline;">로그인</a> 후에 사용하세요.</h4>
						<h4 style="color: white; bottom:0px; font-family: sangsangTitle; font-size: 1.1rem;">* 처음 이용이시라면 <a href="javascript:swal('이용안내','준비중입니다. \n빠른 시일내에 찾아뵙겠습니다.','error');" style="color: #F3C209; font-family: sangsangTitle; text-decoration: underline;">이용안내</a>를 먼저 참고하세요.</h4>
					</div>
					<div class="main_right" style="width: 60%; padding-left: 10%; font-family: sangsangBody;"> 
						<input type="text" class="form-control" placeholder="찾으시는 장소를 입력하세요." id="searchAreaText" name="searchAreaText" value="" style="width:100%; margin-bottom: 0.5rem; margin-top: 0.5rem; display:unset;">
						<table class="table table-striped table-hover" style="border-radius: 10px;">
							<tbody class="tbody">
							</tbody>
							<tfoot>
								<tr>
									<td>
										<nav aria-label="..." >
											<ul class="pagination justify-content-center">
											</ul>
										</nav>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div class="content reservation_second" style="display: none; padding-left:5%; padding-right:13%;">
					<div style="width:fit-content; display: inline-block; ">
						<input type="button" class="btn btn-success" value="뒤로가기" onclick="reservationSearchBack();">
					</div>
					<div id="map" style="width:90%;height:inherit; display: inline-block; float:right;">
					</div>				
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../common/chatBt.jsp"></jsp:include>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=naver map key&submodules=panorama"></script>
	<!-- daterangepicker -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<script src="../resources/js/reservation_map.js"></script>
	<script src="../resources/js/reservation.js"></script>	
</body>
</html>
<jsp:include page="../common/footer.jsp"></jsp:include>