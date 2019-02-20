package com.hb.chat.config;

import com.google.inject.AbstractModule;
import com.hb.chat.ChatServiceImpl;
import com.hb.chat.IChatService;

public class InjectConfig extends AbstractModule {
	
	// 의존 주입 설정
	@Override
	protected void configure() {
		
		bind(IChatService.class).to(ChatServiceImpl.class);
	}
}