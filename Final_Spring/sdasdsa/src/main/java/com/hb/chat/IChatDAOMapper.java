package com.hb.chat;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import config.Mapper;

@Mapper
public interface IChatDAOMapper {
	
	@Insert("insert into chatting values("
			+ "chatting_seq.nextval, "
			+ "#{fromNick}, "
			+ "#{toNick},"
			+ "to_date(#{writeDate},'YY/MM/DD HH24:MI'),"
			+ "#{content},"
			+ "#{readCheck}"
			+ ")")
	void insertMessage(ChatVO dto);
	
	@Select("select * from chatting where fromNick = #{id} or toNick = #{id}")
	ArrayList<ChatVO> selectMessageList(@Param("id") String id);
}