package com.hb.reservation;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import config.Mapper;

@Mapper
public interface IReservationDAOMapper {
	
	@Insert("insert into reservation " + 
			"values ( "	+ 
			"	r_seq.nextval,"	+ 
			"	#{r_guest}, " + 
			"	#{r_host}, " + 
			"	#{r_address} , " + 
			"	#{r_area}, " + 
			"	#{r_content}, "	+ 
			"	to_date(#{r_from},'yyyy-mm-dd hh24:Mi'), " + 
			"	to_date(#{r_to},'yyyy-mm-dd hh24:Mi'), " + 
			"	sysdate, " + 
			"	null, "	+ 
			"	null, "	+ 
			"	sysdate, " + 
			"	'false', " + 
			"	'false', " + 
			"	'예약중' )")
	@SelectKey(statement="select r_seq.currval FROM DUAL", keyProperty="r_no", before=false, resultType=int.class)
	int insertReservation(ReservationVO dto);
	
	@Select("select " + 
			"	r_no, "	+ 
			"	r_guest, "	+ 
			"	r_host, " + 
			"	r_address, " + 
			"	r_area, " + 
			"	r_content, " + 
			"	to_char(r_from,'yyyy-mm-dd hh24:Mi') as r_from, " + 
			"	to_char(r_to,'yyyy-mm-dd hh24:Mi') as r_to, " + 
			"	to_char(r_request,'yyyy-mm-dd hh24:Mi') as r_request, " + 
			"	to_char(r_agree,'yyyy-mm-dd hh24:Mi') as r_agree, " + 
			"	to_char(r_statusdate,'yyyy-mm-dd hh24:Mi') as r_statusdate, "	+ 
			"	to_char(r_lastdate,'yyyy-mm-dd hh24:Mi') as r_lastdate, "	+ 
			"	r_guestread, " + 
			"	r_hostread, " + 
			"	r_status "	+ 
			"from reservation "	+ 
			"where r_no = #{r_num}" )
	ReservationVO selectReservationInfo(@Param("r_num") int no);
}
