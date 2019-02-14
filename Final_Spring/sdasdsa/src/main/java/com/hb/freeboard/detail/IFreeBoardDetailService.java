package com.hb.freeboard.detail;

import com.hb.freeboard.FreeBoardVO;

public interface IFreeBoardDetailService {
	FreeBoardVO board_detail(FreeBoardVO dto);
	
	void board_DetailEdit(FreeBoardVO dto);
	
	void board_DetailCount(FreeBoardVO dto);
	
	void board_DetailDelete(FreeBoardVO dto);
		
}
