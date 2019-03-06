package com.hb.myInfo;

import java.util.ArrayList;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hb.account.AccountVO;
import com.hb.reservation.ReservationVO;

import common.Paging;

@Controller
@RequestMapping("/myInfo")
public class MyInfoController {
	
	@Inject
	IMyInfoService myInfoService;
	
	@GetMapping("/myHostPage.do") 
	public String showMyInfoHostPage(HttpSession session, Paging paging, Model model) {
		AccountVO vo =  (AccountVO)session.getAttribute("dto");
		ArrayList<ReservationVO> list = myInfoService.selectMyHostInfoList(vo.getNickname(), paging);
		model.addAttribute("list", list);
		
		return "/myPage/myHost";
	}
	
	@GetMapping("/myGuestPage.do") 
	public String showMyInfoGuestPage(HttpSession session, Paging paging, Model model) {
		AccountVO vo =  (AccountVO)session.getAttribute("dto");
		ArrayList<ReservationVO> list = myInfoService.selectMyGuestInfoList(vo.getNickname(), paging);
		model.addAttribute("list", list);
		
		return "/myPage/myGuest";
	}
	
	@GetMapping("/myExpirationPage.do") 
	public String showMyInfoExpirationPage(HttpSession session, Paging paging, Model model) {
		AccountVO vo =  (AccountVO)session.getAttribute("dto");
		ArrayList<ReservationVO> list = myInfoService.selectMyExpirationInfoList(vo.getNickname(), paging);
		model.addAttribute("list", list);
		
		return "/myPage/myExpiration";
	}
}
