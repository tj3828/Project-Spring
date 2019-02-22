package interceptor;



import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
	
	private Log log = LogFactory.getLog(LoggerInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		 if (log.isInfoEnabled()) {
			 log.info(new Date().toString());
			 log.info("======================================          START         ======================================");
			 log.info(" Request Date \t: " + new Date().toString());
			 log.info(" Request URI \t:  " + request.getRequestURI());
		 }
	     return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (log.isInfoEnabled()) {
             log.info("======================================           END          ======================================\n");
        }
	}
	
}
