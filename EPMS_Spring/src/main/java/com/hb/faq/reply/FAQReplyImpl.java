package com.hb.faq.reply;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.faq.FAQVO;

@Service
@Transactional
public class FAQReplyImpl implements IFAQReplyService{

	@Inject
	IFAQReplyDAOMapper faqReplyDAOMapper;
	
	@Override
	public void insertFAQReplyWrite(FAQVO dto) {
		faqReplyDAOMapper.insertFAQReplyWrite(dto);
	}

}
