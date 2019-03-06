var session = $('#sessionScopeNick').val();
var sessionImg = $('#sessionScopeImg').val();
var lat = new Array;
var lon = new Array;
var add = new Array;
var selectNum; // 어떤 마커가 선택되었는지

// 맵에 사용되는 변수
var HOME_PATH = window.HOME_PATH || '.';
var map;
var markers =[];
var infoWindows =[];

// DateTimePicker 셋팅
function setDateTimePicker() {
	  var d = new Date();
	  $('input[name="datetimes"]').daterangepicker({
	    "timePicker": true,
	    "timePicker24Hour": true,
	    "timePickerIncrement": 30,
	    "startDate": moment().startOf('hour'),
	    "minDate": d.getMinutes()%30==0?d:(d.getMinutes()>30?new Date(d.getTime()+(60-d.getMinutes())*60000):new Date(d.getTime()+(30-d.getMinutes())*60000)),
	    locale: {
	      format: 'Y-MM-DD HH:mm'
	    }
	  });
	/*var d = new Date();
	$.fn.datepicker.dates['kr'] = {
   		days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
   		daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
   		daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
   		months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
   		monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
   	};

	$('#reservation_date .time').timepicker({
	    'showDuration': true,
	    'timeFormat': 'H:i',
	    'autoclose': true,
	    'maxTime': '00:01',
	    'minTime':  d.getMinutes()%30==0?d:(d.getMinutes()>30?new Date(d.getTime()+(60-d.getMinutes())*60000):new Date(d.getTime()+(30-d.getMinutes())*60000))
	});

	$('#reservation_date .date').datepicker({
	    'format': 'yyyy-mm-dd',
	    'startDate': new Date(),
	    'language': 'kr',
	    'autoclose': true
	});
	
	var reservation_date = document.getElementById('reservation_date');
    var datepair = new Datepair(reservation_date);
	*/
    // 모달에서 작동하기 위한 기능, 외부클릭하면 피커 close
	$('div').click(function(e){
		if(!$(e.target).hasClass('datetimes') && $(e.target).closest('.daterangepicker').length == 0){
			$('.daterangepicker').hide();
		} else if($(e.target).hasClass('datetimes')) {
			$('.daterangepicker').show();
		}
	});
}

/*// 모달 내용 생성
function modalContentCreate(i){
	var contentString = [
		'<h1 style=""><span class="badge badge-danger" >'+ add[i] +'</span></h1>' ,
		'<table style="width:100%; height:40%;" >',
		'<tr style="border-top: 1px solid #444444;">',
		'<td style="width:50%; height:auto; vertical-align: top; padding-top: 10px; padding-left:10px; text-align:left;"><font style="font-size: 12px; font-weight:bold;">&nbsp;&nbsp;① 원하는 날짜와 시간을 선택한 후 검색을 누르세요.</font> <br><input type="text" style="width:70%;  display: inline-block;" class="datetimes form-control" name="datetimes" onchange="resetSearchList();" />&nbsp;&nbsp;<input type="button" class="btn btn-outline-primary" style=" display: inline-block;"value="검색" onclick="searchList();"></td>',
		'<td style="border-left: 1px solid #444444; width:50%; height:500px; vertical-align: top; padding-top: 10px; padding-left:10px;padding-right:10px;" rowspan="2"><div id="pano" style="width:100%;height:100%;"></div></td>',
		'</tr>',
	    '<tr>',
	    '<td style="border-top: 1px solid #444444; vertical-align: top; padding-top: 10px; padding-left:10px; height:20%; text-align:left;" align="top" ><font style="font-size: 12px; font-weight:bold;">&nbsp;&nbsp;② 희망 자리를 우측 로드뷰에서 확인 후 선택하세요.</font><br><div style="overflow-y:scroll; margin:10px; margin-top:15px; height:10%; width:100%; display:inline-block;" class="reservationList"></div></td>',
	    '</tr>',
	    '</table>'
	].join('');
	return contentString;
}*/

function resetSearchList(){
	$(".reservationList").html("");
}
// 날짜, 시간 선택 후 예약 가능한 목록 출력
function searchList() {
	var from = document.getElementsByName('datetimes')[0].value.split(' - ')[0].trim();
	var to = document.getElementsByName('datetimes')[0].value.split(' - ')[1].trim();
	var data = {"r_from" : from, "r_to" : to, "r_address" : add[selectNum]};
	$.ajax({
		url:'../reservationPage/personalAreaList.do',
		type:'POST',
		data: data,
		dataType: "JSON",
		success:function(data){
			var list = data.list;
			if(list.length == 0) {
				$(".reservationList").html('예약할 수 있는 자리가 없습니다.');
			} else {
				var s = "";
				jQuery.each(list, function(index, entry) {
					var b = "<input type='button' style='margin-right:10px; width:20%; margin-bottom:10px;' class='btn btn-success' id='" + entry["pap_host"] + "' onclick='modalRequestOpen(this);' data-toggle='modal' data-target='#exampleModal1' value='" + entry["pap_area"] +"'>";
					
					s += b;
				});
				for(var i = 0; i<list.length;i++){
					  
				}
				$(".reservationList").html(s);
			}
		},
		error:function(jqXHR, textStatus, errorThrown){
			alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
	    }
	});
	
}

