package com.hb.chat;

import java.util.ArrayList;

import com.hb.account.AccountVO;

public interface IChatService {
	void insertMessage(ChatVO dto);
	ArrayList<ChatVO> selectMessageList(String id,String opponent);
	ArrayList<ChatVO> selectChatsList(String id);
	int selectNotReadCheck(AccountVO vo);
	
	void updateMessageRead(String nickname, String opponentNick);
	
}
