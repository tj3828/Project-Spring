package com.hb.account.login;

import com.hb.account.AccountVO;

public interface ILoginService {
	
	AccountVO accountInfo(AccountVO dto);
	int loginReq(AccountVO dto);
	AccountVO autoLoginReq(AccountVO dto);
	void logout(String id);
	AccountVO snsLoginCheck(AccountVO dto);
}
