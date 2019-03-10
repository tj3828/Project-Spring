package com.hb.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CommonException {
	
	@ExceptionHandler(Exception.class)
	public String handlerException(Exception ex){
		
		return "/erroPage/500";
	}
	
}