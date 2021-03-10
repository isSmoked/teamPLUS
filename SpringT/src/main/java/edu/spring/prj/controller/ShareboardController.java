package edu.spring.prj.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.spring.prj.domain.ShareboardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.pageutil.PageMaker;
import edu.spring.prj.service.ShareboardService;

@Controller
@RequestMapping(value = "/shareboard")
public class ShareboardController {
	private static final Logger logger = LoggerFactory.getLogger(ShareboardController.class);

	@Autowired
	private ShareboardService shareboardService;

	@GetMapping("/list")
	public void list(Model model, Integer page, Integer perPage, HttpServletRequest request, String searchType, String keyword) {
		logger.info("Shareboard Controller list 호출");
		logger.info("Shareboard Controller page = " + page + ", perPage = " + perPage);
		logger.info("Shareboard Controller searchType : " + searchType + ", keyword : " + keyword);

		// Paging 처리
		PageCriteria criteria = new PageCriteria();
		if (searchType != null) {
			logger.info("searchType");
			criteria.setSearchType(searchType);
		}
		if (keyword != null) {
			logger.info("keyword");
			criteria.setKeyword(keyword);
		}
		if (page != null) {
			logger.info("page");
			criteria.setPage(page);
		}
		if (perPage != null) {
			logger.info("perPage");
			criteria.setNumsPerPage(perPage);
		}
		
		logger.info("Shareboard Controller criteria set searchType : " + criteria.getSearchType() + ", " + criteria.getKeyword());

		//
		List<ShareboardVO> shareboardNotice = shareboardService.selectNotice();
		model.addAttribute("shareboardNotice", shareboardNotice);
		//
		List<ShareboardVO> list = shareboardService.read(criteria);
		model.addAttribute("shareboardList", list);

		PageMaker maker = new PageMaker();
		maker.setCriteria(criteria);
		maker.setTotalCount(shareboardService.getTotalNumsOfRecords(criteria));
		maker.setPageData();
		model.addAttribute("pageMaker", maker);

		// tableName Test
		HttpSession session = request.getSession();
		session.setAttribute("tableName", "shareboard_table");
		
		session.setAttribute("searchType", searchType);
		session.setAttribute("keyword", keyword);
	} // end list()

	@GetMapping("/register")
	public void registerGET() {
		logger.info("Shareboard Controller registerGET() 호출");
	} // end registerGET()

	@PostMapping("/register")
	public String registerPOST(ShareboardVO vo, RedirectAttributes reAttr) {
		// RedirectAttributes
		// - 재경로 위치에 속성값을 전송하는 객체
		logger.info("Shareboard Controller registerPOST() 호출");
		logger.info("Shareboard Controller register : " + vo.toString());
		int result = shareboardService.create(vo);
		System.out.println();
		if (result == 1) { // DB insert 성공
			// "insert_result"의 키이름을 가진 데이터 전송
			reAttr.addFlashAttribute("resultAlert", "insertSuccess");
			return "redirect:/shareboard/list"; // /board/list 경로로 이동(get)방식
		} else { // DB insert 실패
			reAttr.addFlashAttribute("resultAlert", "insertFail");
			return "redirect:/shareboard/register"; // /board/register 경로로 이동
		}
	}

	@GetMapping("/detail")
	public void detailGET(int bno, Model model, @ModelAttribute("page") int page) {
		logger.info("Shareboard Controller detail() 호출 : bno = " + bno);
		ShareboardVO vo = shareboardService.read(bno);
		model.addAttribute("shareboardVO", vo);
	}

	@GetMapping("/update")
	public void updateGET(int bno, Model model, @ModelAttribute("page") int page) {
		logger.info("Shareboard Controller update() 호출 : bno = " + bno);
		ShareboardVO vo = shareboardService.read(bno);
		model.addAttribute("shareboardVO", vo);
	}

	@PostMapping("/update")
	public String updatePOST(ShareboardVO vo, int page, RedirectAttributes reAttr) {
		logger.info("Shareboard Controller updatePOST() 호출 : bno = " + vo.getShareboard_bno());
		// vo 값이 없음.
		int result = shareboardService.update(vo);
		if (result == 1) {
			reAttr.addFlashAttribute("resultAlert",	"updateSuccess");
			return "redirect:/shareboard/detail?bno=" + vo.getShareboard_bno() + "&page=" + page;
		} else {
			reAttr.addFlashAttribute("resultAlert",	"updateFail");
			return "redirect:/shareboard/update?bno=" + vo.getShareboard_bno();
		}
	}

	@GetMapping("/delete")
	public String delete(int bno, RedirectAttributes reAttr) {
		logger.info("Shareboard Controller delete() 호출 : bno = " + bno);
		int result = shareboardService.delete(bno);
		if (result == 1) {
			reAttr.addFlashAttribute("resultAlert", "deleteSuccess");
			return "redirect:/shareboard/list";
		} else {
			reAttr.addFlashAttribute("resultAlert", "deleteFail");
			return "redirect:/shareboard/detail?bno=" + bno;
		}
	}


} // ShareboardController

