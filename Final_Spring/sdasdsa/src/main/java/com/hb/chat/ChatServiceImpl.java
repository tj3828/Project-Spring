package com.hb.chat;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Singleton;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.inject.Inject;
import com.google.inject.name.Named;

@Service
@Transactional
public class ChatServiceImpl implements IChatService {
	
	@Inject @Named("chatMapper")
	SqlSession sqlSession;

	@Autowired	// Inject 사용시 에러
	IChatDAOMapper chatDAOMapper;
	
	@Override
	public void insertMessage(ChatVO dto) {
		sqlSession.insert("insertMessage", dto);
		System.out.println("ㅎㅎ");
	}

	@Override
	public ArrayList<ChatVO> selectMessageList(String id, String opponent) {
		List<ChatVO> list = chatDAOMapper.selectMessageList(id, opponent);
		return (ArrayList<ChatVO>)list;
	}

	@Override
	public ArrayList<ChatVO> selectChatsList(String id) {
		return chatDAOMapper.selectChatsList(id);
	}
}
