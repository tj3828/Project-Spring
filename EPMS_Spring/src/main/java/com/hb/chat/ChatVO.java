package com.hb.chat;

import lombok.Data;

@Data
public class ChatVO {
	private int num;
	private String messageType;
	private String fromNick;
	private String fromNick_profileImg;
	private String toNick;
	private String toNick_profileImg;
	private String writeDate;
	private String content;
	private int readCheck;
	// 채팅방 목록에서 쓰기 위한 변수
	private int notReadCheck;
}
