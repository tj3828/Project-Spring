package com.hb.reservation;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.hb.account.AccountVO;

import config.Mapper;

@Mapper
public interface IReservationDAOMapper {
	
	@Insert("insert all " + 
			" 	into reservation " + 
			"	values ( "	+ 
			"		r_seq.nextval,"	+ 
			"		#{r_guest}, " + 
			"		(select profile_img from account where nickname = #{r_guest}), " + 
			"		#{r_host}, " + 
			"		(select profile_img from account where nickname = #{r_host}), " + 
			"		#{r_address} , " + 
			"		#{r_area}, " + 
			"		#{r_content}, "	+ 
			"		to_date(#{r_from},'yyyy/mm/dd hh24:Mi'), " + 
			"		to_date(#{r_to},'yyyy/mm/dd hh24:Mi'), " + 
			"		sysdate, " + 
			"		null, "	+ 
			"		null, "	+ 
			"		sysdate, " + 
			"		'true', " + 
			"		'false', " + 
			"		'예약중' ) " + 
			"	into chatting "	+ 
			"	values ( " + 
			"		chatting_seq.nextval, 'reservationRequest', #{r_guest}, (select profile_img from account where nickname = #{r_guest}), #{r_host}, (select profile_img from account where nickname = #{r_host}), sysdate, CONCAT(#{r_guest},'님의 예약요청입니다'), 0) " + 
			"	select * from DUAL" )
	@SelectKey(statement="select r_seq.currval FROM DUAL", keyProperty="r_no", before=false, resultType=int.class)
	int insertReservation(ReservationVO dto);
	
	@Select("select " + 
			"	r_no, "	+ 
			"	r_guest, "	+ 
			"	r_guest_profileImg, " + 
			"	r_host, " + 
			"	r_host_profileImg, " + 
			"	r_address, " + 
			"	r_area, " + 
			"	r_content, " + 
			"	to_char(r_from,'yyyy/mm/dd hh24:Mi') as r_from, " + 
			"	to_char(r_to,'yyyy/mm/dd hh24:Mi') as r_to, " + 
			"	to_char(r_request,'yyyy/mm/dd hh24:Mi') as r_request, " + 
			"	to_char(r_agree,'yyyy/mm/dd hh24:Mi') as r_agree, " + 
			"	to_char(r_statusdate,'yyyy/mm/dd hh24:Mi') as r_statusdate, "	+ 
			"	to_char(r_lastdate,'yyyy/mm/dd hh24:Mi') as r_lastdate, "	+ 
			"	r_guestread, " + 
			"	r_hostread, " + 
			"	r_status "	+ 
			"from reservation "	+ 
			"where r_no = #{r_num}" )
	ReservationVO selectReservationInfo(@Param("r_num") int no);
	
	@Select("select count(*) "	+ 
			"from reservation "	+ 
			"where " + 
			"	(r_host = #{nickname} and r_hostread='false') or (r_guest = #{nickname} and r_guestread='false' ) " + 
			"order by r_lastdate desc ")
	int selectReservationNotReadCheck(AccountVO dto);
	
	@Select("select " + 
			"	r_no, "	+ 
			"	r_guest, "	+ 
			"	r_guest_profileImg, " + 
			"	r_host, " + 
			"	r_host_profileImg, " + 
			"	r_address, " + 
			"	r_area, " + 
			"	r_content, " + 
			"	to_char(r_from,'yy/mm/dd hh24:Mi') as r_from, " + 
			"	to_char(r_to,'yy/mm/dd hh24:Mi') as r_to, " + 
			"	to_char(r_request,'yy/mm/dd hh24:Mi') as r_request, " + 
			"	to_char(r_agree,'yy/mm/dd hh24:Mi') as r_agree, " + 
			"	to_char(r_statusdate,'yy/mm/dd hh24:Mi') as r_statusdate, "	+ 
			"	to_char(r_lastdate,'yy/mm/dd hh24:Mi') as r_lastdate, "	+ 
			"	r_guestread, " + 
			"	r_hostread, " + 
			"	r_status "	+ 
			"from reservation "	+ 
			"where r_guest = #{nickname} or r_host = #{nickname} " + 
			"order by r_lastdate desc" )
	ArrayList<ReservationVO> selectReservationList(@Param("nickname") String nickname);

	@Update("update reservation set r_guestRead = 'true' where r_no = #{r_no} ")
	void updateChangeGuestReadCheck(ReservationVO dto);
	
	@Update("update reservation set r_hostRead = 'true' where r_no = #{r_no} ")
	void updateChangeHostReadCheck(ReservationVO dto);
	
	@Update("update reservation set r_guestRead = 'false', r_hostRead = 'true',r_agree = sysdate, r_lastdate = sysdate, r_status='예약완료' where r_no = #{r_no}")
	@SelectKey(statement="select " + 
						"	r_no, "	+ 
						"	r_guest, "	+ 
						"	r_guest_profileImg, " + 
						"	r_host, " + 
						"	r_host_profileImg, " + 
						"	r_address, " + 
						"	r_area, " + 
						"	r_content, " + 
						"	to_char(r_from,'yy/mm/dd hh24:Mi') as r_from, " + 
						"	to_char(r_to,'yy/mm/dd hh24:Mi') as r_to, " + 
						"	to_char(r_request,'yy/mm/dd hh24:Mi') as r_request, " + 
						"	to_char(r_agree,'yy/mm/dd hh24:Mi') as r_agree, " + 
						"	to_char(r_statusdate,'yy/mm/dd hh24:Mi') as r_statusdate, "	+ 
						"	to_char(r_lastdate,'yy/mm/dd hh24:Mi') as r_lastdate, "	+ 
						"	r_guestread, " + 
						"	r_hostread, " + 
						"	r_status "	+ 
						"from reservation where r_no = #{r_no}",
				keyProperty="r_no,r_guest,r_guest_profileImg,r_host,r_host_profileImg,r_address,r_area,r_content,r_from,r_to,r_agree,r_request,r_statusDate,r_lastDate,r_hostRead,r_guestRead,r_status", 
				before=false, resultType=ReservationVO.class)
	void updateAcceptReservation(ReservationVO dto);
	
