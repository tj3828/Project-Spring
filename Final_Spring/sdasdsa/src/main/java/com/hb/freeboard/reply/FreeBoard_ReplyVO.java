package com.hb.freeboard.reply;

import javax.validation.constraints.Max;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class FreeBoard_ReplyVO {
	private int num;
	@NotBlank
	private String nickname;
	@NotBlank @Max(100)
	private String content;
	private String writeDate;
	@NotBlank
	private String fr_idx;
	private String profile_img;
		
}
