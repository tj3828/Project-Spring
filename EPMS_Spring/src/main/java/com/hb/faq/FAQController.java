package com.hb.faq;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Paging;

@Controller
@RequestMapping("/faq")
public class FAQController {
	
	@Inject
	IFAQService faqService;
	
	@GetMapping("/faq.do")
	public String showFAQPage(Paging paging, Model model) {
		ArrayList<FAQVO> list = faqService.selectFAQList(paging);
		model.addAttribute("list", list);
		return "/faq/faq";
	}
	
	@GetMapping("/faqWritePre.do")
	public String showFAQWritePage() {
		return "/faq/faqWrite";
	}
	
	@ResponseBody
	@PostMapping(value="/faqWrite.do", produces="application/json; charset=utf-8")
	public int insertFAQWrite(@RequestPart("serialData") @Valid FAQVO dto, @RequestPart(value="file",required=false) MultipartFile file) {
		dto.setMultipartFile(file);
		faqService.insertFAQWrite(dto);
		return dto.getNum();
	}
}
