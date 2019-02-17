<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="../resources/chat/css/styles.css">
  <script src="../resources/js/jquery-3.3.1.min.js"></script>
  <title>Chat</title>
</head>
<body class="body-chat" style="padding-top: 48px;">
  <header class="top-header chat-header">
    <div class="header__bottom">
      <div class="header__column">
        <a href="../chat/chats.do">
          <i class="fa fa-chevron-left fa-lg"></i>
        </a>
      </div>
      <div class="header__column">
        <span class="header__text">Friends</span>
        <span class="header__number">1</span>
      </div>
      <div class="header__column">
      </div>
    </div>
  </header>
<main class="chat">
  <div class="date-divider">
    <span class="date-divider__text">Wednesday, August 2, 2017</span>
  </div>
  <div class="chat__message chat__message-from-me">
    <span class="chat__message-time">17:55</span>
    <span class="chat__message-body">
      Hello! This is a test message.
    </span>
  </div>
  <div class="chat__message chat__message-to-me">
    <img src="../resources/chat/images/avatar.png" alt="" class="chat-message-avatar">
    <div class="chat__message-center">
      <h3 class="chat__message-username">LYNN</h3>
      <span class="chat__message-body">
        And this is an answer.
      </span>
    </div>
    <span class="chat__message-time">19:35</span>
  </div>
</main>
<div class="type-message">
  <i class="fa fa-plus fa-lg"></i>
  <div class="type-message__input">
    <input type="text">
    <i class="fa fa-smile-o fa-lg"></i>
    <span class="record-message">
      <i class="fa fa-microphone fa-lg"></i>
    </span>
  </div>
</div>
<div class="bigScreenText">
  Please make your screen smaller
</div>
</body>
</html>
