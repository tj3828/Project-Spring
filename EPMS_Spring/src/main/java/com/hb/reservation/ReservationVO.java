package com.hb.reservation;

import lombok.Data;

@Data
public class ReservationVO {
	private int r_no;
	private String r_guest;
	private String r_host;
	private String r_address;
	private String r_area;
	private String r_content;
	private String r_from;
	private String r_to;
	private String r_request;
	private String r_agree;
	private String r_statusDate;
	private String r_lastDate;
	private String r_guestRead;
	private String r_hostRead;
	private String r_status;
}
