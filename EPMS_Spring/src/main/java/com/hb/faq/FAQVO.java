package com.hb.faq;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FAQVO {
	
	private int rn;
	private int num;
	@NotBlank(message="로그인해주세요.")
	private String nickname;
	private String profile_img;
	@NotBlank(message="제목을 입력하세요.") 
	@Length(max=30,message="제목을 30자 이내로 작성하세요.")
	private String title;
	@NotBlank(message="내용을 입력하세요.")
	private String content;
	private String writeDate;
	private String upload_file="";
	private String store_upload_file="";
	private MultipartFile multipartFile;
	private Long upload_file_size;
	private int viewCnt=0;
	private int parentNum;
	private int groupNum;
	
	// notDB
	private int lev;
	private int childCnt=0;
}
