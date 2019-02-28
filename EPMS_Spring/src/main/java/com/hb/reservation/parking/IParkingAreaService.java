package com.hb.reservation.parking;

import java.util.List;

import com.hb.reservation.ReservationVO;

import common.Paging;

public interface IParkingAreaService {
	List<ParkingAreaVO> selectSearchList(Paging paging);
	List<PersonalParkingAreaVO> selectPersonalAreaList(ReservationVO dto);
}
