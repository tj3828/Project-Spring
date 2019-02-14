package com.hb.freeboard;


import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FreeBoardVO {

	private int rn;
	private int num;
	@NotBlank
	private String nickname;
	@NotBlank 
	@Length(max=30)
	private String title;
	@NotBlank
	@Length(max=300)
	private String content;
	private String writeDate;
	private String upload_file="";
	private String store_upload_file="";
	private MultipartFile multipartFile;
	private Long upload_file_size;
	private int viewCnt=0;
	private String profile_img;
	private int replyCnt =0;
	private int likeCnt = 0;
		
}
