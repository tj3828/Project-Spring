package com.hb.myInfo;

import java.util.ArrayList;

import com.hb.reservation.ReservationVO;

import common.Paging;

public interface IMyInfoService {
	
	ArrayList<ReservationVO> selectMyHostInfoList(String nick, Paging paging);
	ArrayList<ReservationVO> selectMyGuestInfoList(String nick, Paging paging);
	ArrayList<ReservationVO> selectMyExpirationInfoList(String nick, Paging paging);
}