// 요청 모달 오픈
function modalRequestOpen(t) {
	var s = t.value;
	var host = t.id;
	var from = document.getElementsByName('datetimes')[0].value.split(' - ')[0].trim();
	var to = document.getElementsByName('datetimes')[0].value.split(' - ')[1].trim();
	var date = from + " ~ " + to;
	$('#exampleModal').css("z-index","1040");
	$('.hostName').val(host);
	$('#exampleModal1').modal('show');
	$('.requestArea').html(s);
	$('.requestAddress').html(add[selectNum]);
	$('.requestTime').html(date);
}

// 로드뷰 호출
var pano = null;
function roadView(seq) {	
    pano = new naver.maps.Panorama("pano", {
        position: new naver.maps.LatLng(lat[seq], lon[seq]),
        pov: {
            pan: -135,
            tilt: -29,
            fov: 100
        }
    });
}

// 네이버 맵 호출
function modalMap(lat,lon,ad) {
	$('.reservation_first').hide(500);
	$('.reservation_second').show(500);
	$('#map').empty();
	var mapOptions = {
	    center: new naver.maps.LatLng(lat, lon),
	    zoom: 10
	};
	map = new naver.maps.Map('map', mapOptions);
	inputMarker(ad);
	for (var i=0, ii=markers.length; i<ii; i++) {
	    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
	}
}

// 마커 입력
function inputMarker(ad) {

	this.infoWindows= [];
	this.markers= [];
	for(var i=0;i<lat.length;i++){
		var icon = {};
		if(add[i] == ad) {
			icon
		}
		var marker = new naver.maps.Marker({
		    position: new naver.maps.LatLng(lat[i], lon[i])
		});
		if(add[i] == ad) {
			marker.setIcon({
				url : '../resources/images/naverMap/ico_pin.jpg'
			})
		}
		markers.push(marker);
		marker.setMap(map);
		/*var infoWindow = new naver.maps.InfoWindow({
			content: modalContentCreate(i),
		    backgroundColor: '#ddd ',
		    borderColor: '#190707',
		    anchorColor: '#333',
		    borderWidth: 3
		});
		this.infoWindows.push(infoWindow);*/
	}
}

// 마커 이벤트 핸들러
function getClickHandler(seq) {
    return function(e) {
    	if(session == null || session == "") {
    		swal('예약오류','로그인을 먼저 진행해주세요.','error');
    		return;
    	}
    	$('#exampleModal').modal('show');
    	$('.searchModalTitle').html(add[seq]);
    	roadView(seq);
    	setRoadViewSize();
    	selectNum = seq;
    	setDateTimePicker();
        /*var marker = markers[seq],
            infoWindow = infoWindows[seq];
        if (infoWindow.getMap()) {
            infoWindow.close();
        } else {
        	 else {
	            infoWindow.open(map, marker);
	            
	        	
        	}
        }*/
    }
}

function setRoadViewSize() {
	var tdwidth = window.innerWidth *0.8 * 0.5;
	var tdheight = $('.panotd').height();
	
	var targetSize = new naver.maps.Size(parseInt(tdwidth, 10), parseInt(tdheight, 10));
	var newSize = new naver.maps.Size();
	
	$("#pano").stop().animate({
        width: targetSize.width,
        height: targetSize.height
    }, {
        duration: 500,
        step: function(value, tween) {
            if (tween.prop === "width") {
                newSize.width = Math.round(value);
                return;
            }

            if (tween.prop === "height") {
                newSize.height = Math.round(value);
                return;
            }
        },

        progress: function() {
            pano.setSize(newSize.clone());
        }
    });
}

function setOriginMarkerPosition(panoSize) {
    originMarker.css({
        "left": panoSize.width / 2 - 5,
        "top": panoSize.height / 2 - 5
    });
};

// 예약신청
function requestReservation() {
	var from = document.getElementsByName('datetimes')[0].value.split(' - ')[0].trim();
	var to = document.getElementsByName('datetimes')[0].value.split(' - ')[1].trim();
	
	var area = $('.requestArea').html();
	var address = $('.requestAddress').html();
	var message = $('.requestMessage').val();
	var host = $('.hostName').val();
	
	var data = {"r_from" : from, "r_to" : to, "r_address" : address, "r_area" : area, "r_content" :message, "r_host" : host};
	
	$.ajax({
		url:'../reservation/reservationRequest.do',
		type:'POST',
		data: data,
		dataType: "JSON",
		success:function(t){
			if(t.result != -1) {
				swal({
					title : "예약신청 완료",
					text : '이용시간 : ' + from + " ~ " + to +'\n요청지역 : ' + address + '\n주차구역 : ' + area,
					icon : "success"
				}).then((willDelete) => {
					if(willDelete) {
						reservationRequestAlram(t.result);
						// location.href = './reservation_searchboard.do?';
					}
				})
			} else {
				swal("예약 실패",'이미 예약된 구역입니다. 다른 구역을 검색하세요.','error');
			}
		},
		error:function(jqXHR, textStatus, errorThrown){
			swal("에러 발생 " , "관리자에게 문의하세요.", "error");
	    }
	});
}

function reservationRequestAlram(data) {
	var webSocket = $('#chatPage').get(0).contentWindow.webSocket;
	var jsonMsg = 'ReservationRequest#'+ data;
	webSocket.send(jsonMsg);
}

function reservationSearchBack() {
	$('.reservation_first').show(500);
	$('.reservation_second').hide(500);
}
