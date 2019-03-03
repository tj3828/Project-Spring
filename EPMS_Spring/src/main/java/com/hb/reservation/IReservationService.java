package com.hb.reservation;

public interface IReservationService {
	int insertReservation(ReservationVO dto);
	ReservationVO selectReservationInfo(int no);
	
	void updateChangeGuestReadCheck(ReservationVO dto);
	void updateChangeHostReadCheck(ReservationVO dto);
	void updateAcceptReservation(ReservationVO dto);
	void updateInjectReservation(ReservationVO dto);
	void updateCancelGuestReservation(ReservationVO dto);
	void updateCancelHostReservation(ReservationVO dto);
	
}
