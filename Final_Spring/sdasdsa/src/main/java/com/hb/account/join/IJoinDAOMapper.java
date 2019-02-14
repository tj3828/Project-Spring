package com.hb.account.join;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.hb.account.AccountVO;

import config.Mapper;

@Mapper
public interface IJoinDAOMapper {
	
	@Select("select count(*) as cnt from account where id = #{id}")
	int checkId(AccountVO dto);
	
	@Select("select count(*) as cnt from account where nickname = #{nickname}")
	int checkNick(AccountVO dto);
	
	@Insert("insert into account values(#{id}, #{pw}, #{name}, #{nickname}, #{email}, #{phone}, #{addr1}, #{addr2}, #{gender}, #{profile_img} )")
	void join(AccountVO dto);
}
