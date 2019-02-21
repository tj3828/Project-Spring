<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <title>Profile</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		var chatScroll = "${cookie.chatScroll.value}";
		if(chatScroll == null || chatScroll =="") {
			$(window).scrollTop(0);
		} else {
			$(window).scrollTop(chatScroll);
		}
		
		
	});
	
	$(window).on('beforeunload', function() {
		var login = "${sessionScope.dto.id}";
		if(login == null || login == "") {
			return false;
		}
		document.cookie = "chatPage=" + escape(5) + "; path=/;";
		
		var currentScroll = $(document).scrollTop();
		document.cookie = "chatScroll=" + escape(currentScroll) + "; path=/;";
	});
</script>
<body>
  <header class="top-header top-header--transparent">
    <div class="header__top">
      <div class="header__column">
        <!-- plane icon -->
        <i class="fa fa-plane"></i>

        <!-- wifi icon -->
        <i class="fa fa-wifi"></i>

      </div>
      <div class="header__column">
        <span class="header__time">18:38</span>
      </div>
      <div class="header__column">
        <!-- moon icon -->
        <i class="fa fa-moon-o"></i>

        <!-- blue icon -->
        <i class="fa fa-bluetooth-b"></i>

        <span class="header__battery">66% <!-- battery icon --><i class="fa fa-battery-full"></i></span>
      </div>
    </div>
    <div class="header__bottom">
      <div class="header__column">
        <a href="javascript:location.replace('../chat/friend.do')">
          <i class="fa fa-times fa-lg"></i>
        </a>
      </div>
      <div class="header__column">
        <i class="fa fa-user fa-lg"></i>
      </div>
    </div>
  </header>
  <main class="profile">
    <header class="profile__header">
      <div class="profile__header-container">
        <img src="images/avatar.png" alt="">
        <h3 class="profile-header-title">Seungyong Lee</h3>
      </div>
    </header>
    <div class="profile__container">
      <input type="text" placeholder="bongbongco@gmail.com">
      <div class="profile__actions">
        <div class="profile__action">
          <span class="profile__action-circle">
            <i class="fa fa-comment fa-lg"></i>
          </span>
          <span class="profile__action-title">My Chatroom</span>
        </div>
        <div class="profile__action">
          <span class="profile__action-circle">
            <i class="fa fa-pencil fa-lg"></i>
          </span>
          <span class="profile__action-title">Edit Profile</span>
        </div>
      </div>
    </div>
  </main>
  <div class="bigScreenText">
    Please make your screen smaller
  </div>
</body>
</html>
