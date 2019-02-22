package com.hb.freeboard.reply;

import java.util.List;

import com.hb.freeboard.FreeBoardVO;

import common.Paging;

public interface IFreeBoardReplyService {
	void board_ReplyWrite(FreeBoard_ReplyVO rdto);
	void board_ReplyDelete(FreeBoard_ReplyVO rdto);
	void board_ReplyEdit(FreeBoard_ReplyVO rdto);
	List<FreeBoard_ReplyVO> board_Rdetail(FreeBoardVO dto, Paging paging);
}
