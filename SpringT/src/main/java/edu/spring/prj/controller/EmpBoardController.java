package edu.spring.prj.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.pageutil.PageMaker;
import edu.spring.prj.service.EmpBoardService;

@Controller
@RequestMapping(value = "/EmpBoard") // url
public class EmpBoardController {
	private static final Logger LOGGER = LoggerFactory.getLogger(EmpBoardController.class);

	@Autowired
	private EmpBoardService empboardService;

	@GetMapping("/employees")
	public void employees(Model model, Integer page, Integer perPage) {
		LOGGER.info("list 호출");
		LOGGER.info("page = " + page + ", perPage = " + perPage);

		// Paging 처리
		PageCriteria criteria = new PageCriteria();
		if (page != null) {
			criteria.setPage(page);
		}
		if (perPage != null) {
			criteria.setNumsPerPage(perPage);
		}

		List<EmpBoardVO> list = empboardService.read(criteria);
		model.addAttribute("EmpBoardList", list);

		PageMaker maker = new PageMaker();
		maker.setCriteria(criteria);
		maker.setTotalCount(empboardService.getTotalNumsOfRecords());
		maker.setPageData();
		model.addAttribute("pageMaker", maker);
	}
	
	@PostMapping("/employees")
	public void employees(String keyword, String select_keyword, String workarea, Model model, RedirectAttributes reAttr,
			Integer page, Integer perPage, HttpServletRequest request) {
		LOGGER.info("recruitsPOST 호출 : keyword = " + keyword + ", select = " + select_keyword);
		LOGGER.info("page = " + page + ", perPage = " + perPage);

		if (select_keyword.equals("userid")) { // userid로 검색
			List<EmpBoardVO> list = empboardService.read(keyword);
			model.addAttribute("EmpBoardList", list);
			LOGGER.info(list.toString());

		} else if (select_keyword.equals("keyword")) { // keyword로 검색
			List<EmpBoardVO> list = empboardService.readByKeyword(keyword);
			model.addAttribute("EmpBoardList", list);
			LOGGER.info(list.toString());
		} else if (select_keyword.equals("address")) { // 지역으로 검색
			List<EmpBoardVO> list = empboardService.readByWorkarea(keyword);
			model.addAttribute("EmpBoardList", list);
			LOGGER.info(list.toString());
		}
		
		// Paging 처리
		PageCriteria criteria = new PageCriteria();
		if (page != null) {
			criteria.setPage(page);
		}
		if (perPage != null) {
			criteria.setNumsPerPage(perPage);
		}

		List<EmpBoardVO> list = empboardService.read(criteria);
		model.addAttribute("EmpBoardList", list);

		PageMaker maker = new PageMaker();
		maker.setCriteria(criteria);
		maker.setTotalCount(empboardService.getTotalNumsOfRecords());
		maker.setPageData();
		model.addAttribute("pageMaker", maker);
	}

	@GetMapping("/empRegister")
	public void empRegisterGET() {
		LOGGER.info("empRegisterGET() 호출");
	} // end registerGET()

	@PostMapping("/empRegister") // 글 등록 jsp(empRegister.jsp)로 프론트를 전송
	public ModelAndView empRegisterPOST(@ModelAttribute(name = "empVO") EmpBoardVO empVO) throws Exception {
		// RedirectAttributes
		// - - 재경로 위치에 속성값을 전송하는 객체
		LOGGER.info("empRegisterPOST() 호출");
		LOGGER.info(empVO.toString());

		ModelAndView mav = new ModelAndView();
		int result = empboardService.create(empVO);
		if (result == 1) {
			mav.setViewName("redirect:employees"); // mav도 empboardservice의 결과 값을 int에 담아서 addflashattribute처럼 사용이 가능한지
													// 여쭤보기
			return mav; // /RecBoard/recruits 경로로 이동;
		} else {
			mav.setViewName("redirect:employees"); // mav도 empboardservice의 결과 값을 int에 담아서 addflashattribute처럼 사용이 가능한지
													// 여쭤보기
			return mav;
		}
	} // end registerPOST()

	@GetMapping("/detail")
	public void detailGET(Integer eno, Model model, @ModelAttribute("page") Integer page) throws Exception {
		LOGGER.info("detail() 호출 : eno = " + eno);
		EmpBoardVO empVO = empboardService.read_by_eno(eno);
		model.addAttribute("EmpBoardVO", empVO);
	} // end detailGET

	@GetMapping("/empDelete")
	public String empDelete(Integer eno) {
		LOGGER.info("empDelete() 호출 : eno = " + eno);
		int result = empboardService.delete(eno);
		if (result == 1) {
			return ("redirect:/EmpBoard/employees");
		} else {
			return ("redirect:/EmpBoard/detail?eno=" + eno);
		}
	} // end delete()
	
	@GetMapping("/myPage")
	public void myPage() {
		LOGGER.info("myPage 호출");
	} // end myPage()

	

}
