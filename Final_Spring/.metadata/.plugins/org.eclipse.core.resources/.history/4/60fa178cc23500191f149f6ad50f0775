package com.hb.freeboard.detail;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hb.freeboard.FreeBoardVO;
import com.hb.freeboard.like.ILikeService;
import com.hb.freeboard.like.LikeVO;
import com.hb.freeboard.reply.FreeBoard_ReplyVO;
import com.hb.freeboard.reply.IFreeBoardReplyService;

import common.Paging;

@Controller
@RequestMapping(value="/freeboardDetail",method= {RequestMethod.GET,RequestMethod.POST})
public class FreeBoardDetailController {
	
	@Inject
	ILikeService likeservice;
	@Inject
	IFreeBoardDetailService datailService;
	@Inject
	IFreeBoardReplyService replyService;
	@Inject
	private ServletContext  application;
	
	@GetMapping("/editPre.do")
	public String showEditPrePage(FreeBoardVO dto, Model model) {
		dto = datailService.board_detail(dto);
		model.addAttribute("dto", dto);
		return "/freeboard/freeboardDetailEdit";
	}
	
	@ResponseBody
	@PostMapping(value="/edit.do", produces="application/json; charset=utf-8")
	public void edit(@RequestPart("serialData") @Valid FreeBoardVO dto, @RequestPart(value="file",required=false) MultipartFile file) {
		dto.setMultipartFile(file);
		datailService.board_DetailEdit(dto);
	}
	
	@ResponseBody
	@PostMapping("/delete.do")
	public void delete(FreeBoardVO dto) {
		datailService.board_DetailDelete(dto);
	}
	
	@GetMapping("/detail.do")
	public String showFreeboardDetailPage(Model model, FreeBoardVO dto, Paging paging, HttpSession session) {
		dto = datailService.board_detail(dto);
		datailService.board_DetailCount(dto);
		List<FreeBoard_ReplyVO> list = replyService.board_Rdetail(dto, paging);
		String id = (String)session.getAttribute("id");
		int checked = 1;
		if(id != null) {
			LikeVO ldto = new LikeVO();
			ldto.setFr_idx(dto.getNum());
			ldto.setId((String)session.getAttribute("id"));
			checked = likeservice.checkLike(ldto);
		}
		model.addAttribute("checkLike",checked);
		model.addAttribute("list", list);
		model.addAttribute("dto",dto);
		return "/freeboard/freeboardDetail";
	}
	
	@GetMapping("/download.do")
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
	  
		return "redirect:/freeboardDetail/detail.do?num="+data;
	  }//end
}
