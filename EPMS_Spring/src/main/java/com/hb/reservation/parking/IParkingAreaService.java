package com.hb.reservation.parking;

import java.util.List;

import common.Paging;

public interface IParkingAreaService {
	List<ParkingAreaVO> selectSearchList(Paging paging);
}
