package edu.spring.prj.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class loginchkInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = 
			LoggerFactory.getLogger(loginchkInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("===== preHandle 호출");
		// model 객체의 loginResult 속성값(userid와 동일)을 확인
				// - null이 아니면(로그인 성공) session 객체에 loingId 속성 추가, 페이지 이동
				// - null이면(로그인 실패) 메인 페이지로 이동
				
		 		HttpSession session = request.getSession(); 
		 		Object obj = session.getAttribute("loginId");
				logger.info("loginId = " + obj);
				if(obj != null) {
					String url = request.getParameter("targetUrl");
					logger.info("목적지 url : " + url);
					if(url != null && url != "") {
						request.getSession().setAttribute("dest", url);
						return false;
					}
				} else {
					logger.info("로그인 실패");
					session.setAttribute("loginFail", "loginFail");
					response.sendRedirect("../member/login");
				}
				return true;
	}
}
