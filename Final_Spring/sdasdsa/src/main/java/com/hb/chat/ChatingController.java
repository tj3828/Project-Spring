package com.hb.chat;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.hb.chat.config.ChatEncoder;
import com.hb.chat.config.ChatMybatisConfigModule;
import com.hb.chat.config.HttpSessionConfigurator;
import com.hb.chat.config.InjectConfig;

@ServerEndpoint(value="/ws",encoders=ChatEncoder.class,configurator=HttpSessionConfigurator.class)
public class ChatingController {
	
	Injector ij = Guice.createInjector(new InjectConfig(), new ChatMybatisConfigModule());
	IChatService chatService = ij.getInstance(ChatServiceImpl.class);
		
	private static final Map<String, Session> sessions = Collections.synchronizedMap(new HashMap<String,Session>());
	
	@OnOpen
	public void onOpen(Session session, EndpointConfig config) {
		HttpSession httpSession = (HttpSession)config.getUserProperties().get("http");
		String nickname = (String)httpSession.getAttribute("id");
		System.out.println("websocket 연결 : " + nickname);
		
		try {
			sessions.put(nickname,session);
		}catch (Exception e) {
			System.out.println(e.toString());
			System.out.println(e.getMessage());
			System.out.println("연결 오류");
		}
	}
	
	@OnMessage
	public void onMessage(String message, Session session){
		ChatVO vo = parseMessage(message);
		System.out.println("from : " + session.getId() + ", 내용 : " + vo.getContent());
		chatService.insertMessage(vo);
		try{
			sendMessage(session, vo);
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
	
	@OnError
	public void onError(Throwable t) {
		t.printStackTrace(); 
	}
	
	@OnClose
	public void onClose(Session session) {
		for(String s : sessions.keySet()) {
			if(sessions.get(s).getId() == session.getId()) {
				sessions.remove(s);				
			}
		}
	}
	
	public void sendMessage(Session session, ChatVO vo) {
		try {
			for(String s : sessions.keySet()) {
				if(s.equals(vo.getFromNick()) || s.equals(vo.getToNick())) {
					sessions.get(s).getBasicRemote().sendObject(vo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ChatVO parseMessage(String message) {
		JSONParser paser = new JSONParser();
		ChatVO vo = new ChatVO();
		System.out.println(message);
		try {
			JSONObject json = (JSONObject) paser.parse(message);
			System.out.println(json.get("fromNick"));
			vo.setFromNick((String)json.get("fromNick"));
			vo.setToNick((String)json.get("toNick"));
			String content = (String)json.get("content");
			content = content.replaceAll("\n", "<br>");
			vo.setContent(content);
			vo.setReadCheck(Boolean.parseBoolean((String)json.get("readCheck")));
			vo.setWriteDate(new SimpleDateFormat("yy/MM/dd HH:mm").format(new Date()));
		} catch (ParseException e) {
			System.out.println(e.toString());
		}
		
		return vo;
	}
 }