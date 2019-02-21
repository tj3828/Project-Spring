package com.hb.chat;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.inject.Inject;
import com.google.inject.name.Named;

@Service
@Transactional
public class ChatServiceImpl implements IChatService {
	
	@Inject @Named("chatMapper")
	SqlSession sqlSession;

	/*@javax.inject.Inject
	IChatDAOMapper chatDAOMapper;*/
	
	@Override
	public void insertMessage(ChatVO dto) {
		sqlSession.insert("insertMessage", dto);
		System.out.println("ㅎㅎ");
	}

	@Override
	public ArrayList<ChatVO> selectMessageList(String id) {
		List<ChatVO> list = sqlSession.selectList("selectMessageList",id);
		return (ArrayList<ChatVO>)list;
	}
}
