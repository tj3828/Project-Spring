package com.hb.faq.reply;

import java.io.File;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.faq.FAQVO;

@Service
@Transactional
public class FAQReplyServiceImpl implements IFAQReplyService{

	@Inject
	IFAQReplyDAOMapper faqReplyDAOMapper;
	@Inject
	ServletContext  application;
	@Override
	public void insertFAQReplyWrite(FAQVO dto) {
		if(dto.getMultipartFile() != null && !dto.getMultipartFile().isEmpty()) {
			String path=application.getRealPath("/resources/upload");
			String img=dto.getMultipartFile().getOriginalFilename();
			
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String extension = img.substring(img.lastIndexOf("."));
			
			String filename = uuid + extension;
			File temp = new File(path);
			if(!temp.exists()) {
				temp.mkdirs();
			}
			File file = new File(path, filename);
			System.out.println(file + " / " + img);
			try{
				dto.getMultipartFile().transferTo(file);
			}catch(Exception ex){
				System.out.println("FreeBoardDetailController write()");
			}
			dto.setUpload_file(img);
			dto.setStore_upload_file(filename);
			dto.setUpload_file_size(dto.getMultipartFile().getSize());
		} else {
			dto.setUpload_file("");
			dto.setStore_upload_file("");
			dto.setUpload_file_size((long)0.0);
		}
		faqReplyDAOMapper.insertFAQReplyWrite(dto);
	}

}
