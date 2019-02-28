package com.hb.reservation;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hb.reservation.parking.IParkingAreaDAOMapper;
import com.hb.reservation.parking.PersonalParkingAreaVO;

@Service
@Transactional
public class ReservationServiceImpl implements IReservationService {

	@Inject
	IReservationDAOMapper reservationDAOMapper;
	
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

}
