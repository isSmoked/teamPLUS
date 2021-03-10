package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.BookmarkVO;
import edu.spring.prj.domain.EmpBoardVO;
import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.domain.QAboardVO;
import edu.spring.prj.domain.RecBoardVO;
import edu.spring.prj.domain.ShareboardVO;
import edu.spring.prj.pageutil.PageCriteria;

public interface BookmarkService {
	// 북마크 게시판 삭제
	public abstract int delete(int bno);
	// 페이지
	public abstract int getTotalNumsOfRecords(String userid);
	public abstract List<BookmarkVO> read(PageCriteria criteria);
	// 북마크 ajax 중복확인 
	public abstract int check(BookmarkVO vo);
	// 북마크 ajax 입력
	public abstract int ajaxInsert(BookmarkVO vo);
	// 북마크 ajax 삭제
	public abstract int ajaxDelete(BookmarkVO vo);
	// 제목 가져오기
	public abstract FreeboardVO freeboardTitle(BookmarkVO vo);
	public abstract QAboardVO qaboardTitle(BookmarkVO vo);
	public abstract ShareboardVO shareboardTitle(BookmarkVO vo);
	public abstract RecBoardVO recruitTitle(BookmarkVO vo);
	public abstract EmpBoardVO employTitle(BookmarkVO vo);
	 
}