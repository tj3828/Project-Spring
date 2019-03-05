package com.hb.faq.detail;

import java.util.ArrayList;

import com.hb.faq.FAQVO;

public interface IFAQDetailService {
	
	ArrayList<FAQVO> selectFAQDetailWithchild(FAQVO dto);
	void updateViewCount(FAQVO dto);
	void selectDetailInfo(FAQVO dto);
	void updateFAQEdit(FAQVO dto);
	void deleteFAQDetail(FAQVO dto);
}
