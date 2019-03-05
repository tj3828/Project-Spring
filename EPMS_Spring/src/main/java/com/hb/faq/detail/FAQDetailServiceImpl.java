package com.hb.faq.detail;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.faq.FAQVO;

@Service
@Transactional
public class FAQDetailServiceImpl implements IFAQDetailService{

	@Inject
	IFAQDetailDAOMapper faqDetailDAOMapper;
	@Inject
	ServletContext application;
	
	@Override
	public ArrayList<FAQVO> selectFAQDetailWithchild(FAQVO dto) {
		return faqDetailDAOMapper.selectFAQDetailWithchild(dto);
	}

	@Override
	public void updateViewCount(FAQVO dto) {
		faqDetailDAOMapper.updateViewCount(dto);
	}

	@Override
	public void selectDetailInfo(FAQVO dto) {
		faqDetailDAOMapper.selectDetailInfo(dto);
	}

	@Override
	public void updateFAQEdit(FAQVO dto) {
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
				System.out.println("FreeBoardController write()");
			}
			dto.setUpload_file(img);
			dto.setStore_upload_file(filename);
			dto.setUpload_file_size(dto.getMultipartFile().getSize());
		} else {
			dto.setUpload_file("");
			dto.setStore_upload_file("");
			dto.setUpload_file_size((long)0.0);
		}
		faqDetailDAOMapper.updateFAQEdit(dto);
	}

	@Override
	public void deleteFAQDetail(FAQVO dto) {
		faqDetailDAOMapper.deleteFAQDetail(dto);
	}
	
}
