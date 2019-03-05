package com.hb.faq.detail;

import java.util.ArrayList;

import com.hb.faq.FAQVO;

public interface IFAQDetailService {
	
	ArrayList<FAQVO> selectFAQDetailWithchild(FAQVO dto);
	void updateViewCount(FAQVO dto);
}
