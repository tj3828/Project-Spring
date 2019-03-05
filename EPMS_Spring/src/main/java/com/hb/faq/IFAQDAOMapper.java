package com.hb.faq;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import common.Paging;
import config.Mapper;

@Mapper
public interface IFAQDAOMapper {
	
	@Insert("insert into faqboard "	+ 
			"values ( "	+ 
			"	faqboard_seq.nextval, "	+ 
			"	#{nickname}, " + 
			"	#{profile_img}, " +
			"   #{title}, " +
			"	#{content}, " +
			"	sysdate, " +
			"	#{upload_file}, " +
			"	#{store_upload_file}, " +
			"   #{upload_file_size}, " +
			"   0, " + 
			"   #{parentNum}, " +
			"   case when #{parentNum} = 0 then faqboard_seq.nextval " +
			"	 	 else #{groupNum} end )"	)
	@SelectKey(statement="select faqboard_seq.currval as num from dual", before=false, keyProperty="num", resultType=FAQVO.class)
	void insertFAQWrite(FAQVO vo);
	
	@Select("select count(*) from faqboard")
	int selectListTotalCount();
	
	@Select("select count(*) as cnt from faqboard where ${keyfield} like '%'||#{keyword}||'%'")
	int selectListSearchCount(Paging paging);
	
	@Select("select * from ( "
			+ "select rownum as rn, q.*, (select count(*) from faqboard where parentNum = q.num) as childCnt from ( " +
			"	select num, nickname,profile_img, title, content, TO_CHAR(writeDate,'YYYY-MM-DD HH24:MI') as writeDate, upload_file, viewCnt, parentNum, groupNum, lev as lev from ( " + 
			" 	    select  rownum as rn, h.* from " + 
			"   		( select  b.*, level as lev from (select * from (select  a.* from faqboard a ) order by num asc) b where ${keyfield} like '%' || #{keyword} || '%' " + 
			"			  start with b.parentNum = 0 " + 
			"			  connect by prior b.num = b.parentNum " + 
			"			  order siblings by b.groupNum desc) h " +
			" 	) order by rn desc " + 
			" ) q ) where rn between #{end} and #{start} order by rn desc ")
	ArrayList<FAQVO> selectFAQList(Paging paging);
}
