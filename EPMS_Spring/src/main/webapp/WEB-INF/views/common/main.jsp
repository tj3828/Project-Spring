<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="height: 100%; padding: 0; margin: 0;">
<head>
<meta charset="UTF-8">
<title>주차해드림 - EPMS</title>
</head>
<link rel="stylesheet" href="../resources/css/mainPage.css">
<script src="../resources/js/jquery-3.3.1.min.js"></script>
	<jsp:include page="../common/top.jsp"></jsp:include>
<body style="height: inherit; padding: 0; margin: 0; position: relative;">
	<div class="main-body">
		<div class="container main-container">
			<div class="main-logo">
				<div class="main-logo-img">
					<div class="left"></div>
					<img class="img-fluid" src="../resources/images/mainIcon/mainlogo3.png" width="15%" height="auto">
					<div class="right"></div>
				</div>
			</div>
			<div class="box">
				<div class="content">
					<h1 style="color: crimson; font-size: 5vmin; text-align: left;">간편예약 서비스</h1>
					<div class="mapSelect kr_All" style="left:0px; display: none;">       
					<ul>
						<li class="map1" style="display: none;z-index: 5000;"><img src="../resources/images/map/img_map_01.png" alt="서울특별시"></li>
						<li class="map2" style="display: none;z-index: 5000;"><img src="../resources/images/map/img_map_02.png" alt="인천광역시"></li>
						<li class="map3" style="display: none;"><img src="../resources/images/map/img_map_03.png" alt="경기도"></li>
						<li class="map4" style="display: none;"><img src="../resources/images/map/img_map_04.png" alt="강원도"></li>
						<li class="map5" style="display: none;z-index: 5000;"><img src="../resources/images/map/img_map_05.png" alt="충청남도"></li>
						<li class="map6" style="display: none;z-index: 5000;"><img src="../resources/images/map/img_map_06.png" alt="대전광역시"></li>
						<li class="map7" style="display: none;"><img src="../resources/images/map/img_map_07.png" alt="충청북도"></li>
						<li class="map8" style="display: none;"><img src="../resources/images/map/img_map_08.png" alt="경상북도"></li>
						<li class="map9" style="display: none;"><img src="../resources/images/map/img_map_09.png" alt="대구광역시"></li>
						<li class="map10" style="display: none;"><img src="../resources/images/map/img_map_10.png" alt="울산광역시"></li>
						<li class="map11" style="display: none;"><img src="../resources/images/map/img_map_11.png" alt="부산광역시"></li>
						<li class="map12" style="display: none;"><img src="../resources/images/map/img_map_12.png" alt="경상남도"></li>
						<li class="map13" style="display: none;"><img src="../resources/images/map/img_map_13.png" alt="전라북도"></li>
						<li class="map14" style="display: none;"><img src="../resources/images/map/img_map_14.png" alt="전라남도"></li>
						<li class="map15" style="display: none;"><img src="../resources/images/map/img_map_15.png" alt="광주광역시"></li>
						<li class="map16" style="display: none;"><img src="../resources/images/map/img_map_16.png" alt="제주특별자치도"></li>
					</ul>
					<img src="../resources/images/map/img_map_area.gif" alt="" usemap="#Map1" class="imgMap" border="0">
					<map name="Map1" id="Map1">
						<area shape="poly" coords="72,56,76,56,76,54,78,53,80,52,81,49,84,49,86,49,87,51,87,54,90,56,91,59,89,62,86,64,82,65,79,64,76,64,74,63,73,60,72,57" title="서울특별시">
						<area shape="poly" coords="61,57,64,56,66,56,69,56,72,57,72,59,72,62,71,64,70,65,66,67,64,68,61,69,57,69,54,69,53,67,53,64,52,61,47,61,45,59,44,55,43,53,44,52,48,54,51,55,53,56,55,56,57,54,57,52,56,50,48,50,45,48,45,45,47,43,51,42,54,41,58,43,59,45,60,47,60,49,60,52,60,54,60,55" href="javascript:render_areasearch('인천');" title="인천">
						<area shape="poly" coords="56,70,60,69,65,67,69,66,71,64,72,62,75,63,78,65,81,65,84,65,87,62,90,60,90,57,88,55,86,52,83,49,80,49,79,51,77,53,75,54,73,57,72,56,67,55,66,55,62,56,61,56,61,53,61,50,62,47,62,45,65,43,67,42,68,39,65,37,66,35,69,35,72,34,74,31,75,30,73,27,70,26,74,23,75,21,77,23,79,25,81,28,82,30,85,31,88,32,90,33,93,35,95,37,95,38,98,40,98,42,98,44,97,47,96,50,96,52,98,54,99,56,101,57,105,58,107,58,108,60,108,62,106,63,107,66,108,68,107,71,106,73,107,76,107,78,105,81,103,83,101,85,98,86,95,87,94,88,92,91,90,92,87,93,85,94,83,92,78,92,73,93,71,94,67,94,65,94,63,92,61,90,59,87,57,85,56,82,56,80,61,79,62,78,60,76,58,74,56,71,55,69" href="javascript:render_areasearch('경기');" title="경기도">
						<area shape="poly" coords="104,84,108,84,110,83,111,82,114,79,116,78,116,81,118,82,122,80,125,79,127,81,128,83,129,84,135,84,138,86,138,87,141,89,144,89,148,89,150,88,154,88,155,88,160,86,162,88,167,87,170,86,173,83,172,79,169,75,167,71,165,67,164,61,161,59,159,55,157,52,152,47,151,46,147,39,144,35,142,32,140,28,138,25,137,23,136,20,135,16,134,15,128,14,126,18,125,21,123,21,120,21,112,21,109,21,106,21,104,21,100,20,97,21,96,22,92,20,90,19,86,21,82,23,78,23,77,25,81,29,81,32,87,34,90,37,92,39,95,41,96,43,96,47,95,51,94,53,95,55,98,57,101,60,104,61,105,63,106,65,106,69,105,72,106,76,105,79,104,81" href="javascript:render_areasearch('강원');" title="강원도">
						<area shape="poly" coords="56,138,60,138,63,137,66,137,69,134,71,132,73,128,75,128,77,130,78,132,81,134,84,132,87,130,91,130,94,133,94,136,95,136,99,137,105,136,105,135,102,130,102,128,100,124,98,123,96,126,93,125,89,123,87,121,87,119,88,114,90,112,92,110,91,107,89,104,87,101,90,97,91,96,92,94,91,89,89,88,81,88,78,88,75,89,72,90,71,93,67,94,64,96,61,93,58,91,57,90,53,88,52,91,50,94,47,90,46,90,46,94,46,96,43,93,41,93,39,94,39,97,39,99,38,99,36,101,37,105,40,107,42,110,42,115,43,116,44,120,45,123,48,122,48,119,46,115,45,112,44,108,44,106,43,101,45,103,48,105,49,107,50,110,52,115,52,117,52,122,52,126,53,129,53,131,54,134,54,137,55,138" href="javascript:render_areasearch('충남');" title="충청남도">
						<area shape="poly" coords="87,114,89,112,91,109,93,109,95,112,97,112,98,114,97,117,96,119,97,121,97,122,95,126,93,126,92,125,89,123,88,122,86,119,86,117,86,114" title="대전광역시">
						<area shape="poly" coords="85,101,88,96,89,93,88,89,92,87,94,84,98,82,101,80,105,78,108,77,113,75,115,73,117,72,120,76,124,74,128,73,130,76,135,78,137,78,140,80,140,83,137,87,137,88,137,91,137,94,132,96,131,93,128,92,123,93,123,94,121,97,114,100,113,101,110,104,109,106,112,108,111,112,110,116,108,119,108,121,111,122,114,123,116,125,117,128,113,133,112,135,106,138,105,136,102,135,100,133,99,129,99,128,97,126,96,125,93,122,95,118,96,116,94,114,90,112,87,109,87,106,86,101" title="충청북도">
						<area shape="poly" coords="112,143,110,140,110,137,110,133,117,128,114,124,114,121,112,120,108,118,108,115,111,111,112,108,110,104,110,103,113,99,117,97,120,95,123,93,126,91,132,92,133,93,136,91,137,87,139,83,142,81,146,79,150,79,158,78,162,79,170,78,173,75,177,79,176,83,176,89,177,94,178,97,179,99,176,103,175,107,176,109,178,113,176,117,175,121,175,125,175,128,175,132,176,137,176,140,181,139,183,138,183,143,182,146,180,150,177,152,172,152,170,149,165,151,163,153,160,155,155,157,153,159,147,159,144,157,142,156,141,154,140,152,146,150,147,146,149,143,150,141,150,137,148,136,145,135,142,135,137,136,132,139,129,141,131,143,132,145,131,150,131,151,131,153,128,155,122,155,123,150,122,147,119,145,117,145,113,144" href="javascript:render_areasearch('경북');" title="경상북도">
						<area shape="poly" coords="133,152,137,151,139,151,143,150,146,148,148,146,149,143,151,140,152,138,150,135,148,134,145,134,141,134,138,134,136,135,132,137,131,139,131,141,133,143,133,144,133,146,132,149,132,150,132,152" title="대구광역시">
						<area shape="poly" coords="162,157,162,153,165,149,167,147,170,147,171,147,173,149,178,149,179,148,182,146,182,148,181,154,181,158,181,160,180,164,180,167,179,169,177,168,175,167,173,164,172,162,168,162,167,161,165,160,163,159,160,158" title="울산광역시">
						<area shape="poly" coords="151,171,156,169,159,166,162,163,164,162,165,164,167,166,168,167,169,167,169,172,167,175,165,177,164,178,162,181,160,182,159,184,157,185,153,185,152,189,151,190,150,183,148,182,147,180,146,180,144,180,141,182,139,185,138,186,136,183,135,181,135,178,139,176,142,176,146,177,149,175,151,172" href="javascript:render_areasearch('부산');" title="부산광역시">
						<area shape="poly" coords="109,190,108,185,109,181,108,179,106,177,104,175,102,172,101,170,99,165,98,162,101,158,101,157,100,151,99,149,102,144,103,139,107,136,111,135,113,134,121,136,122,138,124,141,124,143,125,146,128,147,134,147,137,146,140,146,144,148,147,150,150,151,154,151,158,150,161,149,163,150,163,152,164,154,166,156,170,156,172,159,171,161,168,163,165,166,160,168,157,169,157,173,152,174,145,174,143,176,142,178,145,181,145,183,140,183,138,186,134,187,134,190,134,193,133,196,130,198,126,193" title="경상남도">
						<area shape="poly" coords="49,159,55,154,59,151,60,148,56,145,54,142,56,140,56,137,58,135,62,136,65,135,69,133,71,131,74,126,75,128,78,131,79,132,84,130,87,129,90,130,92,132,95,135,98,135,101,135,105,134,107,133,111,134,113,135,114,140,110,142,107,144,105,147,104,149,102,154,102,155,102,159,102,162,102,164,100,169,99,171,92,169,86,169,81,171,78,172,76,167,72,164,71,163,68,162,63,162,62,164,61,167,58,168,54,169,54,165,54,162,49,160" title="전라북도">
						<area shape="poly" coords="113,194,111,190,112,187,111,184,108,181,106,178,105,176,103,173,103,172,101,168,101,168,92,167,89,167,86,167,83,168,81,168,79,169,77,170,75,172,75,175,75,177,72,180,69,181,66,181,62,180,61,179,59,175,59,173,62,170,66,170,69,170,71,169,74,167,76,165,76,164,74,162,70,161,66,160,64,162,62,164,59,166,55,166,53,165,52,165,49,166,46,167,44,170,43,173,41,176,42,179,45,183,46,186,43,186,41,183,40,183,34,185,32,187,30,191,32,195,38,190,39,190,40,193,39,197,42,201,45,203,47,205,50,207,49,209,46,209,42,207,38,207,38,210,42,212,43,215,49,215,50,218,48,220,47,224,50,228,53,228,56,222,58,219,60,218,61,221,65,222,68,218,70,216,72,213,75,212,79,210,82,207,84,206,84,210,80,213,77,217,81,219,86,220,88,219,90,214,91,212,91,208,91,205,91,202,93,200,95,203,98,205,98,209,100,212,105,209,108,204,104,201,101,197,104,195,108,194,110,194,111,194,112,194" href="javascript:render_areasearch('전남');" title="전라남도">
						<area shape="poly" coords="60,177,58,173,60,170,62,169,66,171,70,170,72,171,75,173,74,176,72,179,69,180,66,181,63,181,61,178" title="광주광역시">
						<area shape="poly" coords="33,242,38,238,43,236,49,235,50,234,53,232,57,233,62,233,66,233,67,234,67,237,66,239,63,241,61,243,58,245,58,247,55,248,52,248,48,248,41,249,40,249,36,246,34,245,33,244" title="제주특별자치도">
					</map>
				</div>
					<div class="mapSelect kr_Seoul" style="left:0px;">
						<ul> 
							<li class="map1" style="display: none;"><img src="../resources/images/map2/img_map_01.png" alt="서울특별시 노원구""></li>
							<li class="map2" style="display: none;"><img src="../resources/images/map2/img_map_02.png" alt="서울특별시 도봉구"></li>
							<li class="map3" style="display: none;"><img src="../resources/images/map2/img_map_03.png" alt="서울특별시 강북구"></li>
							<li class="map4" style="display: none;"><img src="../resources/images/map2/img_map_04.png" alt="서울특별시 중량구"></li>
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
							<area shape="poly" coords="152,4,146,6,146,7,146,9,146,10,146,11,146,12,146,14,146,14,146,15,145,16,144,17,144,19,144,21,144,22,145,24,145,26,146,27,146,28,147,29,147,30,148,32,148,34,149,35,149,37,148,38,147,39,146,39,144,38,144,38,144,38,142,40,142,41,142,42,143,43,143,44,143,45,143,46,143,47,145,50,148,51,148,51,150,51,153,52,153,52,156,52,158,51,161,50,163,49,165,49,168,50,168,50,170,49,172,49,172,48,173,45,175,45,176,43,176,40,176,37,176,35,174,33,171,33,168,33,166,33,165,32,164,28,164,26,164,25,166,22,167,20,168,17,168,17,167,14,165,12,165,11,166,9,167,9,167,7,166,7,165,7,163,7,162,6,162,4,162,3,160,3,158,3,157,3,155,4,154,4,154,4,153,3,151,4,150,6,148,7,147,8,146,10,146,11" href="javascript:render_areasearch('서울특별시 노원구');" title="서울특별시 노원구">
							<area shape="poly" coords="125,3,122,7,123,7,123,9,123,9,124,10,125,11,125,12,126,13,126,13,126,14,127,15,127,15,128,16,128,16,129,18,128,19,128,20,128,20,128,21,127,22,126,23,126,24,126,25,126,26,127,27,127,28,127,29,127,30,128,30,129,30,130,30,131,30,131,30,131,30,131,32,132,33,132,34,134,34,134,34,134,33,134,34,134,34,135,35,135,35,135,35,136,36,137,37,137,37,138,37,138,38,139,39,140,39,140,40,140,41,140,41,142,38,142,38,142,36,143,36,144,35,145,34,145,34,146,34,146,34,146,34,146,34,147,33,146,33,146,32,146,31,146,30,145,28,145,27,145,26,144,24,144,22,143,21,143,19,143,18,142,17,142,16,142,13,143,11,144,9,144,7,144,6,144,3,141,3,141,3,140,3,139,3,138,4,137,4,137,4,137,5,136,6,136,6,135,3,134,1,134,1,133,1,132,0,131,0,130,0,129,0,128,0,127,1,129,0,129,0,129,0,130,0,131" href="javascript:render_areasearch('서울특별시 도봉구');" title="서울특별시 도봉구">
							<area shape="poly" coords="118,14,115,18,115,20,114,20,113,22,111,24,110,25,109,27,109,28,109,30,110,31,111,33,111,34,110,34,110,35,109,36,109,38,110,38,112,38,114,40,116,41,117,42,120,44,121,45,122,46,123,47,123,49,124,51,126,52,128,53,130,54,132,54,134,55,134,55,135,56,137,54,139,53,143,49,141,45,140,44,138,44,136,42,135,41,133,39,131,36,130,34,130,33,126,32,123,32,122,30,122,28,124,24,125,21,128,21,128,18,127,18,124,17,122,14,122,13,121,10,121,8,118,9,115,11,114,14,113,15,112,16,112,18,112,19,116,9,117,9,117,9" href="javascript:render_areasearch('서울특별시 강북구');" title="서울특별시 강북구">
							<area shape="poly" coords="158,54,162,48,164,49,164,50,167,51,169,52,174,51,180,52,180,53,180,56,180,59,179,61,179,63,180,65,182,65,182,67,179,68,177,71,177,73,177,75,173,75,173,77,172,78,172,80,169,81,164,82,161,83,159,82,160,74,160,73,160,71,157,70,155,68,156,66,156,59,157,57,160,55,162,54,167,51,169,50" href="javascript:render_areasearch('서울특별시 중량구');" title="서울특별시 중량구">
							<area shape="poly" coords="153,60,142,65,141,66,138,68,138,72,137,73,135,76,133,78,132,80,132,81,133,82,134,82,137,82,141,80,143,80,144,80,147,82,147,82,150,84,152,86,155,87,156,87,157,88,158,87,159,84,160,83,160,80,160,77,157,74,156,73,154,72,153,71,152,68,152,67,152,65,152,65,155,65,155,62,155,60,155,58,153,58,152,59,150,60,147,61,145,62,143,63,142,64,139,66,139,68,139,69" href="javascript:render_areasearch('서울특별시 동대문구');" title="서울특별시 동대문구">
							<area shape="poly" coords="110,42,110,48,112,50,113,52,114,54,115,57,115,60,115,64,114,64,112,65,111,65,110,66,116,67,119,67,121,67,123,70,125,72,128,74,131,75,132,76,135,75,138,72,140,69,140,66,140,64,143,62,145,62,147,60,151,58,156,57,153,56,151,56,149,54,148,53,146,51,144,48,144,48,141,52,139,55,138,57,137,58,134,58,129,57,126,54,123,53,122,51,121,48,120,47,117,45,113,42" href="javascript:render_areasearch('서울특별시 성북구');" title="서울특별시 성북구">
							<area shape="poly" coords="105,45,94,49,94,52,95,54,96,57,96,61,97,63,101,65,101,65,101,69,101,72,101,77,99,79,101,83,104,82,110,80,116,80,124,81,129,81,132,81,133,79,130,78,125,76,123,74,122,74,120,71,120,69,120,67,115,68,114,68,111,68,108,65,106,61,107,59,109,58,110,56,110,52,108,48,104,45,104,43,100,42,100,42" href="javascript:render_areasearch('서울특별시 종로구');" title="서울특별시 종로구">
							<area shape="poly" coords="77,75,76,79,76,79,78,80,81,80,82,81,83,82,84,84,85,84,87,87,88,89,91,90,94,90,98,88,102,88,103,86,104,85,104,83,103,82,102,83,99,80,98,80,97,78,95,77,95,73,97,73,98,71,97,69,97,67,97,65,98,62,98,62,96,61,95,59,95,58,95,57,92,57,91,59,90,62,89,63,87,63,87,63,87,64,85,65,84,67,83,68,83,70,82,71,80,72,80,73,79,75,78,75,77,75" href="javascript:render_areasearch('서울특별시 서대문구');" title="서울특별시 서대문구">
							<area shape="poly" coords="93,27,78,32,78,34,78,34,75,34,74,34,73,33,72,32,72,32,71,35,73,38,73,40,73,41,72,43,72,44,71,46,72,48,72,50,71,51,69,52,69,56,69,59,69,62,69,65,69,67,68,68,66,68,62,67,61,67,60,67,60,68,61,70,63,72,66,73,67,75,71,79,73,76,76,70,76,69,77,69,78,71,80,72,83,71,84,68,84,65,86,63,88,61,91,59,93,58,94,57,95,51,94,47,94,46,96,45,97,45,101,44,104,43,106,42,103,40,101,37,99,34,99,32,97,30,93,28,91,27,90,27,88,28,86,31,84,32,81,34,78,35,77,35,77,35" href="javascript:render_areasearch('서울특별시 은평구');" title="서울특별시 은평구">
							<area shape="poly" coords="172,81,157,85,156,89,156,93,154,96,154,99,152,102,151,103,151,105,152,107,156,108,160,108,165,108,168,107,168,102,171,99,173,97,175,95,176,93,177,87,178,85,175,88,174,88,172,87,171,84,172,81,172,80,171,80,165,81,160,81,159,84,157,85" href="javascript:render_areasearch('서울특별시 광진구');" title="서울특별시 광진구">
							<area shape="poly" coords="142,82,131,86,131,86,131,88,128,90,125,93,125,96,125,97,127,98,131,100,132,98,136,97,138,98,142,99,145,99,147,102,149,102,152,100,153,95,157,89,157,88,153,87,149,87,144,85,142,83,138,80,138,79,138,79" href="javascript:render_areasearch('서울특별시 성동구');" title="서울특별시 성동구">
							<area shape="poly" coords="111,83,103,87,103,88,106,88,108,88,112,89,115,89,116,91,117,94,121,95,124,93,125,93,126,94,127,94,128,91,128,88,130,88,131,86,132,84,132,82,130,81,127,81,125,81,123,81,120,81,117,81,113,82,111,82,109,82,109,82,108,81,108,81,110,83,110,83,111,84,112,84,115,86,118,86,121,85,122,84,125,83,127,83,132,83,121,84,120,84,117,84,116,84,114,84,114,84,112,84,112,85,114,84,116,84,118,85,118,85" href="javascript:render_areasearch('서울특별시 중구');" title="서울특별시 중구">
							<area shape="poly" coords="103,91,99,96,98,98,97,100,96,102,96,105,95,106,95,107,95,109,96,109,97,110,99,111,103,111,106,112,109,113,110,115,114,116,118,114,121,112,123,109,124,107,127,105,130,103,130,101,126,101,125,101,123,95,122,94,119,93,116,93,116,95,115,96,114,95,112,94,110,93,107,93,105,91,104,91,103,92,102,94,102,96,101,98,99,100,98,101,98,102" href="javascript:render_areasearch('서울특별시 용산구');" title="서울특별시 용산구">
							<area shape="poly" coords="61,72,53,76,52,76,51,77,54,79,56,80,57,81,59,82,61,85,65,87,71,91,73,92,77,96,78,97,85,96,88,96,90,97,91,99,93,100,94,102,96,102,99,99,100,98,101,95,103,93,102,90,102,89,98,88,95,90,94,90,92,91,87,92,86,92,84,89,81,88,79,87,79,85,81,84,76,83,75,81,70,80,69,78,68,77,67,75,61,71,60,70,58,67,57,69,57,69,56,71,53,74,52,74,52,74" href="javascript:render_areasearch('서울특별시 마포구');" title="서울특별시 마포구">
							<area shape="poly" coords="208,76,197,80,196,81,194,83,191,83,188,83,186,83,186,82,185,85,184,87,183,89,182,92,181,96,180,98,179,100,181,101,181,101,183,102,184,104,184,105,183,107,186,108,187,108,190,110,193,111,194,112,197,112,198,109,200,104,201,100,199,98,200,97,205,96,207,94,213,94,214,94,214,92,213,89,210,84,208,81,208,78,208,77,205,76,205,73,205,72,203,73,202,73" href="javascript:render_areasearch('서울특별시 강동구');" title="서울특별시 강동구">
							<area shape="poly" coords="164,115,157,120,159,121,161,122,164,123,168,124,173,127,175,129,178,131,181,133,182,139,183,141,186,143,187,144,191,143,190,140,189,139,188,137,186,137,187,136,191,136,193,136,195,134,199,133,202,130,203,129,201,124,200,121,195,120,192,120,191,116,191,115,191,114,193,115,193,114,190,112,188,111,186,111,185,110,183,108,181,107,179,107,179,107,178,105,178,103,183,104,183,103,183,101,182,100,179,99,178,99,178,99,177,99,176,98,176,98,177,102,177,103,177,105,177,107,176,108,172,109,169,110,168,111,167,112,166,114,163,116,162,115,159,114,159,114" href="javascript:render_areasearch('서울특별시 송파구');" title="서울특별시 송파구">
							<area shape="poly" coords="135,104,128,109,129,111,131,113,131,115,132,118,133,119,134,123,135,126,136,129,137,131,139,133,141,134,142,134,144,137,146,140,147,141,148,142,153,143,156,141,159,141,162,140,165,139,167,142,167,145,167,147,168,147,173,148,177,147,179,148,182,149,183,149,184,145,184,144,180,143,179,140,178,138,176,136,175,134,174,131,174,130,168,127,167,126,163,125,160,125,158,125,157,124,152,120,152,120,152,118,152,117,153,115,152,113,151,112,146,109,142,106,138,105,136,105" href="javascript:render_areasearch('서울특별시 강남구');" title="서울특별시 강남구">
							<area shape="poly" coords="127,114,119,118,118,119,115,120,113,121,111,121,111,122,112,125,113,126,113,129,112,132,111,135,111,137,111,141,111,142,113,143,114,146,114,149,115,149,117,149,119,146,119,144,121,145,123,146,124,148,125,150,127,151,128,152,131,153,135,150,136,149,138,147,140,151,141,153,141,156,140,159,140,160,140,161,142,163,145,164,150,164,157,164,161,164,160,163,157,158,157,158,157,157,160,158,163,159,164,158,165,156,167,154,169,152,170,150,165,146,162,141,161,140,159,139,155,142,151,144,145,145,144,144,142,137,140,136,137,134,134,133,133,129,132,126,131,122,130,120,129,114,127,113,126,110,126,110" href="javascript:render_areasearch('서울특별시 서초구');" title="서울특별시 서초구">
							<area shape="poly" coords="93,116,83,121,83,121,82,123,81,126,79,127,78,127,76,130,74,132,72,135,76,133,79,133,80,129,82,127,85,126,86,126,89,127,91,129,93,129,98,128,102,128,104,130,104,133,105,135,111,138,111,139,112,138,112,133,112,130,112,130,110,127,110,124,109,123,106,121,104,120,102,118,99,117,96,115,95,115,92,114,90,115,90,116,88,117,88,117,85,118,84,119,83,122,83,123,82,123" href="javascript:render_areasearch('서울특별시 동작구');" title="서울특별시 동작구">
							<area shape="poly" coords="82,133,74,137,75,138,77,140,77,141,77,143,77,147,79,149,80,150,82,151,85,152,86,155,88,159,92,162,92,164,95,164,99,161,103,161,106,159,107,157,111,156,113,152,114,151,114,148,114,145,112,143,109,140,107,139,104,138,102,138,99,136,99,133,99,132,100,132,98,131,96,129,94,130,92,130,87,130,86,131,85,130,84,129,84,129,81,131,79,134,75,136,75,136" href="javascript:render_areasearch('서울특별시 관악구');" title="서울특별시 관악구">
							<area shape="poly" coords="64,138,58,140,59,144,60,146,62,147,64,149,66,152,67,156,70,159,72,160,72,163,73,165,79,165,82,162,83,160,84,158,84,154,79,152,78,151,76,151,76,149,77,148,76,145,74,142,72,138,74,140,75,139,75,138,72,138,69,139,65,139,61,137" href="javascript:render_areasearch('서울특별시 금천구');" title="서울특별시 금천구">
							<area shape="poly" coords="62,95,59,93,62,101,63,102,63,104,64,106,64,108,61,110,61,112,61,114,62,115,65,116,67,117,68,119,69,122,69,126,70,129,71,132,73,131,76,128,79,126,80,125,82,117,83,114,85,113,88,113,90,112,91,112,88,108,85,106,81,104,78,103,74,104,72,104,70,101,65,98" href="javascript:render_areasearch('서울특별시 영등포구');" title="서울특별시 영등포구">
							<area shape="poly" coords="69,135,52,120,37,120,36,122,34,122,27,122,28,124,25,125,24,126,24,128,27,130,29,131,29,134,28,136,26,139,28,141,31,141,35,137,37,137,40,139,43,140,44,139,46,133,48,131,49,130,52,129,53,128,55,129,60,133,65,135,66,135,66,135,67,136" href="javascript:render_areasearch('서울특별시 구로구');" title="서울특별시 구로구">
							<area shape="poly" coords="55,97,50,102,51,103,51,105,51,107,49,108,46,109,41,110,37,110,36,107,34,103,32,99,29,102,30,103,32,106,33,109,32,113,31,115,31,118,37,120,37,120,37,122,39,120,45,119,50,117,53,119,54,119,55,122,57,120,59,117,59,114,58,110,58,107,59,106,61,106,63,106,65,103,64,99,61,97,58,97,56,96,51,96,51,95" href="javascript:render_areasearch('서울특별시 양천구');" title="서울특별시 양천구">
							<area shape="poly" coords="18,65,16,69,16,73,12,77,10,79,8,83,7,86,7,89,5,91,2,91,0,91,1,94,4,96,17,96,16,96,15,98,15,99,16,101,17,102,20,103,20,98,24,98,29,100,31,99,34,97,36,97,37,101,39,105,40,106,42,108,46,107,49,106,51,105,51,103,51,100,51,96,51,94,54,92,55,95,57,95,56,92,53,90,50,86,42,84,41,83,39,79,35,78,32,75,29,71,25,69,22,67,19,64,18,62" href="javascript:render_areasearch('서울특별시 강서구');" title="서울특별시 강서구">
						</map>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function fe_mapSelectAll(){
			var $container = $(".kr_All");
			var $overImage = $container.find("li");
			var $trigger = $container.find("area");
			selectedArea = -1;
		
			$trigger.each(function(i){
				$(this).mouseover(function(){
					$overImage.hide();
					$overImage.eq(i).show();
					if(selectedArea != -1) {
						$overImage.eq(selectedArea).show();
					}
				});
				
				$(this).mouseleave(function(){
					$overImage.hide();
					if(selectedArea != -1) {
						$overImage.eq(selectedArea).show();
					}
				});
				
				$(this).click(function() {
					$overImage.hide();
					$overImage.eq(i).show();
					selectedArea = i;
				});
			});
		}
		
		fe_mapSelectAll();
		
		function fe_mapSelectSeoul(){
			var $container = $(".kr_Seoul");
			var $overImage = $container.find("li");
			var $trigger = $container.find("area");
			selectedArea = -1;
		
			$trigger.each(function(i){
				$(this).mouseover(function(){
					$overImage.hide();
					$overImage.eq(i).show();
					if(selectedArea != -1) {
						$overImage.eq(selectedArea).show();
					}
				});
				
				$(this).mouseleave(function(){
					$overImage.hide();
					if(selectedArea != -1) {
						$overImage.eq(selectedArea).show();
					}
				});
				
				$(this).click(function() {
					$overImage.hide();
					$overImage.eq(i).show();
					selectedArea = i;
				});
			});
		}
		
		fe_mapSelectSeoul();
	</script>
<jsp:include page="../common/chatBt.jsp"></jsp:include>
</body>
</html>