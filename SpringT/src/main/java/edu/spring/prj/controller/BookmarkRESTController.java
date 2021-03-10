package edu.spring.prj.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.spring.prj.domain.BookmarkVO;
import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.domain.QAboardVO;
import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.domain.ShareboardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.pageutil.PageMaker;
import edu.spring.prj.service.BookmarkService;

@RestController
@RequestMapping(value = "*/bookmark")
public class BookmarkRESTController {
	private static final Logger logger = LoggerFactory.getLogger(BookmarkRESTController.class);

	@Autowired
	private BookmarkService bookmarkService;

	/* ********* 게시판에서 찜 버튼 클릭시 ********* */
	/* 북마크 확인 */
	@PostMapping("/check")
	public ResponseEntity<Integer> ajaxCheck(BookmarkVO vo) {
		logger.info("bookmark ajax check start");
		logger.info(vo.toString());
		int result = bookmarkService.check(vo);
		logger.info("result : " + result);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	} // Bookmark ajaxCheck

	/* 북마크 설정 */
	@PostMapping("/insert")
	public ResponseEntity<Integer> ajaxInsert(BookmarkVO vo) {
		logger.info("Bookmark ajax insert start");
		logger.info(vo.toString());
		int result = bookmarkService.ajaxInsert(vo);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	} // bookmark ajaxInsert

	/* 북마크 취소 */
	@PostMapping("/delete")
	public ResponseEntity<Integer> ajaxDelete(BookmarkVO vo) {
		logger.info("Bookmark ajax delete start");
		logger.info(vo.toString());
		int result = bookmarkService.ajaxDelete(vo);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	} // bookmark ajaxDelete
	
	
	/* ********* Bookmark list ********* */
	/* 리스트 불러오기 */
	@GetMapping("/list")
	public ResponseEntity<List<BookmarkVO>> bookmarkList(Integer page, Integer perPage, String loginId, HttpServletRequest request){
		logger.info("BookmarkRESTController bookmarkList() 호출");
		logger.info("BookmarkRESTController page = " + page + ", perPage = " + perPage + ", loginId : " + loginId);
		// Paging 처리
		PageCriteria criteria = new PageCriteria();
		criteria.setUserid(loginId);
		if (page != null) {
			criteria.setPage(page);
		}
		if (perPage != null) {
			criteria.setNumsPerPage(perPage);
		}
		List<BookmarkVO> list = bookmarkService.read(criteria);
		for (BookmarkVO i : list) {
			String title = null;
			String writer = null;
			if (i.getBookmark_table_name().equals("freeboard_table")) {
				FreeboardVO vo = bookmarkService.freeboardTitle(i);
				if (vo != null) {
					title = vo.getFreeboard_title();
					writer = vo.getUserid();
				}
			} else if (i.getBookmark_table_name().equals("qaboard_table")) {
				QAboardVO vo = bookmarkService.qaboardTitle(i);
				if (vo != null) {
					title = vo.getQaboard_title();
					writer = vo.getUserid();
				}
			} else if (i.getBookmark_table_name().equals("shareboard_table")) {
				ShareboardVO vo = bookmarkService.shareboardTitle(i);
				if (vo != null) {
					title = vo.getShareboard_title();
					writer = vo.getUserid();
				}
			} else if (i.getBookmark_table_name().equals("recruit_table")) {
				RecBoardVO vo = bookmarkService.recruitTitle(i);
				if (vo != null) {
					title = vo.getRecruit_title();
					writer = vo.getUserid();
				}
			} else if (i.getBookmark_table_name().equals("employ_table")) {
				EmpBoardVO vo = bookmarkService.employTitle(i);
				if (vo != null) {
					title = vo.getEmploy_title();
					writer = vo.getUserid();
				}
			}
			i.setBookmark_title(title);
			i.setBookmark_writer(writer);
		}
		return new ResponseEntity<List<BookmarkVO>>(list, HttpStatus.OK);
	} // bookmarkList
	
	/* 페이징 */
	@GetMapping("/paging")
	public ResponseEntity<PageMaker> panging(Integer page, Integer perPage, String userid){
		logger.info("BookmarkRESTController paging Call");
		PageMaker maker = new PageMaker();
		PageCriteria criteria = new PageCriteria();
		if (page != null) {
			criteria.setPage(page);
		}
		if (perPage != null) {
			criteria.setNumsPerPage(perPage);
		}
		maker.setCriteria(criteria);
		maker.setTotalCount(bookmarkService.getTotalNumsOfRecords(userid));
		maker.setPageData();
		return new ResponseEntity<PageMaker>(maker, HttpStatus.OK);
	} // paging
	
	/* Bookmark 게시판에서 삭제 */
	@GetMapping("/deleteBookmark")
	public ResponseEntity<Integer> delete(Integer n) {
		logger.info("BookmarkRESTController delete start");
		int result = bookmarkService.delete(n);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	} // delete 
	
	/* Dead List 삭제 */
	@GetMapping("/deleteDeadList")
	public ResponseEntity<Integer> deleteDeadList(String loginId) {
		logger.info("BookmarkRESTController deleteDeadList() 호출");
		logger.info("BookmarkRESTController loginId : " + loginId);
		PageCriteria criteria = new PageCriteria();
		criteria.setUserid(loginId);
		List<BookmarkVO> list = bookmarkService.read(criteria);
		ArrayList<Integer> deadList = new ArrayList<Integer>();
		for (BookmarkVO i : list) {
			if (i.getBookmark_table_name().equals("freeboard_table")) {
				FreeboardVO vo = bookmarkService.freeboardTitle(i);
				if (vo == null) {
					deadList.add(Integer.parseInt(i.getBookmark_no()));
				}
			} else if (i.getBookmark_table_name().equals("qaboard_table")) {
				QAboardVO vo = bookmarkService.qaboardTitle(i);
				if (vo == null) {
					deadList.add(Integer.parseInt(i.getBookmark_no()));
				}
			} else if (i.getBookmark_table_name().equals("shareboard_table")) {
				ShareboardVO vo = bookmarkService.shareboardTitle(i);
				if (vo == null) {
					deadList.add(Integer.parseInt(i.getBookmark_no()));
				}
			}  else if (i.getBookmark_table_name().equals("recruit_table")) {
				RecBoardVO vo = bookmarkService.recruitTitle(i);
				if (vo == null) {
					deadList.add(Integer.parseInt(i.getBookmark_no()));
				}
			} else if (i.getBookmark_table_name().equals("employ_table")) {
				EmpBoardVO vo = bookmarkService.employTitle(i);
				if (vo == null) {
					deadList.add(Integer.parseInt(i.getBookmark_no()));
				}
			}
		} // for find dead no
		logger.info("deadList : " + deadList);
		int result = 0;
		for (int s : deadList) {
			result += bookmarkService.delete(s);
		} // delete dead list
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	} // deleteDeadList

} // BookmarkRESTController
