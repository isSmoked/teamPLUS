package edu.spring.prj.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/bookmark")
public class BookmarkController {
	private static final Logger logger = LoggerFactory.getLogger(BookmarkController.class);

	@GetMapping("/list")
	public void bookmarkList(HttpServletRequest request) {
		logger.info("Bookmark Controller list »£√‚");

		// tableName Test
		HttpSession session = request.getSession();
		session.setAttribute("tableName", "bookmark_table");
	}
	
} // BookmarkController
