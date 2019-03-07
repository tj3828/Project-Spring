Kakao.init('2899ad92021b65bed011b6501b479356');
function kakaoLogin() {
	Kakao.Auth.loginForm({
        success: function(authObj) {
           Kakao.API.request({
    		  url: '/v2/user/me',
    		  success: function(res) {
    			  	 var id = res.id;
    			  	 var name = res.properties.nickname;
    			  	 var email = res.kakao_account.email;
    			  	 var gender = res.kakao_account.gender;
    			  	 
    			  	 location.href="../login/kakaoLogin.do?id="+id+"&name="+name+"&email="+email+"&gender="+gender;
	    			 
			  },
			  fail: function(error) {
				alert(JSON.stringify(error))
			}
    	  })
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
	});
}

function statusChangeCallback(response){
	if(response.status === "connected"){
		FB.api('/me', function(res){
			FB.api('/me', function(res){
				 var id = res.id;
			  	 var name = res.name;
			  	 var email = res.email;
			  	 var gender = res.gender;
			  	 
			  	 location.href="../login/kakaoLogin.do?id="+id+"&name="+name+"&email="+email+"&gender="+gender; 	  		
			});	 	  		
		});
	} else {
	}
}

window.fbAsyncInit = function() {
	FB.init({
		appId      : '641166546301850',
		cookie     : true,  // enable cookies to allow the server to access 
		// the session
		xfbml      : true,  // parse social plugins on this page
		version    : 'v3.2' // use graph api version 3.2
	});
	
	// Now that we've initialized the JavaScript SDK, we call 
	// FB.getLoginStatus().  This function gets the state of the
	// person visiting this page and can return one of three states to
	// the callback you provide.  They can be:
	//
	// 1. Logged into your app ('connected')
	// 2. Logged into Facebook, but not your app ('not_authorized')
	// 3. Not logged into Facebook and can't tell if they are logged into
	//    your app or not.
	//
	// These three cases are handled in the callback function.
};


(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.2';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


function facebookLogin() {
	FB.getLoginStatus(function(response){
		statusChangeCallback(response);
	});
}