package com.hb.reservation.parking;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import common.Paging;
import config.Mapper;

@Mapper
public interface IParkingAreaDAOMapper {
	
	@Select("select r.* " + 
			"from ( " + 
			"	select p.*, rownum as rn " + 
			"	from ( " + 
			"		select * " + 
			"		from parking_area "	+ 
			"		order by pa_address asc ) p " + 
			"	where pa_address like '%' || #{keyword} || '%' and pa_address like '%' || #{keyfield} || '%' ) r " + 
			"where rn " + 
			"between #{end} and #{start} " )
	List<ParkingAreaVO> selectSearchList(Paging paging);
	
	@Select("select count(*) from parking_area")
	int selectParkingAreaListCount();
	
	@Select("select count(*) from parking_area where pa_address like '%' || #{keyword} || '%' and pa_address like '%' || #{keyfield} || '%' ")
	int selectSearchParkingAreaListCount(Paging	paging);
}
