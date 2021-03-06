package com.hb.freeboard;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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

import com.hb.freeboard.reply.IFreeBoardReplyService;

import common.Paging;

@Controller
@RequestMapping(value="/freeboard",method= {RequestMethod.GET,RequestMethod.POST})
public class FreeBoardController {
	
	@Inject
	IFreeBoardService freeboardservice;
	@Inject
	IFreeBoardReplyService replyservice;
	@Inject
	private ServletContext application;
	
	@GetMapping("/freeboard.do")
	public String showFreeboardPage(Model model,Paging paging) {
		List<FreeBoardVO> list = freeboardservice.board_list(paging);
		model.addAttribute("list", list);
		return "/freeboard/freeboard";
	}
	
	@ResponseBody
	@PostMapping(value="/write.do", produces="application/json; charset=utf-8")
	public void write(@RequestPart("serialData") @Valid FreeBoardVO dto, @RequestPart(value="file",required=false) MultipartFile file) {
		dto.setMultipartFile(file);
		freeboardservice.board_write(dto);
	}
	
	@ResponseBody
	@PostMapping(value="/imageUpload.do")
	public String imageUpload(HttpServletRequest request ) {
		 // 파일정보
        StringBuffer sb = new StringBuffer();
        try {
            // 파일명을 받는다 - 일반 원본파일명
            String oldName = request.getHeader("file-name");
            // 파일 기본경로 _ 상세경로
            String filePath = application.getRealPath("/resources/photoUpload/");
            String saveName = sb.append(new SimpleDateFormat("yyyyMMddHHmmss")
                          .format(System.currentTimeMillis()))
                          .append(UUID.randomUUID().toString())
                          .append(oldName.substring(oldName.lastIndexOf("."))).toString();
            InputStream is = request.getInputStream();
            OutputStream os = new FileOutputStream(filePath + saveName);
            int numRead;
            byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
            while ((numRead = is.read(b, 0, b.length)) != -1) {
                os.write(b, 0, numRead);
            }
            os.flush();
            os.close();
            
            sb = new StringBuffer();
            sb.append("&bNewLine=true")
              .append("&sFileName=").append(oldName)
              .append("&sFileURL=").append(request.getContextPath() + "/resources/photoUpload/")
        .append(saveName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();
	}
	
}
