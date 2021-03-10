package edu.spring.prj.service;

import java.util.List;

import edu.spring.prj.domain.FreeboardVO;
import edu.spring.prj.domain.ManagerVO;
import edu.spring.prj.domain.MemberVO;

public interface ManagerService {
	// 공지글 변경
	public abstract int updateNotice(FreeboardVO vo);
	// 블랙리스트 추가
	public abstract int updateBlacklist(MemberVO vo);
	// 회원 상세정보
	public abstract MemberVO detail(MemberVO vo);
	// 회원검색
	public abstract List<MemberVO> searchMember(ManagerVO vo);
	// 회원검색 페이징
	public abstract int getTotalNumsOfSearching(ManagerVO vo);
	// 회원삭제
	public abstract int delete(String userid);
	// 관리자등록
	public abstract int registerManager(MemberVO vo);
	
}