package edu.spring.prj.controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.spring.prj.domain.ChatVO;
import edu.spring.prj.domain.MemberVO;
import edu.spring.prj.email.Email;
import edu.spring.prj.email.EmailSender;
import edu.spring.prj.service.ChatService;
import edu.spring.prj.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private ChatService chatService;
	
	/* 회원가입 */
	@GetMapping("/register")
	public void registerGET() {
		logger.info("Member Controller registerGET() 호출");
	} // end registerGET()

	@PostMapping("/register")
	public String registerPOST(@Valid MemberVO vo, BindingResult br, RedirectAttributes reAttr) {
		logger.info("Member Controller registerPOST() 호출");
		logger.info(vo.toString());
		String userid = vo.getUserid();
		
		if(br.hasErrors()) { 
			logger.info("Member Controller BindingResult has errors");
			return "member/register"; 
		} else { 
			logger.info("Member Controller idCheck 사용 가능 아이디.");
			memberService.create(vo);
			vo.setPassword(null);
			reAttr.addFlashAttribute("registerVO", vo);

			// 채팅 테이블 생성
			ChatVO cvo = new ChatVO(0, " ", userid);
			chatService.create(cvo);
			return "redirect:/member/register-result";
		}
	} // registerPOST()
	
	/* 회원가입 결과확인 */
	@GetMapping("/register-result")
	public void registerResult() {
		logger.info("Member Controller registerResult() 호출");
	} // registerResult()


	/* ajax 아이디, 이메일 중복확인 */
    @ResponseBody
    @RequestMapping(value = "/checkAjax")
    public int checkAjax(MemberVO vo) {
  	    logger.info("Member Controller checkAjax start");
	    logger.info("Member Controller checkAjax : " + vo.toString());
	    return memberService.checkAjax(vo);
    } // checkAjax()

	
	/* 로그인 */
	@GetMapping("/login")
	public void loginGet(Model model, HttpServletRequest request) {
		logger.info("Member Controller - loginGet() 호출");
		String referer = request.getHeader("referer");
		logger.info("Member Controller - loginGet() referer : " + referer);
		model.addAttribute("targetUrl", referer);
		model.addAttribute("loginResult", null);
	} // loginGet()

	@PostMapping("/login-post")
	public void loginPost(MemberVO vo, Model model, HttpServletRequest request) {
		logger.info("Member Controller - loginPost() 호출");
		MemberVO loginVO = memberService.login(vo);
		logger.info("Member Controller - loginPost() loginVO : " + loginVO);
		String result = null;
		String part = null;
		if (loginVO != null) {
			result = loginVO.getUserid();
			part = loginVO.getPart();
			int blacklist = loginVO.getBlacklist();
			logger.info(">>> 아이디 비밀번호가 일치합니다.");
			logger.info("result : " + result);
			model.addAttribute("result", result);
			model.addAttribute("part", part);
			model.addAttribute("blacklist", blacklist);
			
			HttpSession session = request.getSession();
			ChatVO cvo = chatService.read(result);
			logger.info("cvo = " + cvo);
			session.setAttribute("chatBno", cvo.getChat_bno());
			logger.info("chatBno = " + cvo.getChat_bno());
		}
	} // loginPost()

	/* 로그아웃 */
	@RequestMapping(value = "/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info(">>> Member Controller logout() 호출");
		HttpSession session = request.getSession();
		String referer = request.getHeader("referer");
		logger.info("Member Controller referer : " + referer);
		Object check = session.getAttribute("loginId");
		int chatBno = (Integer)session.getAttribute("chatBno");
		ChatVO cvo = chatService.read(chatBno);
		cvo.setChat_content(" ");
		
		if (check != null) {
			session.removeAttribute("loginId");
			session.removeAttribute("part");
			session.removeAttribute("blacklist");
			session.removeAttribute("tableName");
			session.setAttribute("loginResult", "logout");
			session.removeAttribute("chatBno");
//			response.sendRedirect(referer);
			response.sendRedirect("/prj/RecBoard/main");
		} else {
			response.sendRedirect(referer);
		}
	} // logout()

	
	/* 로그인 정보 수정 */
    @ResponseBody
    @RequestMapping(value = "/updateLoginInfo")
    public int updateLoginInfo(MemberVO vo) {
  	    logger.info("Member Controller updateLoginInfo start");
	    logger.info("Member Controller updateLoginInfo : " + vo.toString());
	    return memberService.updateLoginInfo(vo);
    } // updateLoginInfo()
    

	/* 개인회원페이지 */
	@RequestMapping(value = "/detail-personal")
	public void detailPersonal(Model model, HttpServletRequest request) {
		// member_table 로그인 정보 불러오기
		HttpSession session = request.getSession();
		
		// loginId 정보 가져오기
		String loginId = session.getAttribute("loginId").toString();
		MemberVO loginVO = memberService.read(loginId);
		model.addAttribute("loginVO", loginVO);

		// part 정보 가져오기
		String loginPart = session.getAttribute("part").toString();
		logger.info("Member Controller detailPersonal part : " + loginPart);

		// tableName (확인용)
		session.setAttribute("tableName", "detail_personal_table");
		
		// detail_personal_table 정보 불러오기
		if (loginPart.equals("personal")) {
			logger.info("Member Controller detailPersonal 호출 : userid = " + loginId);
			MemberVO personalVO = memberService.readDetailPersonal(loginId);
			
			model.addAttribute("personalVO", personalVO);
		}
	} // detailPersonal

	/* ajax 개인정보 수정 */
	@ResponseBody
	@PostMapping("/updateDetailPersonal")
	public int updateDetailPersonal(MemberVO vo) {
		logger.info("Member Contoller updateDetailPersonal 호출");
		logger.info(vo.toString());
		return memberService.updateDetailPersonal(vo);
	} // updateDetailPersonal

	
	/* 기업회원페이지 */
	@RequestMapping(value = "/detail-company")
	public void detailCompany(String userid, Model model, HttpServletRequest request) {
		// member_table 로그인 정보 불러오기
		HttpSession session = request.getSession();
		String loginId = session.getAttribute("loginId").toString();
		MemberVO loginVO = memberService.read(loginId);
		model.addAttribute("loginVO", loginVO);

		// part 정보 섹션에 저장
		String loginPart = session.getAttribute("part").toString();
		logger.info("part : " + loginPart);
		
		// tableName (확인용)
		session.setAttribute("tableName", "detail_company_table");

		// detail_company_table 정보 불러오기
		if (loginPart.equals("company")) {
			logger.info("Member Controller /detailCompany 호출 : userid = " + loginId);
			MemberVO companyVO = memberService.readDetailCompany(loginId);
			logger.info(companyVO.toString());
			model.addAttribute("companyVO", companyVO);
		}
	} // detailCompany

	/* ajax 기업정보 수정 */
	@ResponseBody
	@PostMapping("/updateDetailCompany")
	public int updateDetailCompany(MemberVO vo) {
		logger.info("Member Controller updateDetailCompany 호출");
		logger.info(vo.toString());
		return memberService.updateDetailCompany(vo);
	} // updateDetailComapny

	/* 아이디 찾기 */
	@RequestMapping(value = "/find-id")
	public void findId() {
		logger.info("아이디 찾기 새 창 띄우기");
	} // findId()

	@PostMapping("/postFindId")
	public String postFindId(MemberVO vo, RedirectAttributes reAttr) {
		// member -> userid
		logger.info("아이디 찾기 시작");
		String result = memberService.findId(vo);
		logger.info("찾은 아이디는? : " + result);
		if (result != null) {
			reAttr.addFlashAttribute("id", result);
			return "redirect:/member/find-id";
		} else {
			reAttr.addFlashAttribute("id", null);
			return "redirect:/member/find-id";
		}
	} // postFindId()
	
	    
	/* 비밀번호 찾기 */
	@RequestMapping(value = "/find-pw")
	public void findPw() {
		logger.info("비밀번호 찾기 새 창 띄우기");
	} // findPw()
	
	@PostMapping("/findPassword")
	public String postFindPw(MemberVO vo, RedirectAttributes reAttr, HttpSession session, HttpServletResponse resp) {
		logger.info("비밀번호 찾기 회원검색 시작");
		int result = memberService.findPwCheck(vo);
		
		logger.info("비밀번호 찾기 result : " + result);
		if (result == 1) {
			logger.info("비밀번호 찾기 회원정보 확인됨 : " + vo.getEmail().toString());
			// 임시비밀번호 생성
			logger.info("임시비밀번호 생성 시작");
			Random r = new Random();
			int num = r.nextInt(89999) + 10000;
			String npassword = "pw" + Integer.toString(num);// 새로운 비밀번호 변경
			vo.setPassword(npassword);
			session.setAttribute("memberVO", vo);
			memberService.newPassword(vo);
			logger.info("새로운 비밀번호 끝");
			return "redirect:/member/sendPwEmail";
		} else {
			logger.info("비밀번호 찾기 회원없음.");
			// 회원없음 표시해주기
			reAttr.addFlashAttribute("findPwCheck", "fail");
			return "redirect:/member/find-pw";
		}
	} // postFindPw()
	    
		  
	  /* 비밀번호 찾기(메일보내기) */
	  @Autowired
	  private Email email;
	  @Autowired
	  private EmailSender emailSender;
	  
	  // 이메일로 비밀번호가 전송이된다.
	  @RequestMapping("/sendPwEmail")
	  public String sendPwEmail(MemberVO vo, HttpSession session) throws Exception {
		  logger.info("이메일 보내기 시작");
		  vo = (MemberVO) session.getAttribute("memberVO");
		  email.setContent("새로운 비밀번호 " + vo.getPassword() + " 입니다.");
		  email.setReceiver(vo.getEmail());
		  email.setSubject("비밀번호 찾기 : "+vo.getUserid() +"님  재설정된 비밀번호를 확인해주세요");
		  emailSender.SendEmail(email);
		  session.invalidate();
		  return "redirect:/member/find-pw-result";
	  } // sendPwEmail()
	  
	  @RequestMapping("/find-pw-result")
	  public void findPwResult() {
		  logger.info("비밀번호 찾기 메일전송 완료");
	  } // findPwResult()

		/* 관리자페이지 */
		@RequestMapping(value = "/detail-manager")
		public void detailManager(String userid, Model model, HttpServletRequest request) {
			// member_table 로그인 정보 불러오기
			HttpSession session = request.getSession();
			String loginId = session.getAttribute("loginId").toString();
			MemberVO loginVO = memberService.read(loginId);
			model.addAttribute("loginVO", loginVO);

			// part 정보 섹션에 저장
			String loginPart = session.getAttribute("part").toString();
			logger.info("part : " + loginPart);
			
			// tableName (확인용)
			session.setAttribute("tableName", "member_table");
		} // detailCompany

} // MemberController