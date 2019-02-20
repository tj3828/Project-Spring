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
	
	@Select("select num, fromNick, toNick, to_char(writeDate,'YY/MM/DD HH24:MI') as writeDate, content, readCheck from ( "
			+ 	"select * from chatting "
			+ 		"where (fromNick = #{id} and toNick = #{opponent}) or (fromNick = #{opponent} and toNick = #{id}) "
			+ ") order by num asc")
	ArrayList<ChatVO> selectMessageList(@Param("id") String id, @Param("opponent") String opponent);
	
	@Select("select b.num, b.fromNick, b.toNick, to_char(b.writeDate,'YY/MM/DD HH24:MI') as writeDate, b.content, b.readCheck " + 
			"from ( " + 
			"    select Max(num) as num " + 
			"    from ( " + 
			"        select " + 
			"			case when fromNick >= toNick then CONCAT(fromNick,toNick) "	+ 
			"				 else CONCAT(toNick,fromNick) "	+ 
			"			end as dualNick, MAX(num) as num " + 
			"        from chatting " + 
			"        group by fromNick, toNick " + 
			"        having fromNick = #{id} or toNick = #{id}) " + 
			"    group by dualNick ) a " + 
			"inner join chatting b " + 
			"on a.num = b.num " +
			"order by b.num desc ")
	ArrayList<ChatVO> selectChatsList(@Param("id") String id);
}
