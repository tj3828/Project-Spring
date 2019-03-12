package com.hb.chat.config;

import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator implements ApplicationContextAware {
	
private static volatile BeanFactory context; 
	
	@Override 
	public <T> T getEndpointInstance(Class<T> clazz) 
			throws InstantiationException { 
		return context.getBean(clazz); 
	} 
	
	@Override 
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException { 
		HttpSessionConfigurator.context = applicationContext; 
	}
	
	@Override
    public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
        sec.getUserProperties().put("http", request.getHttpSession()); 
    }

}