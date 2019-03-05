package com.hb.faq.detail;

import java.util.ArrayList;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.faq.FAQVO;

@Service
@Transactional
public class FAQDetailServiceImpl implements IFAQDetailService{

	@Inject
	IFAQDetailDAOMapper faqDetailDAOMapper;
	
	@Override
	public ArrayList<FAQVO> selectFAQDetailWithchild(FAQVO dto) {
		return faqDetailDAOMapper.selectFAQDetailWithchild(dto);
	}

	@Override
	public void updateViewCount(FAQVO dto) {
		faqDetailDAOMapper.updateViewCount(dto);
	}
	
}
