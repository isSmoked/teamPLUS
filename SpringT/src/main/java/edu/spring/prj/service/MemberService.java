package edu.spring.prj.service;

import edu.spring.prj.domain.MemberVO;

public interface MemberService {
	// 회원가입
	public abstract int create(MemberVO vo);
	
	// 로그인
	public abstract MemberVO login(MemberVO vo);
	
	// Check Ajax ID & Email
	public abstract int checkAjax(MemberVO vo);

	// 로그인 정보 조회
	public abstract MemberVO read(String userid);
	public abstract MemberVO readDetailPersonal(String userid);
	public abstract MemberVO readDetailCompany(String userid);

	// 정보 수정
	public abstract int updateDetailPersonal(MemberVO vo);
	public abstract int updateDetailCompany(MemberVO vo);
	
	// 로그인 정보 수정
	public abstract int updateLoginInfo(MemberVO vo);
	
	// 아이디 찾기
	public abstract String findId(MemberVO vo);
	
	// 비밀번호 찾기 (회원검사)
	public abstract int findPwCheck(MemberVO vo);
		
	// 임시 비밀번호 (이메일전송) 
	public void newPassword(MemberVO vo);
	
}
