package com.hb.account.login;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hb.account.AccountVO;

@Controller
@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
public class LoginController {
	
	@Inject
	ILoginService loginService; 
	
	@GetMapping("/login.do")
	public String showLoginPage(@CookieValue(value="id",required=false) Cookie cookie) {
		return "/account/login";
	}
	
	@ResponseBody
	@PostMapping("/loginReq.do")
	public int loginReq(AccountVO dto,HttpSession session,HttpServletResponse response,
						@RequestParam("saveId") boolean saveId, @RequestParam("autoLogin") boolean autoLogin) {
		int i =  loginService.loginReq(dto);
		dto = loginService.accountInfo(dto);
		if(i == 3) {
			session.setAttribute("id", dto.getId());
			session.setAttribute("nickname",dto.getNickname());
			Cookie cookie = new Cookie("id", dto.getId());
			cookie.setPath("/");
			if(saveId == true) {
				cookie.setMaxAge(60*60*24*30);
			} else {
				cookie.setMaxAge(0);
			}
			response.addCookie(cookie);
			
			Cookie cookie1 = new Cookie("autoLogin", "true");
			cookie1.setPath("/");
			if(autoLogin == true) {
				Cookie cookie2 = new Cookie("id", dto.getId());
				cookie2.setPath("/");
				cookie2.setMaxAge(60*60*24*30);
				response.addCookie(cookie2);
				System.out.println("자동로그인 설정됨");
				cookie1.setMaxAge(60*60*24*30);
			} else {
				cookie1.setMaxAge(0);
				System.out.println("자동로그인 해제됨");
			}
			response.addCookie(cookie1);
			
		}
		return i;
	}
	
	@PostMapping("/logout.do")
	public String logout(HttpSession session, HttpServletResponse response, @CookieValue(value="autoLogin",required=false) Cookie autoLogin) {
		String id = (String)session.getAttribute("id");
		loginService.logout(id);
		session.invalidate();
		if(autoLogin != null) {
			autoLogin.setMaxAge(0);
			response.addCookie(autoLogin);
		}
		System.out.println("로그아웃 설정됨");
		return "redirect:/login/login.do";
	}
}
