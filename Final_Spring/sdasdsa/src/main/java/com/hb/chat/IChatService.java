package com.hb.chat;

import java.util.ArrayList;

public interface IChatService {
	void insertMessage(ChatVO dto);
	ArrayList<ChatVO> selectMessageList(String id,String opponent);
	ArrayList<ChatVO> selectChatsList(String id);
}
