package com.hb.reservation;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hb.account.AccountVO;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
	
	@Inject
	IReservationService reservationService;
	
	@PostMapping("/reservationRequest")
	public ModelAndView insertReservation(ReservationVO dto, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		AccountVO vo = (AccountVO)session.getAttribute("dto");
		dto.setR_guest(vo.getNickname());
		
		int result = reservationService.insertReservation(dto);
		mav.addObject("result", result);
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/changeGuestReadCheck.do")
	public void updateChangeGuestReadCheck(ReservationVO dto) {
		reservationService.updateChangeGuestReadCheck(dto);
	}
	
	@ResponseBody
	@PostMapping("/changeHostReadCheck.do")
	public void updateChangeHostReadCheck(ReservationVO dto) {
		reservationService.updateChangeHostReadCheck(dto);
	}
	/*
	
	@PostMapping("/acceptReservation.do")
	public ModelAndView acceptReservation(ReservationVO dto) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		reservationService.updateAcceptReservation(dto);
		mav.addObject("dto", dto);
		
		return mav;
	}*/
}
