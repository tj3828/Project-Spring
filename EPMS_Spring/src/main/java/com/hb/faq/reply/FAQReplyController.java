package com.hb.faq.reply;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hb.faq.FAQVO;

@Controller
@RequestMapping("/faqReply")
public class FAQReplyController {
	
	@Inject
	IFAQReplyService faqReplyService;

	@GetMapping("/faqReplyPre.do")
	public String showFAQReplyPage(@ModelAttribute("vo") FAQVO dto) {
		return "/faq/faqReplyWrite";
	}
	
	@ResponseBody
	@PostMapping(value="/faqReply.do", produces="application/json; charset=utf-8")
	public int insertFAQReply(@RequestPart("serialData") @Valid FAQVO dto, @RequestPart(value="file",required=false) MultipartFile file) {
		dto.setMultipartFile(file);
		faqReplyService.insertFAQReplyWrite(dto);
		return dto.getNum();
	}
}
