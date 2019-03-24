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
	      enableHighAccuracy: true,
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
	var apiURI = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='+lat+','+lon+'&key=geocoding key';
	$.ajax({
		url: apiURI,
		dataType: "json",
		type: "GET",
		success: function (data) {
			var temp = data.results[0].formatted_address;
			var add = temp.substring(temp.indexOf(' ') +1);
			var add1 = add.replaceAt(add.indexOf(' ', add.indexOf(' ')), '<br>');
			$('.more-header__title').html(add);
		}
	});
}
			
function getWeather(lat, lon) {
	var apiURI = "https://api.openweathermap.org/data/2.5/weather?&APPID=openweather key&lat="+lat+"&lon="+lon;
	$.ajax({
		url: apiURI,
		dataType: "json",
		type: "GET",
		async: "false",
		success: function (resp) {
			console.log(resp);
			var icon = resp.weather[0].icon;
			if(icon == "50d" || icon == "50n") {
				$('.weather_status_Title').html("Haze");
				$('.weather_status').html('<div class="cloudy"><div class="eyes"></div></div>');
			} else if(icon == "01d" || icon == "02d") {
				$('.weather_status_Title').html("Sunny");
				$('.weather_status').html('<br/><div class="sunny"><div class="eyes"></div></div><br/>');
			} else if(icon == "03d" || icon == "04d" || icon == "03n" || icon == "04d") {
				$('.weather_status_Title').html("Cloudy");
				$('.weather_status').html('<div class="cloudy"><div class="eyes"></div></div>');
			} else if(icon == "09d" || icon == "09n" || icon == "10d" || icon == "10n") {
				$('.weather_status_Title').html("Rainy");
				$('.weather_status').html('<div class="Rainy"><div class="eyes"></div></div>');
			} else if(icon == "11d" || icon == "11n") {
				$('.weather_status_Title').html("ThunderStorm");
				$('.weather_status').html('<div class="stormy"><div class="eyes"></div></div>');
			} else if(icon == "13d" || icon == "13n") {
				$('.weather_status_Title').html("Snowy");
				$('.weather_status').html('<div class="snowy"><div class="eyes"></div></div>');
			} else if(icon == "01n" || icon == "02n") {
				$('.weather_status_Title').html("Starry");
				$('.weather_status').html('<div class="starry"><div class="eyes"></div></div>');
			} else {
				$('.weather_status_Title').html("Error Cloud");
				$('.weather_status').html('<div class="cloudy"><div class="eyes"></div><div class="tear"></div></div>');
			}
			
			$('.wind').html("바람 : " + resp.wind.speed + " m/s");
			var sunrise = new Date(resp.sys.sunrise*1000).toString().split(" ")[4];
			var sunset = new Date(resp.sys.sunset*1000).toString().split(" ")[4];
			$('.sunrise').html("일출 : " + sunrise);
			$('.sunset').html("일몰 : " + sunset);
				
		
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
	var apiURI = "https://api.waqi.info/feed/geo:" + lat + ";" + lon + "/?token=AQI feed key"
	$.ajax({
		url: apiURI,
		dataType: "json",
		type: "GET",
		async: "false",
		success: function (resp) {
			var aqi = resp.data.aqi;
			var status = "";
			if(aqi >=0 && aqi <=50) {
				status += "좋음";
			} else if(aqi >=51 && aqi <=100) {
				status += "보통";
			} else if(aqi >=101 && aqi <=150) {
				status += "민감군영향";
			} else if(aqi >=151 && aqi <=200) {
				status += "나쁨";
			} else if(aqi >=201 && aqi <=300) {
				status += "매우나쁨";
			} else if(aqi >300 ) {
				status += "위험";
			}
			$('.dust').html("미세먼지 : " + resp.data.aqi + " " + status);
		}
	})
}