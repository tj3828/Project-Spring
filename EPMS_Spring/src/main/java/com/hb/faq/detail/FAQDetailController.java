package com.hb.faq.detail;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
	@Inject
	private ServletContext  application;
	
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
	
	@GetMapping("/faqDownload.do")
	public String board_download(HttpServletRequest request, HttpServletResponse response) {
		String data="";		
		try {	
			String filename=request.getParameter("fidx");
			String storename=request.getParameter("sidx");
			data=request.getParameter("idx");
			String path=application.getRealPath("/resources/upload");
 
			response.setHeader("Content-Disposition", "attachment;filename="+filename);
			File file=new File(path,storename);
	 
			InputStream is=new FileInputStream(file);
			OutputStream os=response.getOutputStream();
			byte[] b=new byte[(int)file.length()];
	
			is.read(b,0,b.length);
			os.write(b);
			is.close(); 
			os.close(); 
	  } catch(Exception ex) {
		  	System.out.println(ex);
	  }
	  
		return "redirect:/faqDetail/faqDetail.do?num="+data;
	  }//end
}
