package com.hb.faq;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import common.Paging;

@Service
@Transactional
public class FAQServiceImpl implements IFAQService {

	@Inject
	IFAQDAOMapper faqDAOMapper;
	@Inject
	ServletContext  application;
	
	@Override
	public void insertFAQWrite(FAQVO dto) {
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
		faqDAOMapper.insertFAQWrite(dto);
	}

	@Override
	public ArrayList<FAQVO> selectFAQList(Paging paging) {
		int totalCount = faqDAOMapper.selectListTotalCount(); 
		int searchCount =  faqDAOMapper.selectListSearchCount(paging); 
			  paging.setSearchCount(searchCount);
			  paging.setColPageNum(10); 
			  paging.setRowPageNum(3);
			  paging.setTotalCount(totalCount); 
			  paging.calulate();
		
		return faqDAOMapper.selectFAQList(paging);
	}

}
