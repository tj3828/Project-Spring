package com.hb.freeboard.like;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;

import lombok.Data;

@Data
public class LikeVO {
	private int num;
	@Range(min=1)
	private int fr_idx;
	@NotBlank
	private String id;
}
