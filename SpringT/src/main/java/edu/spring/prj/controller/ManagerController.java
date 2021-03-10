package edu.spring.prj.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/manager")
public class ManagerController {
	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);

	@GetMapping("/member-list")
	public void memberList(Model model, Integer page, Integer perPage, HttpServletRequest request) {
		logger.info("Manager Controller member-list 호출");
		// tableName 확인용
		HttpSession session = request.getSession();
		session.setAttribute("tableName", "member_table");
	} // member-list
	
	@RequestMapping("/register")
	public void register() {
		logger.info("관리자등록 새 창");
	}

} // ManagerController