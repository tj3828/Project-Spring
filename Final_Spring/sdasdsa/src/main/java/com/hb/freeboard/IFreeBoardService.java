package com.hb.freeboard;

import java.util.List;

import common.Paging;

public interface IFreeBoardService {
	
	void board_write(FreeBoardVO dto);
	
	List<FreeBoardVO> board_list(Paging paging);
	
	
	// Reply ======================================================
	
}
