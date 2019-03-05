package com.hb.faq.detail;

import java.util.ArrayList;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hb.faq.FAQVO;
import com.hb.freeboard.FreeBoardVO;

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
	
	@GetMapping("/faqEditPre.do")
	public String showFAQEditPage(@ModelAttribute("vo") FAQVO dto) {
		faqDetailService.selectDetailInfo(dto);
		return "/faq/faqDetailEdit";
	}
	
	@ResponseBody
	@PostMapping(value="/faqEdit.do", produces="application/json; charset=utf-8")
	public int updateFAQEdit(@RequestPart("serialData") @Valid FAQVO dto, @RequestPart(value="file",required=false) MultipartFile file) {
		dto.setMultipartFile(file);
		faqDetailService.updateFAQEdit(dto);
		return dto.getNum();
	}
	
	@ResponseBody
	@PostMapping("/faqDelete.do")
	public void deleteFAQDetail(FAQVO dto) {
		faqDetailService.deleteFAQDetail(dto);
	}
}
