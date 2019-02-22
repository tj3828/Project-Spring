package com.hb.freeboard.reply;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.freeboard.FreeBoardVO;

import common.Paging;

@Service
@Transactional
public class FreeBoardReplyServiceImpl implements IFreeBoardReplyService {
	@Inject 
	IBoardReplyDAOMapper iBoardReplyDAOMapper;
	@Override
	public void board_ReplyWrite(FreeBoard_ReplyVO rdto) {
		iBoardReplyDAOMapper.dbReplyInsert(rdto);
	}

	@Override
	public void board_ReplyDelete(FreeBoard_ReplyVO rdto) {
		iBoardReplyDAOMapper.dbReplyDelete(rdto);
	}

	@Override
	public void board_ReplyEdit(FreeBoard_ReplyVO rdto) {
		iBoardReplyDAOMapper.dbReplyUpdate(rdto);
	}
	
	@Override
	public List<FreeBoard_ReplyVO> board_Rdetail(FreeBoardVO dto, Paging paging) {
		int totalCount = iBoardReplyDAOMapper.dbReplySelect(dto); 
		int searchCount =  totalCount; 
			paging.setSearchCount(searchCount);
			paging.setColPageNum(5); 
			paging.setRowPageNum(3);
			paging.setTotalCount(totalCount); 
			paging.calulate();
			System.out.println(totalCount + " / " + searchCount + " / " + paging.getStart() +  " / " + paging.getEnd());
		return iBoardReplyDAOMapper.dbDetailReply(dto,paging);
	}
}
