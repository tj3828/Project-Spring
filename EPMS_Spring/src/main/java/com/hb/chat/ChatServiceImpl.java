package com.hb.chat;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.account.AccountVO;
import com.hb.reservation.IReservationDAOMapper;
import com.hb.reservation.ReservationVO;

@Service
@Transactional
public class ChatServiceImpl implements IChatService {

	@Inject
	IChatDAOMapper chatDAOMapper;
	
	@Inject
	IReservationDAOMapper reservationDAOMapper;
	
	@Override
	public void insertMessage(ChatVO dto) {
		chatDAOMapper.insertMessage(dto);
	}

	@Override
	public ArrayList<ChatVO> selectMessageList(String id, String opponent) {
		chatDAOMapper.updateMessageRead(id, opponent);
		List<ChatVO> list = chatDAOMapper.selectMessageList(id, opponent);
		return (ArrayList<ChatVO>)list;
	}

	@Override
	public ArrayList<ChatVO> selectChatsList(String id) {
		return chatDAOMapper.selectChatsList(id);
	}

	@Override
	public void updateMessageRead(String nickname, String opponentNick) {
		chatDAOMapper.updateMessageRead(nickname, opponentNick);
	}

	@Override
	public int selectNotReadCheck(AccountVO vo) {
		return chatDAOMapper.selectNotReadCheck(vo);
	}

	@Override
	public void deleteMessageAll(ChatVO dto) {
		chatDAOMapper.deleteMessageAll(dto);
	}

	@Override
	public int selectChatUserSearch(String nickname) {
		return chatDAOMapper.selectChatUserSearch(nickname);
	}

	@Override
	public int selectReservationNotReadCheck(AccountVO vo) {
		return reservationDAOMapper.selectReservationNotReadCheck(vo);
	}

	@Override
	public ArrayList<ReservationVO> selectReservationList(String nickname) {
		return reservationDAOMapper.selectReservationList(nickname);
	}
}
