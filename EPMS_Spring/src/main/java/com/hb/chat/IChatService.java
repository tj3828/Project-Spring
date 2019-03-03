package com.hb.chat;

import java.util.ArrayList;

import com.hb.account.AccountVO;
import com.hb.reservation.ReservationVO;

public interface IChatService {
	
	void insertMessage(ChatVO dto);
	ArrayList<ChatVO> selectMessageList(String id,String opponent);
	ArrayList<ChatVO> selectChatsList(String id);
	int selectNotReadCheck(AccountVO vo);
	void updateMessageRead(String nickname, String opponentNick);
	void deleteMessageAll(ChatVO dto);
	int selectChatUserSearch(String nickname);
	
	int selectReservationNotReadCheck(AccountVO vo);
	ArrayList<ReservationVO> selectReservationList(String nickname);
}
