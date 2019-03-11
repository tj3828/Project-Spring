package com.hb.account.autoLogout;

import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Controller;

import com.hb.account.AccountVO;
import com.hb.account.login.ILoginService;
import com.hb.chat.config.HttpSessionConfigurator;

@Controller
@ServerEndpoint(value="/wsAutoLogout",configurator= HttpSessionConfigurator.class)
public class AutoLogoutWebSocket {
	
	@Inject
	ILoginService iLoginService;
	
	private static final Map<String,Thread> sessions = new ConcurrentHashMap<String,Thread>();
	
	private Thread th;
	private String httpId;
	@OnOpen
	public void onOpen(final Session session, EndpointConfig config) {
		HttpSession httpSession = (HttpSession)config.getUserProperties().get("http");
		httpId = ((AccountVO)httpSession.getAttribute("dto")).getId();
		th = new Thread(new Runnable() {
			String id = httpId;
			@Override
			public void run() {
				try {
					Thread.sleep(5000);
					iLoginService.logout(id);
					sessions.remove(id);
					System.out.println("자동로그아웃 실행 : " + id);
				} catch(Exception e) {}
			}
		});
		
		if(sessions.containsKey(httpId)) {
			sessions.get(httpId).interrupt();
			System.out.println("자동로그아웃 재연결");
		}
		
		sessions.put(httpId, th);
		System.out.println("자동로그아웃 체크");
	}
	
	@OnError
	public void onError(Throwable t) {
		System.out.println("자동로그아웃 웹소켓 오류"); 
	}
	
	@OnClose
	public void onClose(Session session) {
		synchronized (sessions) {
			for(Iterator<String> ss = sessions.keySet().iterator(); ss.hasNext();) {
				try {
					String sss = ss.next();
					System.out.println("자동로그아웃 쓰레드 검색");
					if(sss == httpId) {
						sessions.get(sss).start();		
					}
				} catch (Exception e) {
					System.out.println("자동로그아웃 쓰레드 오류");
				}
			}
		}
		System.out.println("=================== webSocket 닫힘 ===================");
	}
	
 }