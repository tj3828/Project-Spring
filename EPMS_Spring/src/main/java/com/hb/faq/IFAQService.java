package com.hb.faq;

import java.util.ArrayList;

import common.Paging;

public interface IFAQService {
	void insertFAQWrite(FAQVO vo);
	ArrayList<FAQVO> selectFAQList(Paging paging);
}
