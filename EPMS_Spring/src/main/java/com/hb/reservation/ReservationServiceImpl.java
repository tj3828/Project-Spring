package com.hb.reservation;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.chat.IChatDAOMapper;
import com.hb.reservation.parking.IParkingAreaDAOMapper;
import com.hb.reservation.parking.PersonalParkingAreaVO;

@Service
@Transactional
public class ReservationServiceImpl implements IReservationService {

	@Inject
	IReservationDAOMapper reservationDAOMapper;	
	@Inject
	IChatDAOMapper chatDAOMapper;	
	@Inject
	IParkingAreaDAOMapper parkingAreaDAOMapper;
	
	@Override
	public int insertReservation(ReservationVO dto) {
		
		List<PersonalParkingAreaVO> list = parkingAreaDAOMapper.selectPersonalAreaList(dto);
		for(PersonalParkingAreaVO vo : list) {
			if(vo.getPap_area().equals(dto.getR_area())) {
				reservationDAOMapper.insertReservation(dto);
				return dto.getR_no();
			}
		}
		return -1;
	}

	@Override
	public ReservationVO selectReservationInfo(int no) {
		return reservationDAOMapper.selectReservationInfo(no);
	}

	@Override
	public void updateChangeGuestReadCheck(ReservationVO dto) {
		reservationDAOMapper.updateChangeGuestReadCheck(dto);
	}

	@Override
	public void updateAcceptReservation(ReservationVO dto) {
		reservationDAOMapper.updateAcceptReservation(dto);	
	}

	@Override
	public void updateChangeHostReadCheck(ReservationVO dto) {
		reservationDAOMapper.updateChangeHostReadCheck(dto);		
	}

	@Override
	public void updateInjectReservation(ReservationVO dto) {
		reservationDAOMapper.updateInjectReservation(dto);
	}

	@Override
	public void updateCancelGuestReservation(ReservationVO dto) {
		reservationDAOMapper.updateCancelGuestReservation(dto);
	}

	@Override
	public void updateCancelHostReservation(ReservationVO dto) {
		reservationDAOMapper.updateCancelHostReservation(dto);
	}

}
