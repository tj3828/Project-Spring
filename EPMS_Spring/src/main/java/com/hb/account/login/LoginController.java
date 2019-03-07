package com.hb.account.login;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.hb.account.AccountVO;
import com.hb.account.login.kakao.KakaoLoginApi;
import com.hb.account.login.kakao.KakaoUserInfo;
import com.hb.account.login.naver.NaverLoginBO;


@Controller
@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
public class LoginController {
	
	@Inject
	ILoginService loginService; 
	@Inject
	NaverLoginBO naverLoginBO;
	
	@GetMapping("/login.do")
	public String showLoginPage(@CookieValue(value="id",required=false) Cookie cookie, HttpSession session, Model model) {
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("naverUrl", naverAuthUrl);

		return "/account/login";
	}
	
	@ResponseBody
	@PostMapping("/loginReq.do")
	public int loginReq(AccountVO dto,HttpSession session,HttpServletResponse response,
						@RequestParam("saveId") boolean saveId, @RequestParam("autoLogin") boolean autoLogin) {
		int i = loginService.loginReq(dto);
		dto = loginService.accountInfo(dto);
		if(i == 3) {
			session.setAttribute("dto", dto);
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
	public String logout(HttpSession session, HttpServletResponse response, 
						 @CookieValue(value="autoLogin",required=false) Cookie autoLogin,
						 @CookieValue(value="chatPage",required=false) Cookie chatPage,
						 @CookieValue(value="chatPageOpen",required=false) Cookie chatPageOpen,
						 @CookieValue(value="chatScroll",required=false) Cookie chatScroll,
						 @CookieValue(value="chatWho", required=false) Cookie chatWho) {
		String id = ((AccountVO)session.getAttribute("dto")).getId();
		loginService.logout(id);
		session.invalidate();
		if(autoLogin != null) {
			System.out.println("autoLogin 호출");
			Cookie temp = new Cookie("autoLogin", "");
			temp.setMaxAge(0);
			temp.setPath("/");
			response.addCookie(temp);
		}
		
		System.out.println(chatPage != null);
		if(chatPage != null) {
			System.out.println("??");
			Cookie temp = new Cookie("chatPage", "");
			temp.setMaxAge(0);
			temp.setPath("/");
			response.addCookie(temp);
		}
		
		if(chatPageOpen != null) {
			System.out.println("??");
			Cookie temp = new Cookie("chatPageOpen", "");
			temp.setMaxAge(0);
			temp.setPath("/");
			response.addCookie(temp);
		}
		if(chatScroll != null) {
			Cookie temp = new Cookie("chatScroll", "");
			temp.setMaxAge(0);
			temp.setPath("/");
			response.addCookie(temp);
		}
		
		if(chatWho != null) {
			Cookie temp = new Cookie("chatWho", "");
			temp.setMaxAge(0);
			temp.setPath("/");
			response.addCookie(temp);
		}
		System.out.println("로그아웃 설정됨");
		return "redirect:/login/login.do";
	}
	
	// 네이버 로그인성공
	@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
	    String apiResult = naverLoginBO.getUserProfile(oauthToken);
	    JSONParser parser = new JSONParser();
	    try {
			JSONObject jsonObj = (JSONObject)parser.parse(apiResult);
			JSONObject response = (JSONObject) jsonObj.get("response");
			String id = (String)response.get("id");
			AccountVO dto = new AccountVO();
			dto.setId(id);
			dto.setPw("1");
			dto = loginService.snsLoginCheck(dto);
			
			if(dto != null) {
				loginService.loginReq(dto);
				session.setAttribute("dto", dto);
				return "redirect:/main/main.do";
			} 
		} catch (ParseException e) {
			e.printStackTrace();
		}
		model.addAttribute("result", apiResult);
		System.out.println(apiResult);
		return "/snsLogin/loginCallback";
	}
	
	@GetMapping(value = "/kakaoLogin.do")
    public String kakaoLogin(AccountVO dto,HttpSession session, Model model) {
		dto.setPw("1");
		AccountVO vo = loginService.snsLoginCheck(dto);
		
		if(vo != null) {
			loginService.loginReq(vo);
			session.setAttribute("dto", vo);
			return "redirect:/main/main.do";
		} 
		
		JSONObject object = new JSONObject();
		object.put("id", dto.getId());
		object.put("name", dto.getName());
		object.put("email", dto.getEmail());
		object.put("gender", dto.getGender() != null && dto.getGender().equals(" female")? "G":"M" );
        JSONObject object2 = new JSONObject();
        object2.put("response", object);
        
        model.addAttribute("result", object2);
		
		return "/snsLogin/loginCallback";
    }

}
