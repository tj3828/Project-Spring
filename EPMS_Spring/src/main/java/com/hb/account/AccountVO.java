package com.hb.account;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;


@Data
public class AccountVO {
	@NotBlank(message="아이디를 입력하세요.")
	private String id;
	@NotBlank(message="비밀번호를 입력하세요.")
	private String pw;
	@NotBlank(message="이름를 입력하세요.")
	private String name;
	@NotBlank(message="닉네임을 입력하세요.")
	private String nickname;
	@NotBlank(message="이메일을 입력하세요.")
	@Email(message="이메일 형식을 확인하세요.")
	private String email;
	@NotBlank(message="전화번호를 입력하세요.")
	private String phone;
	@NotBlank(message="주소를 입력하세요.")
	private String addr1;
	@NotBlank(message="상세주소를 입력하세요.")
	private String addr2;
	@NotBlank(message="성별을 선택하세요.")
	private String gender;
	@NotBlank(message="프로필 이미지를 선택하세요.")
	private String profile_img;
	private MultipartFile multipartFile;
	
}
