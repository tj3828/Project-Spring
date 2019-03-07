<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Nanum+Pen+Script&amp;subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <link rel="stylesheet" href="../resources/chat/css/weather.css">
  <title>More</title>
</head>
<script type="text/javascript">
	window.show_leaving_warning = false;
	$(document).ready(function() {
		var chatScroll = "${cookie.chatScroll.value}";
		if(chatScroll == null || chatScroll =="") {
			$(window).scrollTop(0);
		} else {
			$(window).scrollTop(chatScroll);
		}
		
		var notReadCount = "${notReadCount}";
		
		if(notReadCount != "0" && notReadCount != null && notReadCount != "" && notReadCount != 0)	{
			if(parent.$('body').find('.chatBt_notReadCounter').length == 0) {
				parent.$('button.chatBt').after('<span class="chatBt_notReadCounter">' + notReadCount + '</span>');
			} else {
				parent.$('.chatBt_notReadCounter').html(notReadCount);
			}
			$('.fa-comment').after('<span class="Bottom_notReadCounter">' + notReadCount + '</span>');
		} else {
			if(parent.$('body').find('.chatBt_notReadCounter').length == 1) {
				parent.$('.chatBt_notReadCounter').remove();
			}
		}
	});
	
	$(window).on('beforeunload', function() {
		var login = "${sessionScope.dto.id}";
		if(login != null && login != "") {
			document.cookie = "chatPage=" + escape(6) + "; path=/;";
			
			var currentScroll = $(document).scrollTop();
			document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
		}
	});
	
	var webSocket = new WebSocket("ws://localhost:8081/b/ws");
	webSocket.onopen = function(message) {
	}
	webSocket.onerror = function() {
		alert('웹소켓 에러');
	} 
	webSocket.onmessage = function(data) {
		if(data.data != "connected Opponent") {
			var msg = JSON.parse(data.data);
			var nickname = "${sessionScope.dto.nickname}";
			if(msg.toNick == nickname && msg.content != '#$%Room Out#$%') {
				
				var Bottom_notReadCounter = $('.Bottom_notReadCounter').html() *1;
				if(Bottom_notReadCounter == null || Bottom_notReadCounter == "" || Bottom_notReadCounter == 0 || isNaN(Bottom_notReadCounter)) {
					$('.fa-comment').after('<span class="Bottom_notReadCounter"></span>');
					parent.$('button.chatBt').after('<span class="chatBt_notReadCounter"></span>');
					Bottom_notReadCounter = 0;
				}
				Bottom_notReadCounter += 1;
				parent.$('.chatBt_notReadCounter').html(Bottom_notReadCounter);
				$('.Bottom_notReadCounter').html(Bottom_notReadCounter);
				
			}
		} 
	}
</script>
<body style="padding-top: 46px; height: 100%; padding-bottom: 50px;">
  <header class="top-header">
    <div class="header__bottom">
      <div class="header__column">

      </div>
      <div class="header__column">
        <span class="header__text">Weather</span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
  <main class="more" style="height:100%; overflow-y: scroll; " >
    <header class="more__header">
      <div class="more-header__column">
        <div class="more-header__info">
          <h3 class="more-header__title">
            
          </h3>
          <span class="more-header__subtitle">
            해당 사이트의 특성상 오차가 존재합니다.
          </span>
        </div>
      </div>
    </header>
    <section class="more__options" style="background: gainsboro">
      <!-- <div class="more__option">
        <i class="fa fa-smile-o fa-2x"></i>
        <span class="more__option-title">Temperature</span>
      </div> -->
      <div class="more__option" style="padding:0; padding-bottom: 20px; margin-left: auto; margin-right: auto;">
         	<div class="weather">
		      <h3>Cloudy</h3>
		      <div class="cloudy">
		        <div class="eyes"></div>
		      </div>
		    </div><!-- 
		    <div class="weather">
		      <h3>Rainy</h3>
		      <div class="rainy">
		        <div class="eyes"></div>
		      </div>
		    </div>
		    <div class="weather">
		      <h3>Stormy</h3>
		      <div class="stormy">
		        <div class="eyes"></div>
		      </div>
		    </div>
		    <div class="weather">
		      <h3>Sunny</h3>
		      <br />
		      <div class="sunny">
		        <div class="eyes"></div>
		      </div>
		      <br />
		    </div>
		    <div class="weather">
		      <h3>Snowy</h3>
		      <div class="snowy">
		        <div class="eyes"></div>
		      </div>
		    </div>
		    <div class="weather">
		      <h3>Starry</h3>
		      <div class="starry">
		        <div class="eyes"></div>
		      </div>
		    </div>
		    <div class="weather">
		      <h3>Super Sad Error Cloud</h3>
		      <div class="cloudy">
		        <div class="eyes"></div>
		        <div class="tear"></div>
		      </div>
		    </div> -->
        <span class="more__option-title">Weather</span>
      </div>
      <!-- <div class="more__option">
        <i class="fa fa-hand-peace-o fa-2x"></i>
        <span class="more__option-title">Micro Dust</span>
      </div> -->
    </section>
    <!-- 
    <section class="more__plus-friends">
      <header class="plus-friends__header">
        <h2 class="plus-friends__title">Plus Friends</h2>
        <span class="plus-friends__learn-more">
          <i class="fa fa-info-circle"></i>
          Learn More
        </span>
      </header>
      <div class="plus-friends__items">
        <div class="plus-friends__item">
          <i class="fa fa-cutlery"></i>
          <span class="plus-friends__item-title">Order</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-home"></i>
          <span class="plus-friends__item-title">Store</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-television"></i>
          <span class="plus-friends__item-title">TV Channel/Radio...</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-pencil"></i>
          <span class="plus-friends__item-title">Creation</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-graduation-cap"></i>
          <span class="plus-friends__item-title">Education</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-university"></i>
          <span class="plus-friends__item-title">Politics/Society</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-krw"></i>
          <span class="plus-friends__item-title">Finance</span>
        </div>
        <div class="plus-friends__item">
          <i class="fa fa-video-camera"></i>
          <span class="plus-friends__item-title">Movies/Music</span>
        </div>
      </div>
    </section>
    <section class="more__links">
      <div class="more__option">
        <img src="images/kakaoStory.png" alt="" class="more__options-image">
        <span class="more__options-title">Kakao Story</span>
      </div>
      <div class="more__option">
        <img src="images/path.png" alt="" class="more__options-image">
        <span class="more__options-title">Path</span>
      </div>
      <div class="more__option">
        <img src="images/kakaoFriends.png" alt="" class="more__options-image">
        <span class="more__options-title">Kakao friends</span>
      </div>
    </section>
  </main> -->
  <nav class="tab-bar">
    <a href="javascript:location.replace('../chat/friend.do')" class="tab-bar__tab">
      <i class="fa fa-user"></i>
      <span class="tab-bar__title">Friends</span>
    </a>
    <a href="javascript:location.replace('../chat/chats.do')" class="tab-bar__tab">
      <i class="fa fa-comment"></i>
      <span class="tab-bar__title">Chats</span>
    </a>
      <a href="javascript:location.replace('../chat/find.do')" class="tab-bar__tab">
      <i class="fa fa-search"></i>
      <span class="tab-bar__title">Reservation</span>
    </a>
    <a href="javascript:location.replace('../chat/more.do')" class="tab-bar__tab tab-bar__tab--selected">
      <i class="fa fa-ellipsis-h"></i>
      <span class="tab-bar__title">More</span>
    </a>
  </nav>
