package com.hb.freeboard.reply;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.hb.freeboard.FreeBoardVO;

import common.Paging;
import config.Mapper;

@Mapper
public interface IBoardReplyDAOMapper {
	@Select("select a.*, b.profile_img from ( " +
			"	select rn, num, nickname, content, TO_CHAR(writeDate,'YYYY-MM-DD HH24:MI') as writeDate, fr_idx from  (" +  
			"		select rownum as rn, h.* from " +
			"			( select * from freeboard_reply where fr_idx = #{dto.num} order by writedate asc) h"	+ 
			"		) where rn between #{paging.end} and #{paging.start} " + 
			") a join account b on a.nickname = b.nickname order by rn desc" )
	List<FreeBoard_ReplyVO> dbDetailReply(@Param("dto") FreeBoardVO dto, @Param("paging") Paging paging);
	
	@Insert("insert into freeboard_reply values(freeboard_reply_seq.nextval, #{nickname}, #{content}, sysdate, #{fr_idx})")
	void dbReplyInsert(FreeBoard_ReplyVO rdto);
	
	@Select("select count(*) from freeboard_reply where fr_idx=#{num}")
	int dbReplySelect(FreeBoardVO dto);
	
	@Delete("delete from freeboard_reply where fr_idx = #{fr_idx} and num = #{num}")
	void dbReplyDelete(FreeBoard_ReplyVO rdto);
	
	@Update("update freeboard_reply set content = #{content} where fr_idx = #{fr_idx} and num = #{num} ")
	void dbReplyUpdate(FreeBoard_ReplyVO rdto);
}
