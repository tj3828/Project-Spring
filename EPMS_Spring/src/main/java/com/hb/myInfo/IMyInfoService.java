package com.hb.myInfo;

import java.util.ArrayList;

import com.hb.reservation.ReservationVO;

import common.Paging;

public interface IMyInfoService {
	
	ArrayList<ReservationVO> selectMyHostInfoList(String nick, Paging paging);
}
