package com.hb.freeboard.detail;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.hb.freeboard.FreeBoardVO;

import config.Mapper;

@Mapper
public interface IBoardDetailDAOMapper {
	@Select("select a.*, b.profile_img from (" +
			"	select num, nickname, title,content, TO_CHAR(writeDate,'YYYY-MM-DD HH24:MI') as writeDate, upload_file, store_upload_file, round(upload_file_size/1024,1) as upload_file_size, viewCnt, likeCnt from freeboard where num = #{num}" +
			") a join account b on a.nickname = b.nickname")
	FreeBoardVO dbDetail(FreeBoardVO dto);
	
	@Update("update freeboard set viewCnt = viewCnt +1 where num = #{num}")
	void dbDetailCount(FreeBoardVO dto);
	
	@Update("update freeboard set title=#{title}, content=#{content}, upload_file=#{upload_file} where num = #{num}")
	void dbDetailEdit(FreeBoardVO dto);
	
	@Delete("delete from freeboard where num = #{num}")
	void dbDetailDelete(FreeBoardVO dto);
}
