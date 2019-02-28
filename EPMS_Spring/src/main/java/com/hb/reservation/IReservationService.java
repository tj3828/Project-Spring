package com.hb.reservation;

public interface IReservationService {
	int insertReservation(ReservationVO dto);
	ReservationVO selectReservationInfo(int no);
}
