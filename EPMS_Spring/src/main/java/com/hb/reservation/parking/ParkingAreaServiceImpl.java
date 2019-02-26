package com.hb.reservation.parking;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import common.Paging;

@Service
@Transactional
public class ParkingAreaServiceImpl implements IParkingAreaService{
	
	@Inject
	IParkingAreaDAOMapper parkingAreaDAOMapper;
	
	@Override
	public List<ParkingAreaVO> selectSearchList(Paging paging) {
		int totalCount = parkingAreaDAOMapper.selectParkingAreaListCount(); 
		int searchCount =  parkingAreaDAOMapper.selectSearchParkingAreaListCount(paging); 
			paging.setSearchCount(searchCount);
			paging.setColPageNum(5); 
			paging.setRowPageNum(5);
			paging.setTotalCount(totalCount); 
			paging.calulate();
			  
		return parkingAreaDAOMapper.selectSearchList(paging);
	}

}
