package com.hb.myInfo;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.hb.reservation.ReservationVO;

import common.Paging;
import config.Mapper;

@Mapper
public interface IMyInfoDAOMapper {

	
	@Select("select * from (" + 
			"	select rownum rn, r.* " + 
			"	from reservation r " +
			"	where r_host= #{nick} and r_status in ('예약완료', '예약중') " + 
			"	order by r_request desc) where rn between #{paging.end} and #{paging.start} ")
	ArrayList<ReservationVO> selectMyHostInfoList(@Param("nick") String nick,@Param("paging") Paging paging);

	@Select("select count(*) from reservation where r_host= #{nick} and r_status in ('예약완료', '예약중')")
	int selectMyHostListAccount(@Param("nick") String nick);
	
}
