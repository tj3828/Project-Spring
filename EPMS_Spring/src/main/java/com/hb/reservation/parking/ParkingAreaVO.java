package com.hb.reservation.parking;

import lombok.Data;

@Data
public class ParkingAreaVO {
	private int pa_no;
	private String pa_si;
	private String pa_gu;
	private String pa_address;
	private double pa_lat;
	private double pa_lon;
}
