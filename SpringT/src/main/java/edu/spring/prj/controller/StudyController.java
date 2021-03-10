package edu.spring.prj.controller;

import java.util.List;

import javax.servlet.ServletRequest;
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

import edu.spring.prj.domain.StudyVO;
import edu.spring.prj.pageutil.PageCriteria;
import edu.spring.prj.pageutil.PageMaker;
import edu.spring.prj.service.StudyService;


@Controller
@RequestMapping(value = "/studyBoard")
public class StudyController {
	private static final Logger logger 
			= LoggerFactory.getLogger(StudyController.class);

	@Autowired
	private StudyService studyService;
	
	/* 페이징 처리 */
	@GetMapping("/list")
	public void list(Model model, Integer page, Integer perPage, 
			String keyword, String select) {
		logger.info("list 호출");
		logger.info("page = " + page + ", perPage = " + perPage);

		// Page 처리
		PageCriteria criteria = new PageCriteria();
		if (page != null) {
			criteria.setPage(page);
		}
		if (perPage != null) {
			criteria.setNumsPerPage(perPage);
		}

		List<StudyVO> list = studyService.read(criteria);

		model.addAttribute("boardList", list);

		logger.info(list.toString());
		
		logger.info("page = " + page);
		PageMaker maker = new PageMaker();
		maker.setCriteria(criteria);
		maker.setTotalCount(studyService.getTotalNumsofRecords());
		maker.setPageData();
		model.addAttribute("pageMaker", maker);
	}

	
	@PostMapping("/list")
	public void listPOST(String keyword, String select_keyword, Model model, RedirectAttributes reAttr
			, Integer page, Integer perPage, HttpServletRequest request) {
		logger.info("listPOST-Search 호출 : keyword = " + keyword + ", select = " + select_keyword);
		
		logger.info("page : " + page);
		if (select_keyword.equals("userid")) { // userid로 검색
			List<StudyVO> list = studyService.read(keyword);
			model.addAttribute("boardList", list);
			logger.info(list.toString());

		} else if (select_keyword.equals("keyword")) { // keyword로 검색
			List<StudyVO> list = studyService.readByKeyword(keyword);
			model.addAttribute("boardList", list);
			logger.info(list.toString());
			
		} else if (select_keyword.equals("location")) { // 지역으로 검색
			List<StudyVO> list = studyService.readByLocation(keyword);
			model.addAttribute("boardList", list);
			logger.info(list.toString());
		}
		
		// Page 처리
		PageCriteria criteria = new PageCriteria();
		if (page != null) {
			criteria.setPage(page);
		}
		if (perPage != null) {
			criteria.setNumsPerPage(perPage);
		}
		
		PageMaker maker = new PageMaker();
		maker.setCriteria(criteria);
		maker.setTotalCount(studyService.getTotalNumsofRecords());
		maker.setPageData();
		model.addAttribute("pageMaker", maker);
		
		HttpSession session = request.getSession();
		session.setAttribute("keyword", keyword);
		session.setAttribute("select_keyword", select_keyword);
	}

	/* register ------------------------------------------------ */
	// register.jsp를 GET방식으로 불러오기
	@GetMapping("/register")
	public void registerGET() {
		logger.info("registerGET() 호출");

	}

	// register.jsp를 POST방식으로 보내는 메소드
	@PostMapping("/register")
	public String registerPOST(StudyVO vo, RedirectAttributes reAttr, HttpServletRequest request) {
		logger.info("registerPOST() 호출");
		logger.info(vo.toString());

		vo.setStudy_crew_black(" ");
		vo.setStudy_crew_user(vo.getStudy_userid());
		vo.setStudy_crew_count(Integer.parseInt("1"));
		
		int result = studyService.create(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("insert_result", "success");
			return "redirect:/studyBoard/list";
		} else {
			reAttr.addFlashAttribute("insert_result", "fail");
			return "redirect:/studyBoard/list";
		}
	}

