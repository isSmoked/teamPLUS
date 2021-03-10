package edu.spring.prj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.spring.prj.domain.BookmarkVO;
import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.domain.QAboardVO;
import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.domain.ShareboardVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.persistence.BookmarkDAO;

@Service
public class BookmarkServiceImple implements BookmarkService {
	private static final Logger logger = LoggerFactory.getLogger(BookmarkServiceImple.class);

	@Autowired
	private BookmarkDAO dao;

	@Override
	public int delete(int bno) {
		logger.info("Service delete() 호출");
		return dao.delete(bno);
	}

	@Override
	public int getTotalNumsOfRecords(String userid) {
		logger.info("Service getTotalNumsOfRecords() 호출");
		return dao.getTotalNumsOfRecords(userid);
	}

	@Override
	public List<BookmarkVO> read(PageCriteria criteria) {
		logger.info("Service read() 호출 : page = " + criteria.getPage());
		return dao.select(criteria);
	}

	@Override
	public int check(BookmarkVO vo) {
		logger.info("Bookmark Service ajaxCheck() CALL");
		return dao.check(vo);
	}

	@Override
	public int ajaxInsert(BookmarkVO vo) {
		logger.info("Bookmark Service ajaxInsert() CALL");
		return dao.ajaxInsert(vo);
	}

	@Override
	public int ajaxDelete(BookmarkVO vo) {
		logger.info("Bookmark Service ajaxDelete()");
		return dao.ajaxDelete(vo);
	}
	
	@Override
	public FreeboardVO freeboardTitle(BookmarkVO vo) {
		logger.info("Bookmark Service title() CALL : freeboard");
		return dao.freeboardTitle(vo);
	}

	@Override
	public QAboardVO qaboardTitle(BookmarkVO vo) {
		logger.info("Bookmark Service title() CALL : qaboard");
		return dao.qaboardTitle(vo);
	}

	@Override
	public ShareboardVO shareboardTitle(BookmarkVO vo) {
		logger.info("Bookmark Service title() CALL : shareboard");
		return dao.shareboardTitle(vo);
	}


	@Override
	public RecBoardVO recruitTitle(BookmarkVO vo) {
		logger.info("Bookmark Service title() CALL : shareboard");
		return dao.recruitTitle(vo);
	}

	@Override
	public EmpBoardVO employTitle(BookmarkVO vo) {
		logger.info("Bookmark Service title() CALL : shareboard");
		return dao.employTitle(vo);
	}

	

}
