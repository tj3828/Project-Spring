package com.hb.freeboard.reply;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class FreeBoard_ReplyVO {
	private int num;
	@NotBlank
	private String nickname;
	@NotBlank
	@Length(max=100)
	private String content;
	private String writeDate;
	@NotBlank
	private String fr_idx;
	private String profile_img;
		
}
