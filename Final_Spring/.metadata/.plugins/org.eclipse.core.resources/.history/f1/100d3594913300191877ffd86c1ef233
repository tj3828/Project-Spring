package com.hb.account.login;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.account.AccountVO;

@Service
@Transactional
public class LoginServiceImpl implements ILoginService{

	@Inject
	ILoginDAOMapper loginDAOMapper;
	@Inject
	HttpSession session;
	@Override
	public AccountVO accountInfo(AccountVO dto) {
		return loginDAOMapper.accountInfo(dto);
	}

	@Override
	public int loginReq(AccountVO dto) {
		int i = loginDAOMapper.loginId(dto);
		if(i > 0) {
			i = loginDAOMapper.loginPw(dto);
			if(i>0) {
				i = loginDAOMapper.loginDuplicate(dto);
				if(i>0) {
					return 4;	// 占싱뱄옙 占싸깍옙占싸듸옙 占쏙옙占싱듸옙
				} else {
					loginDAOMapper.login(dto);
					return 3;	// 占싸깍옙占쏙옙 占쏙옙占쏙옙
				}
			} else {
				return 2;	// 占쏙옙橘占싫� 틀占쏙옙
			}
		} else {
			return 1;	// 占쏙옙占싱듸옙 占쏙옙占쏙옙  x
		}
	}
	
	@Override
	public AccountVO autoLoginReq(AccountVO dto) {
		int i = loginDAOMapper.loginDuplicate(dto);
		if(i<1) {
			loginDAOMapper.login(dto);
		}
		return loginDAOMapper.accountInfo(dto);
	}

	@Override
	public void logout(String id) {
		loginDAOMapper.logout(id);
	}
	
	
}
