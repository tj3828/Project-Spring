package com.hb.freeboard.like;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LikeServiceImpl implements ILikeService{

	@Inject
	ILikeDAOMapper likeMapper;
	
	@Override
	public int checkLike(LikeVO ldto) {
		return likeMapper.checkLike(ldto);
	}

	@Override
	public void deleteLike(LikeVO ldto) {
		likeMapper.deleteLike(ldto);
		likeMapper.updateLike(ldto);
	}

	@Override
	public void insertLike(LikeVO ldto) {
		likeMapper.insertLike(ldto);
		likeMapper.updateLike(ldto);
	}

	@Override
	public int getLike(LikeVO ldto) {
		return likeMapper.getLike(ldto);
	}
	
	
	
	
}
