package com.hb.reservation;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
}
