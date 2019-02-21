
package com.hb.freeboard;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import common.Paging;
import config.Mapper;

@Mapper
public interface IBoardDAOMapper {
	
	@Select("select a.*, n.profile_img as profile_img, (select count(*) from freeboard_reply where a.num = fr_idx) as replyCnt from ( " +
			"	select rn, num, nickname, title,content, TO_CHAR(writeDate,'YYYY-MM-DD HH24:MI') as writeDate, upload_file, viewCnt, likeCnt from ( " + 
			" 	    select rownum as rn, h.* from " + 
			"   		( select  b.* from freeboard b where ${keyfield} like '%' || #{keyword} || '%' order by writedate asc) h" +
			" 	   )  where rn between  #{end} and #{start}  " +
			" )a join account n on a.nickname = n.nickname order by rn desc")
	List<FreeBoardVO> dbSelect(Paging paging);
	
	@Select("select count(*) from freeboard")
	int dbListAccount();
	
	@Select("select count(*) as cnt from freeboard where ${keyfield} like '%'||#{keyword}||'%'")
	int dbSearchAccount(Paging paging);
	
	@Insert("insert into freeboard values(freeboard_seq.nextval, #{nickname}, #{title}, #{content}, sysdate, #{upload_file}, #{store_upload_file}, #{upload_file_size}, 0, 0)")
	void dbInsert(FreeBoardVO dto);
	
	
	
	
	// Reply ===========================================================
	
}
