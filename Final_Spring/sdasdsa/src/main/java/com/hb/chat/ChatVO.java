package com.hb.chat;

import lombok.Data;

@Data
public class ChatVO {
	private int num;
	private String fromNick;
	private String toNick;
	private String writeDate;
	private String content;
	private boolean readCheck;
}