	/* detail -------------------------------------------------- */
	@GetMapping("/detail")
	public void detailGET(Integer bno, Model model, @ModelAttribute("page") int page) {
		logger.info("detail() 호출 : bno = " + bno);
		
		// 등록된 글의 작성자
		StudyVO vo = studyService.read(bno);	// vo에 값 전달 완료
		logger.info(vo.toString());
		model.addAttribute("studyVO", vo);
		
		// 글 작성자의 이름을 세션으로 보내기
//		HttpSession session = request.getSession(); // 세션 생성
//		session.setAttribute("makerUserid", arr[0]);
//		logger.info("makerUserid : " + arr[0]);
		
		int result = studyService.updateReadCount(bno);
		
		if (result == 1) {
			logger.info("조회수 증가 성공 : readcount = " + vo.getStudy_readcount());
		} else {
			logger.info("조회수 증가 실패");
		}
		
	}
	
	@GetMapping("/detail-admin")
	public void detailAdminGET(Integer bno, Model model, @ModelAttribute("page") int page) {
		logger.info("detail-admin() 호출 : bno = " + bno);
		
		// 등록된 글의 작성자
		StudyVO vo = studyService.read(bno);
		logger.info(vo.toString());
		model.addAttribute("studyVO", vo);
		String attendUserid = vo.getStudy_crew_user();
		String arr[] = attendUserid.split(",");
		logger.info("해당 글 작성자 userid : " + arr[0]);
		
		logger.info("detail-adimin() 정상 호출 완료");
	}

	/* update -------------------------------------------------- */
	// update.jsp를 GET방식으로 불러오기
	@GetMapping("/update")
	public void updateGET(Integer bno, Model model, @ModelAttribute("page") int page) {
		logger.info("update() 호출 : bno = " + bno);
		StudyVO vo = studyService.read(bno);
		model.addAttribute("studyVO", vo);
	}

	// update.jsp를 POST방식으로 불러오기
	@PostMapping("/update")
	public String updatePOST(StudyVO vo, Integer page, RedirectAttributes reAttr) {
		logger.info("updatePOST() 호출 : bno = " + vo.getStudy_bno());
		int result = studyService.update(vo);
		if (result == 1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:/studyBoard/detail-admin?bno=" + vo.getStudy_bno() + "&page=" + page;
			// page로 입력되었을 때, 정상 작동 / bno를 받아서 detail로 이동 불가
		} else {
			logger.info("update() 실패");
			reAttr.addFlashAttribute("update_result", "fail");
			return "redirect:/studyBoard/update?bno=" + vo.getStudy_bno();
		}
	}

