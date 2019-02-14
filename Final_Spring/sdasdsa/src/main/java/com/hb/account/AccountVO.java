package com.hb.account;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AccountVO {
	@NotBlank
	private String id;
	@NotBlank
	private String pw;
	@NotBlank
	private String name;
	@NotBlank
	private String nickname;
	@NotBlank @Email
	private String email;
	@NotBlank
	private String phone;
	@NotBlank
	private String addr1;
	@NotBlank
	private String addr2;
	@NotBlank
	private String gender;
	@NotBlank
	private String profile_img;
	private MultipartFile multipartFile;
	
}
