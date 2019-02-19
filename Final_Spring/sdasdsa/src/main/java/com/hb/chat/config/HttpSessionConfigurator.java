package com.hb.chat.config;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;


public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator {

	@Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        System.out.println("modifyHandshake() Current thread " + Thread.currentThread().getName());
        sec.getUserProperties().put("http", request.getHttpSession()); 
        System.out.println("modifyHandshake() User " + "http" + " with http session ID " + ((HttpSession) request.getHttpSession()).getId());
    }

}