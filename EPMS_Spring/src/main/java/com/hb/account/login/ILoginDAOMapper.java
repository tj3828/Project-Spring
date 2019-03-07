package com.hb.account.login;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.hb.account.AccountVO;

import config.Mapper;

@Mapper
public interface ILoginDAOMapper {
	
	@Select("select * from account where id=#{id}")
	AccountVO accountInfo(AccountVO dto);
	
	@Select("select count(*) as cnt from account where id = #{id}")
	int loginId(AccountVO dto);
	
	@Select("select count(*) as cnt from account where id=#{id} and pw=#{pw}")
	int loginPw(AccountVO dto);
	
	@Select("select count(*) as cnt from login where id=#{id}")
	int loginDuplicate(AccountVO dto);
	
	@Insert("insert into login values(#{id})")
	void login(AccountVO dto);
	
	
	
	@Delete("delete from login where id=#{id}")
	void logout(String id);
}
