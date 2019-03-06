package com.hb.myInfo;

import java.util.ArrayList;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.reservation.ReservationVO;

import common.Paging;

@Service
@Transactional
public class MyInfoServiceImpl implements IMyInfoService{

	@Inject
	IMyInfoDAOMapper myInfoDAOMapper;
	
	@Override
	public ArrayList<ReservationVO> selectMyHostInfoList(String nick, Paging paging) {
		int totalCount = myInfoDAOMapper.selectMyHostListAccount(nick); 
			paging.setSearchCount(totalCount);
			paging.setColPageNum(10); 
			paging.setRowPageNum(3);
			paging.setTotalCount(totalCount); 
			paging.calulate();
		
		return myInfoDAOMapper.selectMyHostInfoList(nick, paging);
	}

}
