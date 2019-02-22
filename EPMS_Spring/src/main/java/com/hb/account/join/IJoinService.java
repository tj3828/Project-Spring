package com.hb.account.join;

import com.hb.account.AccountVO;

public interface IJoinService {
		int checkId(AccountVO dto);
		int checkNick(AccountVO dto);
		void join(AccountVO dto);
}
