package com.hb.faq.detail;

import java.util.ArrayList;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hb.faq.FAQVO;

@Controller
@RequestMapping("/faqDetail")
public class FAQDetailController {

	@Inject
	IFAQDetailService faqDetailService;
	
	@GetMapping("/faqDetail.do")
	public String showFAQDetailPage(FAQVO dto, Model model) {
		ArrayList<FAQVO> list = faqDetailService.selectFAQDetailWithchild(dto);
		faqDetailService.updateViewCount(dto);
		
		model.addAttribute("list", list);
		
		return "/faq/faqDetail";
	}
}
