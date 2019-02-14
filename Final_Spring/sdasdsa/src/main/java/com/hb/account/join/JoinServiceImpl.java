package com.hb.account.join;

import java.io.File;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.account.AccountVO;

@Service
@Transactional
public class JoinServiceImpl implements IJoinService {
	
	@Inject
	IJoinDAOMapper joinDAOMapper;
	@Inject
	ServletContext application;
	
	@Override
	public int checkId(AccountVO dto) {
		return joinDAOMapper.checkId(dto);
	}

	@Override
	public int checkNick(AccountVO dto) {
		return joinDAOMapper.checkNick(dto);
	}
	
	@Override
	public void join(AccountVO dto) {
		if(dto.getMultipartFile() != null && dto.getMultipartFile().getOriginalFilename().trim().equals(dto.getProfile_img().trim())) {
			String path=application.getRealPath("/resources/upload");
			String img=dto.getMultipartFile().getOriginalFilename();
			
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String extension = img.substring(img.lastIndexOf("."));
			
			String filename = uuid + extension;
			
			File file = new File(path, filename);
			System.out.println(file + " / " + img);
			try{
				dto.getMultipartFile().transferTo(file);
			}catch(Exception ex){
				System.out.println("FreeBoardController write()");
			}
			dto.setProfile_img(filename);
		}
		joinDAOMapper.join(dto); 
	}
}
