package com.hb.chat.config;

import java.io.StringWriter;

import javax.json.Json;
import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import com.hb.reservation.ReservationVO;

public class ReservationMessageEncoder implements Encoder.Text<ReservationVO> {

	@Override
	public String encode(ReservationVO vo) throws EncodeException {
		StringWriter writer = new StringWriter();
		   
	    Json.createGenerator(writer)
	            .writeStartObject()
	              .write("message_type", "reservation")
	              .write("r_no", vo.getR_no())
	              .write("r_guest", vo.getR_guest())
	              .write("r_guest_profileImg", vo.getR_guest_profileImg())
	              .write("r_host", vo.getR_host())
	              .write("r_host_profileImg", vo.getR_host_profileImg())
	              .write("r_address", vo.getR_address())
	              .write("r_area", vo.getR_area())
	              .write("r_content", vo.getR_content())
	              .write("r_from", vo.getR_from())
	              .write("r_to", vo.getR_to())
	              .write("r_request", vo.getR_request())
	              .write("r_agree", vo.getR_agree().equals("") ? "" : vo.getR_agree().substring(2))
	              .write("r_statusDate", vo.getR_statusDate().equals("") ? "" : vo.getR_statusDate().substring(2))
	              .write("r_lastDate", vo.getR_lastDate())
	              .write("r_guestRead", vo.getR_guestRead())
	              .write("r_hostRead", vo.getR_hostRead())
	              .write("r_status", vo.getR_status())
	            .writeEnd()
	            .flush();
	    System.out.println(writer.toString());
	    return writer.toString();
	}
	
	@Override
	public void init(EndpointConfig config) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	
}
