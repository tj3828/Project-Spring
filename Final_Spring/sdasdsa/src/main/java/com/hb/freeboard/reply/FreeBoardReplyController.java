package com.hb.freeboard.reply;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/freeboardReply")
public class FreeBoardReplyController {
	
	@Inject
	IFreeBoardReplyService replyservice;
	
	@PostMapping("/replySave.do")
	public void board_ReplyWrite(@Valid FreeBoard_ReplyVO rdto) {
		replyservice.board_ReplyWrite(rdto);
	}
	
	@PostMapping("/replyDelete.do")
	public void board_ReplyDelete(FreeBoard_ReplyVO rdto) {
		replyservice.board_ReplyDelete(rdto);
	}
	
	@PostMapping("/replyEdit.do")
	public void board_ReplyEdit(@Valid FreeBoard_ReplyVO rdto) {
		replyservice.board_ReplyEdit(rdto);
	}
}
