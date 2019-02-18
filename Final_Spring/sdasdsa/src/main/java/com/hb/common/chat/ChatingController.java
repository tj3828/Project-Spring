package com.hb.common.chat;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.inject.Singleton;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;

@ServerEndpoint(value="/ws",encoders=ChatEncoder.class)
@Controller
@Singleton
public class ChatingController {
	
	private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen(Session session) {
		System.out.println("websocket 연결 : " + session.getId());
		
		try {
			final Basic basic = session.getBasicRemote();
			ChatVO vo = new ChatVO();
			vo.setFromNick("me");
			vo.setToNick("you");
			vo.setContent("안녕하세요! 연결완료!가나다라마바사아자차카타파하");
			vo.setReadCheck(false);
			vo.setWriteDate(new SimpleDateFormat("yy/MM/dd HH:mm").format(new Date()));
			session.getBasicRemote().sendObject(vo);
			sessions.add(session);
		}catch (Exception e) {
			System.out.println(e.toString());
			System.out.println(e.getMessage());
			System.out.println("연결 오류");
		}
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {
		System.out.println("from : " + session.getId() + ", 내용 : " + message);
		try{
			Basic basic = session.getBasicRemote();
			ChatVO vo = new ChatVO();
			vo.setFromNick("me");
			vo.setToNick("you");
			vo.setReadCheck(false);
			vo.setWriteDate(new SimpleDateFormat("yy/MM/dd HH:mm").format(new Date()));
			vo.setContent(message);
			sendMessage(session, vo);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
	}
	
	@OnError
	public void onError(Throwable t) {
		t.printStackTrace();
	}
	
	@OnClose
	public void onClose(Session session) {
		System.out.println("종료 : " + session.getId());
		sessions.remove(session);
	}
	
	public void sendMessage(Session session, ChatVO vo) {
		try {
			for(Session s : sessions) {
				if(!s.getId().equals(session.getId())) {
					//s.getBasicRemote().sendObject(vo);
				}
				s.getBasicRemote().sendObject(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
 }











