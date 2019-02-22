package com.hb.freeboard.reply;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class FreeBoard_ReplyVO {
	private int num;
	@NotBlank(message="로그인을 해주세요.")
	private String nickname;
	@NotBlank(message="댓글을 입력해주세요.")
	@Length(max=100,message="댓글은 100자이하여야 합니다.")
	private String content;
	private String writeDate;
	@NotBlank(message="비정상적인 접근입니다.")
	private String fr_idx;
	private String profile_img;
		
}
