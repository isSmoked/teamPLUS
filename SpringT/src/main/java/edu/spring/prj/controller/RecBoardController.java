package edu.spring.prj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.pageutil.PageMaker;
import edu.spring.prj.service.RecBoardService;

@Controller
@RequestMapping(value ="/RecBoard") // url : /prj/
public class RecBoardController {
	private static final Logger LOGGER = 
			LoggerFactory.getLogger(RecBoardController.class);
	
	@Autowired
	private RecBoardService recboardService;
	
	
	
	@GetMapping("/main")
	public void mainGET() {
		LOGGER.info("mainGET() �샇異�");
	} // end mainGET()
	
	// 寃뚯떆湲� �쟾泥� 異쒕젰
	@GetMapping("/recruits")
	public void recruits(Model model, Integer page, Integer perPage) {
			LOGGER.info("list �샇異�");
			LOGGER.info("page = " + page + ", perPage = " + perPage);
			
			// Paging 泥섎━
			PageCriteria criteria = new PageCriteria();
			if (page != null) {
				criteria.setPage(page);
			}
			if (perPage != null) { 
				criteria.setNumsPerPage(perPage);
			}
			
			List<RecBoardVO> list = recboardService.read(criteria);
			model.addAttribute("RecBoardList", list);
			
			PageMaker maker = new PageMaker();
			maker.setCriteria(criteria);
			maker.setTotalCount(recboardService.getTotalNumsOfRecords());
			maker.setPageData();
			model.addAttribute("pageMaker", maker);
	} // end recruitsGET()
	
	@PostMapping("/recruits")
	public void recruitsPost(String keyword, String select_keyword, String workarea, Model model, RedirectAttributes reAttr,
			Integer page, Integer perPage, HttpServletRequest request) {
		LOGGER.info("recruitsPOST �샇異� : keyword = " + keyword + ", select = " + select_keyword);
		
		LOGGER.info("page : " + page);
		if (select_keyword.equals("userid")) { // userid濡� 寃��깋
			List<RecBoardVO> list = recboardService.read(keyword);
			model.addAttribute("RecBoardList", list);
			LOGGER.info(list.toString());

		} else if (select_keyword.equals("keyword")) { // keyword濡� 寃��깋
			List<RecBoardVO> list = recboardService.readByKeyword(keyword);
			model.addAttribute("RecBoardList", list);
			LOGGER.info(list.toString());
		} else if (select_keyword.equals("work_area")) { // 吏��뿭�쑝濡� 寃��깋
			List<RecBoardVO> list = recboardService.readByWorkarea(keyword);
			model.addAttribute("RecBoardList", list);
			LOGGER.info(list.toString());
		}
		
		// Page 泥섎━
				PageCriteria criteria = new PageCriteria();
				if (page != null) {
					criteria.setPage(page);
				}
				if (perPage != null) {
					criteria.setNumsPerPage(perPage);
				}
				
				PageMaker maker = new PageMaker();
				maker.setCriteria(criteria);
				maker.setTotalCount(recboardService.getTotalNumsOfRecords());
				maker.setPageData();
				model.addAttribute("pageMaker", maker);
				
				HttpSession session = request.getSession();
				session.setAttribute("keyword", keyword);
				session.setAttribute("select_keyword", select_keyword);
	}
	
	// 湲� �벑濡�
	@GetMapping("/register.do")
	public void registerGET() {
		LOGGER.info("registerGET() �샇異�");
	} // end registerGET()
	
	@PostMapping("/register") // 湲� �벑濡� jsp(register.jsp)濡� �봽濡좏듃瑜� �쟾�넚
	public String registerPOST(RecBoardVO vo, RedirectAttributes reAttr) throws Exception {
		// RedirectAttributes 
		// - - �옱寃쎈줈 �쐞移섏뿉 �냽�꽦媛믪쓣 �쟾�넚�븯�뒗 媛앹껜
		LOGGER.info("registerPOST() �샇異�");
		LOGGER.info(vo.toString());
		
		
		int result = recboardService.create(vo);
		System.out.println();
		if(result == 1) { // DB insert �꽦怨�
			// "insert_result"�쓽 �궎�씠由꾩쓣 媛�吏� �뜲�씠�꽣 �쟾�넚 
			reAttr.addFlashAttribute("insert_result", "success");
			return "redirect:/RecBoard/recruits"; // /RecBoard/recruits 寃쎈줈濡� �씠�룞(get)諛⑹떇
		} else { // DB insert �떎�뙣
			reAttr.addFlashAttribute("insert_result", "fail");
			return "redirect:/RecBoard/recruits"; // /RecBoard/recruits 寃쎈줈濡� �씠�룞
		}
	} // end registerPOST()
	
	// 寃뚯떆湲� �긽�꽭 議고쉶
	@GetMapping("/detail")
	public void detailGET(int bno, 
			Model model, 
			@ModelAttribute("page") int page) throws Exception {
		LOGGER.info("detail() �샇異� : rno = " + bno);
		RecBoardVO vo = recboardService.read_by_rno(bno);
		model.addAttribute("RecBoardVO", vo);
	} // end detailGET
	
	// 湲� �궘�젣
	@GetMapping("/delete")
	public String delete(int rno) {
		LOGGER.info("delete() �샇異� : rno = " + rno);
		int result = recboardService.delete(rno);
		if(result == 1) {
			return("redirect:/RecBoard/recruits");
		} else {
			return("redirect:/RecBoard/detail?rno=" + rno);
		}
	} // end delete()
	
	/*
	 * @PostMapping("/recruits") public ModelAndView list(@RequestParam(defaultValue
	 * = "recruitTitle") String searchOption,
	 * 
	 * @RequestParam(defaultValue = "") String keyWord, Integer page, Integer
	 * perPage) { LOGGER.info("recList.do �샇異�"); List<RecBoardVO> list =
	 * recboardService.listAll(searchOption, keyWord);
	 * 
	 * // Paging 泥섎━ PageCriteria criteria = new PageCriteria(); if (page != null) {
	 * criteria.setPage(page); } if (perPage != null) {
	 * criteria.setNumsPerPage(perPage); }
	 * 
	 * // �젅肄붾뱶�쓽 媛쒖닔 int count = recboardService.countArticle(searchOption, keyWord);
	 * 
	 * // 紐⑤뜽怨� 酉� ModelAndView mav = new ModelAndView();
	 * 
	 * // �뜲�씠�꽣瑜� 留듭뿉 ���옣 Map<String, Object> map = new HashMap<String, Object>();
	 * map.put("list", list); map.put("count", count); // �젅肄붾뱶�쓽 媛쒖닔
	 * map.put("searchOption", searchOption); // 寃��깋�샃�뀡 map.put("keyWord", keyWord);
	 * // 寃��깋�궎�썙�뱶 mav.addObject("map", map); // 留듭뿉 ���옣�맂 �뜲�씠�꽣瑜� mav�뿉 ���옣
	 * mav.setViewName("/recruits");
	 * 
	 * PageMaker maker = new PageMaker(); maker.setCriteria(criteria);
	 * maker.setTotalCount(recboardService.getTotalNumsOfRecords());
	 * maker.setPageData(); mav.addObject("pageMaker", maker); return mav; } // end
	 * myPage()
	 */	
	
}	












