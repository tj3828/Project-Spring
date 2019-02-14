package com.hb.freeboard.like;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import config.Mapper;

@Mapper
public interface ILikeDAOMapper {
	
	@Select("select count(*) from freeboard_like where id = #{id} and fr_idx = #{fr_idx}")
	int checkLike(LikeVO ldto);
	
	@Delete("delete from freeboard_like where id = #{id} and fr_idx = #{fr_idx}")
	void deleteLike(LikeVO ldto);
	
	@Update("update freeboard set likeCnt = (select count(*) from freeboard_like where fr_idx = #{fr_idx}) where num = #{fr_idx}")
	void updateLike(LikeVO ldto);
	
	@Insert("insert into freeboard_like values(freeboard_like_seq.nextval, #{fr_idx}, #{id})")
	void insertLike(LikeVO ldto);
	
	@Select("select likeCnt from freeboard where num = #{fr_idx} ")
	int getLike(LikeVO ldto);
}
