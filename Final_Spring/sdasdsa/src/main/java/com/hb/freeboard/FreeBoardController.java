package com.hb.freeboard;

import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hb.freeboard.reply.IFreeBoardReplyService;

import common.Paging;

@Controller
@RequestMapping("/freeboard")
public class FreeBoardController {
	
	@Inject
	IFreeBoardService freeboardservice;
	@Inject
	IFreeBoardReplyService replyservice;
	
	@GetMapping("/freeboard.do")
	public String showFreeboardPage(Model model,Paging paging) {
		List<FreeBoardVO> list = freeboardservice.board_list(paging);
		model.addAttribute("list", list);
		return "/freeboard/freeboard";
	}
	
	@ResponseBody
	@PostMapping("/write.do")
	public void write(@Valid FreeBoardVO dto){
		freeboardservice.board_write(dto);
	}
	
	
	// Reply ===================================================
	
}