</body>
<script type="text/javascript">

	$(document).ready(function(){
		
		var lat, lon;
		
		function getLocation() {
		  if (navigator.geolocation) { // GPS를 지원하면
		    navigator.geolocation.getCurrentPosition(function(position) {
		      lat = position.coords.latitude;
		      lon = position.coords.longitude;
		      getWeather(lat, lon);
			  getMicroDust(lat, lon);
			  getAddress(lat, lon);
		    }, function(error) {
		      console.error(error);
		    }, {
		      enableHighAccuracy: false,
		      maximumAge: 0,
		      timeout: Infinity
		    });
		  } else {
		    alert('GPS를 지원하지 않습니다');
		  }
		}
		getLocation();
		
	});
	
	String.prototype.replaceAt=function(index, character) {
	    return this.substr(0, index) + character + this.substr(index+character.length);
	}
	
	function getAddress(lat, lon) {
		var apiURI = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='+lat+','+lon+'&key=AIzaSyBiUoURrhWuQ316Nhzs9-VxhSND-j2eaEU';
		$.ajax({
			url: apiURI,
			dataType: "json",
			type: "GET",
			success: function (data) {
				var temp = data.results[0].formatted_address;
				var add = temp.substring(temp.indexOf(' ') +1);
				 $('.more-header__title').html(add.replaceAt(add.indexOf(' ', add.indexOf(' ') +1 ), '<br>'));
			}
		});
	}
				
	function getWeather(lat, lon) {
		var apiURI = "http://api.openweathermap.org/data/2.5/weather?&APPID=1ef5e68a2c7c6690cc4b8252c545cfd1&lat="+lat+"&lon="+lon;
		$.ajax({
			url: apiURI,
			dataType: "json",
			type: "GET",
			async: "false",
			success: function (resp) {
				console.log(resp);
				$('.more__option-title').html((resp.main.temp- 273.15).toFixed(1)+ " ℃  / "+ resp.main.humidity +" %");
                console.log("현재온도 : "+ (resp.main.temp- 273.15) );
                console.log("현재습도 : "+ resp.main.humidity);
                console.log("날씨 : "+ resp.weather[0].main );
                console.log("상세날씨설명 : "+ resp.weather[0].description );
                console.log("날씨 이미지 : "+ resp.weather[0].icon );
                console.log("바람   : "+ resp.wind.speed );
                console.log("나라   : "+ resp.sys.country );
                console.log("도시이름  : "+ resp.name );
                console.log("구름  : "+ (resp.clouds.all) +"%" ); 
			}
		});
	}
	
	function getMicroDust(lat, lon) {
		var apiURI = "https://api.waqi.info/feed/geo:" + lat + ";" + lon + "/?token=d8af30a72a6589f0d73c7f749cad04fc9125b741"
		$.ajax({
			url: apiURI,
			dataType: "json",
			type: "GET",
			async: "false",
			success: function (resp) {
				var name = resp.data.city.name;
			}
		})
	}
	
	</script>
</html>