	/* delete -------------------------------------------------- */
	@GetMapping("/delete")
	public String delete(Integer bno, RedirectAttributes reAttr) {
		logger.info("delete() 호출 : bno = " + bno);
		
		int result = studyService.delete(bno);
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/studyBoard/list";
		} else {
			reAttr.addFlashAttribute("delete_result", "fail");
			return "redirect:/studyBoard/detail?bno=" + bno;
		}
	}
	
	

	 
	  /* 참가 attend ---------------------------------------------- */
	  // 받아온 userid를 대기명단에 추가!
	  // member = 현재 멤버 수 / userid = 참가자 / bno = studybno
	  @GetMapping("/attend") 
	  public String attend(
			  RedirectAttributes reAttr, String userid, Integer bno,
			  @ModelAttribute("page") int page){ 
		  int result = 0;
		  boolean attendOverlap = false;
		  boolean waitOverlap = false;
		  logger.info("userid = " + userid);
		  StudyVO vo = studyService.read(bno);							// bno로 가져온 해당 게시글의 vo
		  
		  // userid와 studyCrewUser를 비교 > 중복되면 모임에 참가할 수 없도록
		  String users[] = vo.getStudy_crew_user().split(",");
		  for (int i = 0; i < users.length; i++) {
			  if (userid.equals(users[i])) {
				  attendOverlap = true;    // 아이디 중복!
			  }
		  }
		  logger.info("attend() 아이디 중복 test 결과 - " + attendOverlap);
		  
		  // userid와 studyCrewWait을 비교
		  String usersArr[] = vo.getStudy_crew_wait().split(",");
		  for (int i = 0; i < usersArr.length; i++) {
			  if (userid.equals(usersArr[i])) {
				  waitOverlap = true;
			  }
		  }
		  logger.info("attend() 아이디 중복 test 결과 - " + waitOverlap);
		  
		  // service.updateCrewWait - bno / studyCrewWait
		  if (attendOverlap == false && waitOverlap == false) {
			  if (vo.getStudy_crew_wait().equals("0")) {
				  vo.setStudy_crew_wait(userid);
			  } else {
				  vo.setStudy_crew_wait(vo.getStudy_crew_wait() + "," + userid);
			  }
			  
			  result = studyService.updateCrewWait(vo);
			  logger.info(vo.toString());
			  logger.info("attend() - result = " + result);
		  }
		   
		  if (result == 1 && attendOverlap == false && waitOverlap == false) { /* detail.jsp 알림출력하기 */ /* detail.jsp 버튼 보이기 처리 */
			  reAttr.addFlashAttribute("attend_result", "success"); 
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  } else if (attendOverlap == true) {		// 아이디 중복으로 참가 실패!
			  reAttr.addFlashAttribute("attend_result", "attendOverlap"); 
			  logger.info("이미 참가된 이용자!");
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  } else if (waitOverlap == true) {
			  reAttr.addFlashAttribute("attend_result", "waitOverlap");
			  logger.info("이미 참가등록한 이용자!");
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  } else { 			// 데이터상 오류로 참가 실패
			  reAttr.addFlashAttribute("attend_result", "fail");
			  logger.info("데이터상 오류로 참가 실패");
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  }
	  } 
	 
	  // 대기 > 참여자
	  @GetMapping("/attend-wait")
	  public String attendWait(Integer member,
			  RedirectAttributes reAttr, String userid, Integer bno,
			  @ModelAttribute("page") int page){ 
		  int result;
		  logger.info("attendWait() 호출 userid - " + userid);
		  
		  StudyVO vo = studyService.read(bno);
		  
		  // vo의 참여인수(member) 증가 / userid는 대기명단에서 받아온다.
		 
		  
		  logger.info(vo.toString());
		  
		  String crewWaiter = vo.getStudy_crew_wait(); 			// 대기자명단 초기화용
		  String arrWaiter[] = crewWaiter.split(",");
		  int attendNum = arrWaiter.length;
		  
		  /* crewWaiter의 명단에서 참가자의 아이디를 지우고,
		   * crewUser에 참가자의 아이디를 추가 시킨다. (V)
		   *  */
		  
		  
		  
		  logger.info("arr[i] - ");
		  for (int i = 0; i < arrWaiter.length; i++) {
			  System.out.println(arrWaiter[i]);
		  }
		  
		  // 이미 모임에 등록된 이용자인지 확인
		  int count = 0;
		  String arrCrewUser[] = vo.getStudy_crew_user().split(",");
		  for (int i = 0; i < arrCrewUser.length; i++) {
			  logger.info("arr[" + i + "] = " + arrCrewUser[i]);
			  if (arrCrewUser[i].equals(userid)) { // 이미 모임에 들어가있는 이용자 - count
				  count = 1;
				  logger.info("count-userid - " + userid);
				  break;
			  }
		  }
		  
		  // crewWaiter에서 참가된 이용자의 아이디를 삭제
		  if (vo.getStudy_crew_wait().split(",").length > 1 || count != 1) {
			  crewWaiter = crewWaiter.replace(userid + ",", ""); // 맨앞 - 맨끝 전에 있으면 변환
			  crewWaiter = crewWaiter.replace(userid , "0");	 // 맨끝에 있으면 변환
		  } else if (vo.getStudy_crew_wait().split(",").length == 1 || count != 1) {
			  crewWaiter = crewWaiter.replace(userid, "0");
		  }
		  
		  logger.info("userid - " + userid);				// 참가하고싶어하는 유저의 id
		  logger.info("crewWaiter - " + crewWaiter);		// 대기자의 명단
		  
		  if (count == 0) {		// 모임에 등록되어 있지않다	
			  member++;
			  vo.setStudy_crew_count(member);  
			  vo.setStudy_crew_wait(crewWaiter);
			  vo.setStudy_crew_user(vo.getStudy_crew_user() + "," + userid); // crewUser에 참가자 아이디 추가
			  result = studyService.updateCrew(vo);
		  } else {				// 모임에 등록되어있다
			  result = 0;
		  }
		  
		  if (result == 1) {
			  reAttr.addFlashAttribute("attend_result", "success");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  } else {
			  logger.info("updateCrew() 정상 작동X!");
			  reAttr.addFlashAttribute("attend_result", "fail");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  }
	  }
	  
	  // 참여자 삭제
	  @GetMapping("/attend-delete")
	  public String attendDelete(Integer member,
			  RedirectAttributes reAttr, String userid, Integer bno,
			  @ModelAttribute("page") int page){ 
		  int result;
		  // member = 참가한 이용자 수, userid = 해당 이용자, bno = 게시글 고유번호
		  StudyVO vo = studyService.read(bno);
		  
		  String userList = vo.getStudy_crew_user();
		  if (userList.split(",").length == 1) { // 참여자 명단에 하나만 있을 경우
			  userList = userList.replace(userid + ",", "0");
			  userList = userList.replace(userid, "0");
		  } else if (userList.split(",").length > 1){
			  userList = userList.replace(userid + ",",	"");
			  userList = userList.replace("," + userid, "");
			  userList = userList.replace(userid ,	"");
		  }
		  
		  vo.setStudy_crew_count(member - 1);
		  vo.setStudy_crew_user(userList);
		  
		  // 블랙으로 추가
		  String black = vo.getStudy_crew_black();
		  
		  if (black.equals(" ")) {
			  black = userid;
			  vo.setStudy_crew_black(black);
			  logger.info("black : " + black);
		  } else {
			  black += "," + userid;
			  vo.setStudy_crew_black(black);
			  logger.info("black : " + black);
		  }
		  
		  
		  result = studyService.deleteCrew(vo);
		  
		  if (result == 1) {
			  reAttr.addFlashAttribute("attend_delete_result", "success");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  } else {
			  logger.info("attendDelete() 정상 작동X");
			  reAttr.addFlashAttribute("atend_delete_result", "fail");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  }
	  }
	
	  // 대기자 삭제
	  @GetMapping("/attend-reject")
	  public String attendReject(Integer member, RedirectAttributes reAttr, String userid, Integer bno,
			  	@ModelAttribute("page") int page) {
		  int result;
		  // member = 참가한 이용자 수, userid = 해당 이용자(삭제당할), bno = 게시글 고유번호
		  StudyVO vo = studyService.read(bno);
		  
		  String userList = vo.getStudy_crew_wait();
		  if (userList.split(",").length == 1) {		// 대기자에 한명만 존재
			  userList = userList.replace(userid + ",", "0");
			  userList = userList.replace(userid, "0");
		  } else if (userList.split(",").length > 1) {  // 대기자가 한명 이상 존재
			  userList = userList.replace(userid + ",", ""); 	// 맨 뒤가 아닌 부분에 있으면 교체
			  userList = userList.replace("," + userid, "");	// 맨 뒤에 아이디가 존재할때
			  userList = userList.replace(userid, "");
		  }
		  
		  // 블랙으로 추가
		  String black = vo.getStudy_crew_black();
		  
		  if (black.equals(" ")) {
			  black = userid;
			  vo.setStudy_crew_black(black);
			  logger.info("black : " + black);
		  } else {
			  black += "," + userid;
			  vo.setStudy_crew_black(black);
			  logger.info("black : " + black);
		  }
		  
		  vo.setStudy_crew_wait(userList);
		  result = studyService.deleteCrewWait(vo); 		// crewWait, bno
		  
		  if (result == 1) {
			  reAttr.addFlashAttribute("wait_reject_result", "success");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  } else {
			  logger.info("attend-reject 정상 작동 X");
			  reAttr.addFlashAttribute("wait_reject_result", "fail");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  }
	  }
	  
	  // ===========================================================
	  
	 
}
