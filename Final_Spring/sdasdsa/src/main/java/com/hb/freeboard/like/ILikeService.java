package com.hb.freeboard.like;

public interface ILikeService {
	int checkLike(LikeVO ldto);
	void deleteLike(LikeVO ldto);
	void insertLike(LikeVO ldto);
	int getLike(LikeVO ldto);
}
