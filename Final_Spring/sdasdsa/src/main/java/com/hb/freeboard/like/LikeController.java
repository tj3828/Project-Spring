package com.hb.freeboard.like;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/like")
public class LikeController {
	
	@Inject
	ILikeService likeService;
	
	@PostMapping("/change.do")
	public Map<String,String> change(@RequestParam("Like") int like, LikeVO ldto) {
		System.out.println(ldto.getId());
		Map<String,String> map = new HashMap<String, String>();
		if(like == 1) {
			likeService.deleteLike(ldto);
			map.put("checkLike", "0");
		} else {
			likeService.insertLike(ldto);
			map.put("checkLike", "1");
		}
		int cnt = likeService.getLike(ldto);
		map.put("likeCnt", String.valueOf(cnt));
		return map;
	}
}
