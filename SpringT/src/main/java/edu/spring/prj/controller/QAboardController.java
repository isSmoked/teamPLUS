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

import edu.spring.prj.domain.QAboardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.pageutil.PageMaker;
import edu.spring.prj.service.QAboardService;

@Controller
@RequestMapping(value = "/qaboard")
public class QAboardController {
	private static final Logger logger = LoggerFactory.getLogger(QAboardController.class);

	@Autowired
	private QAboardService qaboardService;

	@GetMapping("/list")
	public void list(Model model, Integer page, Integer perPage, HttpServletRequest request, String searchType, String keyword) {
		logger.info("QAboard Controller list 호출");
		logger.info("QAboard Controller page = " + page + ", perPage = " + perPage);
		logger.info("QAboard Controller searchType : " + searchType + ", keyword : " + keyword);

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
		
		logger.info("QAboard Controller criteria set searchType : " + criteria.getSearchType() + ", " + criteria.getKeyword());

		//
		List<QAboardVO> qaboardNotice = qaboardService.selectNotice();
		model.addAttribute("qaboardNotice", qaboardNotice);
		//
		List<QAboardVO> list = qaboardService.read(criteria);
		model.addAttribute("qaboardList", list);

		PageMaker maker = new PageMaker();
		maker.setCriteria(criteria);
		maker.setTotalCount(qaboardService.getTotalNumsOfRecords(criteria));
		maker.setPageData();
		model.addAttribute("pageMaker", maker);

		// tableName Test
		HttpSession session = request.getSession();
		session.setAttribute("tableName", "qaboard_table");
		
		session.setAttribute("searchType", searchType);
		session.setAttribute("keyword", keyword);
	} // end list()

	@GetMapping("/register")
	public void registerGET() {
		logger.info("QAboard Controller registerGET() 호출");
	} // end registerGET()

	@PostMapping("/register")
	public String registerPOST(QAboardVO vo, RedirectAttributes reAttr) {
		// RedirectAttributes
		// - 재경로 위치에 속성값을 전송하는 객체
		logger.info("QAboard Controller registerPOST() 호출");
		logger.info("QAboard Controller register : " + vo.toString());
		int result = qaboardService.create(vo);
		System.out.println();
		if (result == 1) { // DB insert 성공
			// "insert_result"의 키이름을 가진 데이터 전송
			reAttr.addFlashAttribute("resultAlert", "insertSuccess");
			return "redirect:/qaboard/list"; // /board/list 경로로 이동(get)방식
		} else { // DB insert 실패
			reAttr.addFlashAttribute("resultAlert", "insertFail");
			return "redirect:/qaboard/register"; // /board/register 경로로 이동
		}
	}

	@GetMapping("/detail")
	public void detailGET(int bno, Model model, @ModelAttribute("page") int page) {
		logger.info("QAboard Controller detail() 호출 : bno = " + bno);
		QAboardVO vo = qaboardService.read(bno);
		model.addAttribute("qaboardVO", vo);
	}

	@GetMapping("/update")
	public void updateGET(int bno, Model model, @ModelAttribute("page") int page) {
		logger.info("QAboard Controller update() 호출 : bno = " + bno);
		QAboardVO vo = qaboardService.read(bno);
		model.addAttribute("qaboardVO", vo);
	}

	@PostMapping("/update")
	public String updatePOST(QAboardVO vo, int page, RedirectAttributes reAttr) {
		logger.info("QAboard Controller updatePOST() 호출 : bno = " + vo.getQaboard_bno());
		// vo 값이 없음.
		int result = qaboardService.update(vo);
		if (result == 1) {
			reAttr.addFlashAttribute("resultAlert",	"updateSuccess");
			return "redirect:/qaboard/detail?bno=" + vo.getQaboard_bno() + "&page=" + page;
		} else {
			reAttr.addFlashAttribute("resultAlert",	"updateFail");
			return "redirect:/qaboard/update?bno=" + vo.getQaboard_bno();
		}
	}

	@GetMapping("/delete")
	public String delete(int bno, RedirectAttributes reAttr) {
		logger.info("QAboard Controller delete() 호출 : bno = " + bno);
		int result = qaboardService.delete(bno);
		if (result == 1) {
			reAttr.addFlashAttribute("resultAlert", "deleteSuccess");
			return "redirect:/qaboard/list";
		} else {
			reAttr.addFlashAttribute("resultAlert", "deleteFail");
			return "redirect:/qaboard/detail?bno=" + bno;
		}
	}


} // QAboardController
