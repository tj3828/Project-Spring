package com.hb.myInfo;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.hb.reservation.ReservationVO;

import common.Paging;
import config.Mapper;

@Mapper
public interface IMyInfoDAOMapper {

	
	@Select("select r_no, rn, " + 
			"			r_guest, " + 
			"			r_guest_profileImg, " + 
			"			r_host, " + 
			"			r_host_profileImg, " + 
			"			r_address, " + 
			"			r_area, " + 
			"			r_content, " + 
			"			to_char(r_from,'yyyy/mm/dd hh24:Mi') as r_from, " + 
			"			to_char(r_to,'yyyy/mm/dd hh24:Mi') as r_to, " + 
			"			to_char(r_request,'yyyy/mm/dd hh24:Mi') as r_request, " + 
			"			to_char(r_agree,'yyyy/mm/dd hh24:Mi') as r_agree, " + 
			"			to_char(r_statusdate,'yyyy/mm/dd hh24:Mi') as r_statusdate, " + 
			"			to_char(r_lastdate,'yyyy/mm/dd hh24:Mi') as r_lastdate, " + 
			"			r_guestread, " + 
			"			r_hostread, " + 
			"			r_status  from (" + 
			"	select rownum rn, r.* " + 
			"	from reservation r " +
			"	where r_host= #{nick} and r_status in ('예약완료', '예약중') " + 
			"	order by r_request desc) where rn between #{paging.end} and #{paging.start} ")
	ArrayList<ReservationVO> selectMyHostInfoList(@Param("nick") String nick,@Param("paging") Paging paging);

	@Select("select count(*) from reservation where r_host= #{nick} and r_status in ('예약완료', '예약중')")
	int selectMyHostListAccount(@Param("nick") String nick);
	
	@Select("select r_no, rn, " + 
			"			r_guest, " + 
			"			r_guest_profileImg, " + 
			"			r_host, " + 
			"			r_host_profileImg, " + 
			"			r_address, " + 
			"			r_area, " + 
			"			r_content, " + 
			"			to_char(r_from,'yyyy/mm/dd hh24:Mi') as r_from, " + 
			"			to_char(r_to,'yyyy/mm/dd hh24:Mi') as r_to, " + 
			"			to_char(r_request,'yyyy/mm/dd hh24:Mi') as r_request, " + 
			"			to_char(r_agree,'yyyy/mm/dd hh24:Mi') as r_agree, " + 
			"			to_char(r_statusdate,'yyyy/mm/dd hh24:Mi') as r_statusdate, " + 
			"			to_char(r_lastdate,'yyyy/mm/dd hh24:Mi') as r_lastdate, " + 
			"			r_guestread, " + 
			"			r_hostread, " + 
			"			r_status  from (" + 
			"	select rownum rn, r.* " + 
			"	from reservation r " +
			"	where r_guest= #{nick} and r_status in ('예약완료', '예약중') " + 
			"	order by r_request desc) where rn between #{paging.end} and #{paging.start} ")
	ArrayList<ReservationVO> selectMyGuestInfoList(@Param("nick") String nick,@Param("paging") Paging paging);
	
	@Select("select count(*) from reservation where r_guest= #{nick} and r_status in ('예약완료', '예약중')")
	int selectMyGuestListAccount(@Param("nick") String nick);
	
	@Select("select r_no, rn, " + 
			"			r_guest, " + 
			"			r_guest_profileImg, " + 
			"			r_host, " + 
			"			r_host_profileImg, " + 
			"			r_address, " + 
			"			r_area, " + 
			"			r_content, " + 
			"			to_char(r_from,'yyyy/mm/dd hh24:Mi') as r_from, " + 
			"			to_char(r_to,'yyyy/mm/dd hh24:Mi') as r_to, " + 
			"			to_char(r_request,'yyyy/mm/dd hh24:Mi') as r_request, " + 
			"			to_char(r_agree,'yyyy/mm/dd hh24:Mi') as r_agree, " + 
			"			to_char(r_statusdate,'yyyy/mm/dd hh24:Mi') as r_statusdate, " + 
			"			to_char(r_lastdate,'yyyy/mm/dd hh24:Mi') as r_lastdate, " + 
			"			r_guestread, " + 
			"			r_hostread, " + 
			"			r_status  from (" + 
			"	select rownum rn, r.* " + 
			"	from reservation r " +
			"	where (r_guest= #{nick} and r_status in ('예약취소', '사용완료')) or (r_host= #{nick} and r_status in ('예약취소', '사용완료')) " + 
			"	order by r_lastdate desc) where rn between #{paging.end} and #{paging.start} ")
	ArrayList<ReservationVO> selectMyExpirationInfoList(@Param("nick") String nick,@Param("paging") Paging paging);
	
	@Select("select count(*) from reservation where (r_guest= #{nick} and r_status in ('예약취소', '사용완료')) or (r_host= #{nick} and r_status in ('예약취소', '사용완료'))")
	int selectMyExpirationListAccount(@Param("nick") String nick);
	
}