	@Update("update reservation set r_guestRead = 'false', r_hostRead = 'true', r_lastdate = sysdate, r_status='예약취소' where r_no = #{r_no}")
	@SelectKey(statement="select " + 
						"	r_no, "	+ 
						"	r_guest, "	+ 
						"	r_guest_profileImg, " + 
						"	r_host, " + 
						"	r_host_profileImg, " + 
						"	r_address, " + 
						"	r_area, " + 
						"	r_content, " + 
						"	to_char(r_from,'yy/mm/dd hh24:Mi') as r_from, " + 
						"	to_char(r_to,'yy/mm/dd hh24:Mi') as r_to, " + 
						"	to_char(r_request,'yy/mm/dd hh24:Mi') as r_request, " + 
						"	to_char(r_agree,'yy/mm/dd hh24:Mi') as r_agree, " + 
						"	to_char(r_statusdate,'yy/mm/dd hh24:Mi') as r_statusdate, "	+ 
						"	to_char(r_lastdate,'yy/mm/dd hh24:Mi') as r_lastdate, "	+ 
						"	r_guestread, " + 
						"	r_hostread, " + 
						"	r_status "	+ 
						"from reservation where r_no = #{r_no}",
				keyProperty="r_no,r_guest,r_guest_profileImg,r_host,r_host_profileImg,r_address,r_area,r_content,r_from,r_to,r_agree,r_request,r_statusDate,r_lastDate,r_hostRead,r_guestRead,r_status", 
				before=false, resultType=ReservationVO.class)
	void updateInjectReservation(ReservationVO dto);
	
	@Update("update reservation set r_guestRead = 'true', r_hostRead = 'false',r_statusdate = sysdate, r_lastdate = sysdate, r_status='예약취소' where r_no = #{r_no}")
	@SelectKey(statement="select " + 
						"	r_no, "	+ 
						"	r_guest, "	+ 
						"	r_guest_profileImg, " + 
						"	r_host, " + 
						"	r_host_profileImg, " + 
						"	r_address, " + 
						"	r_area, " + 
						"	r_content, " + 
						"	to_char(r_from,'yy/mm/dd hh24:Mi') as r_from, " + 
						"	to_char(r_to,'yy/mm/dd hh24:Mi') as r_to, " + 
						"	to_char(r_request,'yy/mm/dd hh24:Mi') as r_request, " + 
						"	to_char(r_agree,'yy/mm/dd hh24:Mi') as r_agree, " + 
						"	to_char(r_statusdate,'yy/mm/dd hh24:Mi') as r_statusdate, "	+ 
						"	to_char(r_lastdate,'yy/mm/dd hh24:Mi') as r_lastdate, "	+ 
						"	r_guestread, " + 
						"	r_hostread, " + 
						"	r_status "	+ 
						"from reservation where r_no = #{r_no}",
				keyProperty="r_no,r_guest,r_guest_profileImg,r_host,r_host_profileImg,r_address,r_area,r_content,r_from,r_to,r_agree,r_request,r_statusDate,r_lastDate,r_hostRead,r_guestRead,r_status", 
				before=false, resultType=ReservationVO.class)
	void updateCancelGuestReservation(ReservationVO dto);
	
	@Update("update reservation set r_guestRead = 'false', r_hostRead = 'true',r_statusdate = sysdate, r_lastdate = sysdate, r_status='예약취소' where r_no = #{r_no}")
	@SelectKey(statement="select " + 
						"	r_no, "	+ 
						"	r_guest, "	+ 
						"	r_guest_profileImg, " + 
						"	r_host, " + 
						"	r_host_profileImg, " + 
						"	r_address, " + 
						"	r_area, " + 
						"	r_content, " + 
						"	to_char(r_from,'yy/mm/dd hh24:Mi') as r_from, " + 
						"	to_char(r_to,'yy/mm/dd hh24:Mi') as r_to, " + 
						"	to_char(r_request,'yy/mm/dd hh24:Mi') as r_request, " + 
						"	to_char(r_agree,'yy/mm/dd hh24:Mi') as r_agree, " + 
						"	to_char(r_statusdate,'yy/mm/dd hh24:Mi') as r_statusdate, "	+ 
						"	to_char(r_lastdate,'yy/mm/dd hh24:Mi') as r_lastdate, "	+ 
						"	r_guestread, " + 
						"	r_hostread, " + 
						"	r_status "	+ 
						"from reservation where r_no = #{r_no}",
				keyProperty="r_no,r_guest,r_guest_profileImg,r_host,r_host_profileImg,r_address,r_area,r_content,r_from,r_to,r_agree,r_request,r_statusDate,r_lastDate,r_hostRead,r_guestRead,r_status", 
				before=false, resultType=ReservationVO.class)
	void updateCancelHostReservation(ReservationVO dto);
}
