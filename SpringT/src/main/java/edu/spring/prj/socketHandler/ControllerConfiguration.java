package edu.spring.prj.socketHandler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


@Configuration
@EnableWebSocket
@EnableWebMvc
@ComponentScan(basePackages = {
		"edu.spring.prj.controller",
		"edu.spring.prj.socketHandler"
})
public class ControllerConfiguration extends WebMvcConfigurerAdapter implements WebSocketConfigurer{

	
	private static final Logger logger = 
			LoggerFactory.getLogger(ControllerConfiguration.class);

	@Autowired
	public EchoHandler echoHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		logger.info("registerWebSocketHandler() »£√‚");
		registry.addHandler(echoHandler, "/prj/StudyBoard").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/EmpBoard").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/RecBoard").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/bookmark").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/freeboard").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/manager").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/member").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/mypage").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/qaboard").setAllowedOrigins("*");
		registry.addHandler(echoHandler, "/prj/shareboard").setAllowedOrigins("*");
	}
	

}
