package com.hb.faq.reply;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.SelectKey;

import com.hb.faq.FAQVO;

import config.Mapper;

@Mapper
public interface IFAQReplyDAOMapper {
	
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
	void insertFAQReplyWrite(FAQVO dto);
}
