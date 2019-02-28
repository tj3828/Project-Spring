package com.hb.reservation.parking;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hb.reservation.ReservationVO;

import common.Paging;

@Controller
@RequestMapping("/reservationPage")
public class ParkingAreaController {
	
	@Inject
	IParkingAreaService parkingAreaService;
	
	@GetMapping("/showPage.do")
	public String viewMainPage() {
		return "/common/reservation";
	}
	
	@GetMapping("/searchList.do")
	public ModelAndView selectSearchList(Paging paging) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		List<ParkingAreaVO> list = new ArrayList<ParkingAreaVO>();
		list = parkingAreaService.selectSearchList(paging);
		System.out.println("list 사이즈 : " + list.size());
		
		Map resultMap = new HashMap();
		resultMap.put("list", list);
		resultMap.put("paging", paging);
		
		modelAndView.addAllObjects(resultMap);
		
		return modelAndView;
	}
	
	@PostMapping("/personalAreaList.do")
	public ModelAndView selectPersonalAreaList(ReservationVO dto) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		List<PersonalParkingAreaVO> list = parkingAreaService.selectPersonalAreaList(dto);
		mav.addObject("list", list);		
		
		return mav;
	}
}
