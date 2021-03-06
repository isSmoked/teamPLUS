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
	
	/* 其捞隆 贸府 */
	@GetMapping("/list")
	public void list(Model model, Integer page, Integer perPage, 
			String keyword, String select) {
		logger.info("list 龋免");
		logger.info("page = " + page + ", perPage = " + perPage);

		// Page 贸府
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
		logger.info("listPOST-Search 龋免 : keyword = " + keyword + ", select = " + select_keyword);
		
		logger.info("page : " + page);
		if (select_keyword.equals("userid")) { // userid肺 八祸
			List<StudyVO> list = studyService.read(keyword);
			model.addAttribute("boardList", list);
			logger.info(list.toString());

		} else if (select_keyword.equals("keyword")) { // keyword肺 八祸
			List<StudyVO> list = studyService.readByKeyword(keyword);
			model.addAttribute("boardList", list);
			logger.info(list.toString());
			
		} else if (select_keyword.equals("location")) { // 瘤开栏肺 八祸
			List<StudyVO> list = studyService.readByLocation(keyword);
			model.addAttribute("boardList", list);
			logger.info(list.toString());
		}
		
		// Page 贸府
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
	// register.jsp甫 GET规侥栏肺 阂矾坷扁
	@GetMapping("/register")
	public void registerGET() {
		logger.info("registerGET() 龋免");

	}

	// register.jsp甫 POST规侥栏肺 焊郴绰 皋家靛
	@PostMapping("/register")
	public String registerPOST(StudyVO vo, RedirectAttributes reAttr, HttpServletRequest request) {
		logger.info("registerPOST() 龋免");
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
		logger.info("detail() 龋免 : bno = " + bno);
		
		// 殿废等 臂狼 累己磊
		StudyVO vo = studyService.read(bno);	// vo俊 蔼 傈崔 肯丰
		logger.info(vo.toString());
		model.addAttribute("studyVO", vo);
		
		// 臂 累己磊狼 捞抚阑 技记栏肺 焊郴扁
//		HttpSession session = request.getSession(); // 技记 积己
//		session.setAttribute("makerUserid", arr[0]);
//		logger.info("makerUserid : " + arr[0]);
		
		int result = studyService.updateReadCount(bno);
		
		if (result == 1) {
			logger.info("炼雀荐 刘啊 己傍 : readcount = " + vo.getStudy_readcount());
		} else {
			logger.info("炼雀荐 刘啊 角菩");
		}
		
	}
	
	@GetMapping("/detail-admin")
	public void detailAdminGET(Integer bno, Model model, @ModelAttribute("page") int page) {
		logger.info("detail-admin() 龋免 : bno = " + bno);
		
		// 殿废等 臂狼 累己磊
		StudyVO vo = studyService.read(bno);
		logger.info(vo.toString());
		model.addAttribute("studyVO", vo);
		String attendUserid = vo.getStudy_crew_user();
		String arr[] = attendUserid.split(",");
		logger.info("秦寸 臂 累己磊 userid : " + arr[0]);
		
		logger.info("detail-adimin() 沥惑 龋免 肯丰");
	}

	/* update -------------------------------------------------- */
	// update.jsp甫 GET规侥栏肺 阂矾坷扁
	@GetMapping("/update")
	public void updateGET(Integer bno, Model model, @ModelAttribute("page") int page) {
		logger.info("update() 龋免 : bno = " + bno);
		StudyVO vo = studyService.read(bno);
		model.addAttribute("studyVO", vo);
	}

	// update.jsp甫 POST规侥栏肺 阂矾坷扁
	@PostMapping("/update")
	public String updatePOST(StudyVO vo, Integer page, RedirectAttributes reAttr) {
		logger.info("updatePOST() 龋免 : bno = " + vo.getStudy_bno());
		int result = studyService.update(vo);
		if (result == 1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:/studyBoard/detail-admin?bno=" + vo.getStudy_bno() + "&page=" + page;
			// page肺 涝仿登菌阑 锭, 沥惑 累悼 / bno甫 罐酒辑 detail肺 捞悼 阂啊
		} else {
			logger.info("update() 角菩");
			reAttr.addFlashAttribute("update_result", "fail");
			return "redirect:/studyBoard/update?bno=" + vo.getStudy_bno();
		}
	}

	/* delete -------------------------------------------------- */
	@GetMapping("/delete")
	public String delete(Integer bno, RedirectAttributes reAttr) {
		logger.info("delete() 龋免 : bno = " + bno);
		
		int result = studyService.delete(bno);
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/studyBoard/list";
		} else {
			reAttr.addFlashAttribute("delete_result", "fail");
			return "redirect:/studyBoard/detail?bno=" + bno;
		}
	}
	
	

	 
	  /* 曼啊 attend ---------------------------------------------- */
	  // 罐酒柯 userid甫 措扁疙窜俊 眠啊!
	  // member = 泅犁 糕滚 荐 / userid = 曼啊磊 / bno = studybno
	  @GetMapping("/attend") 
	  public String attend(
			  RedirectAttributes reAttr, String userid, Integer bno,
			  @ModelAttribute("page") int page){ 
		  int result = 0;
		  boolean attendOverlap = false;
		  boolean waitOverlap = false;
		  logger.info("userid = " + userid);
		  StudyVO vo = studyService.read(bno);							// bno肺 啊廉柯 秦寸 霸矫臂狼 vo
		  
		  // userid客 studyCrewUser甫 厚背 > 吝汗登搁 葛烙俊 曼啊且 荐 绝档废
		  String users[] = vo.getStudy_crew_user().split(",");
		  for (int i = 0; i < users.length; i++) {
			  if (userid.equals(users[i])) {
				  attendOverlap = true;    // 酒捞叼 吝汗!
			  }
		  }
		  logger.info("attend() 酒捞叼 吝汗 test 搬苞 - " + attendOverlap);
		  
		  // userid客 studyCrewWait阑 厚背
		  String usersArr[] = vo.getStudy_crew_wait().split(",");
		  for (int i = 0; i < usersArr.length; i++) {
			  if (userid.equals(usersArr[i])) {
				  waitOverlap = true;
			  }
		  }
		  logger.info("attend() 酒捞叼 吝汗 test 搬苞 - " + waitOverlap);
		  
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
		   
		  if (result == 1 && attendOverlap == false && waitOverlap == false) { /* detail.jsp 舅覆免仿窍扁 */ /* detail.jsp 滚瓢 焊捞扁 贸府 */
			  reAttr.addFlashAttribute("attend_result", "success"); 
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  } else if (attendOverlap == true) {		// 酒捞叼 吝汗栏肺 曼啊 角菩!
			  reAttr.addFlashAttribute("attend_result", "attendOverlap"); 
			  logger.info("捞固 曼啊等 捞侩磊!");
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  } else if (waitOverlap == true) {
			  reAttr.addFlashAttribute("attend_result", "waitOverlap");
			  logger.info("捞固 曼啊殿废茄 捞侩磊!");
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  } else { 			// 单捞磐惑 坷幅肺 曼啊 角菩
			  reAttr.addFlashAttribute("attend_result", "fail");
			  logger.info("单捞磐惑 坷幅肺 曼啊 角菩");
			  return "redirect:/studyBoard/detail?bno=" + bno + "&page=" + page;
		  }
	  } 
	 
	  // 措扁 > 曼咯磊
	  @GetMapping("/attend-wait")
	  public String attendWait(Integer member,
			  RedirectAttributes reAttr, String userid, Integer bno,
			  @ModelAttribute("page") int page){ 
		  int result;
		  logger.info("attendWait() 龋免 userid - " + userid);
		  
		  StudyVO vo = studyService.read(bno);
		  
		  // vo狼 曼咯牢荐(member) 刘啊 / userid绰 措扁疙窜俊辑 罐酒柯促.
		 
		  
		  logger.info(vo.toString());
		  
		  String crewWaiter = vo.getStudy_crew_wait(); 			// 措扁磊疙窜 檬扁拳侩
		  String arrWaiter[] = crewWaiter.split(",");
		  int attendNum = arrWaiter.length;
		  
		  /* crewWaiter狼 疙窜俊辑 曼啊磊狼 酒捞叼甫 瘤快绊,
		   * crewUser俊 曼啊磊狼 酒捞叼甫 眠啊 矫挪促. (V)
		   *  */
		  
		  
		  
		  logger.info("arr[i] - ");
		  for (int i = 0; i < arrWaiter.length; i++) {
			  System.out.println(arrWaiter[i]);
		  }
		  
		  // 捞固 葛烙俊 殿废等 捞侩磊牢瘤 犬牢
		  int count = 0;
		  String arrCrewUser[] = vo.getStudy_crew_user().split(",");
		  for (int i = 0; i < arrCrewUser.length; i++) {
			  logger.info("arr[" + i + "] = " + arrCrewUser[i]);
			  if (arrCrewUser[i].equals(userid)) { // 捞固 葛烙俊 甸绢啊乐绰 捞侩磊 - count
				  count = 1;
				  logger.info("count-userid - " + userid);
				  break;
			  }
		  }
		  
		  // crewWaiter俊辑 曼啊等 捞侩磊狼 酒捞叼甫 昏力
		  if (vo.getStudy_crew_wait().split(",").length > 1 || count != 1) {
			  crewWaiter = crewWaiter.replace(userid + ",", ""); // 盖菊 - 盖场 傈俊 乐栏搁 函券
			  crewWaiter = crewWaiter.replace(userid , "0");	 // 盖场俊 乐栏搁 函券
		  } else if (vo.getStudy_crew_wait().split(",").length == 1 || count != 1) {
			  crewWaiter = crewWaiter.replace(userid, "0");
		  }
		  
		  logger.info("userid - " + userid);				// 曼啊窍绊酵绢窍绰 蜡历狼 id
		  logger.info("crewWaiter - " + crewWaiter);		// 措扁磊狼 疙窜
		  
		  if (count == 0) {		// 葛烙俊 殿废登绢 乐瘤臼促	
			  member++;
			  vo.setStudy_crew_count(member);  
			  vo.setStudy_crew_wait(crewWaiter);
			  vo.setStudy_crew_user(vo.getStudy_crew_user() + "," + userid); // crewUser俊 曼啊磊 酒捞叼 眠啊
			  result = studyService.updateCrew(vo);
		  } else {				// 葛烙俊 殿废登绢乐促
			  result = 0;
		  }
		  
		  if (result == 1) {
			  reAttr.addFlashAttribute("attend_result", "success");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  } else {
			  logger.info("updateCrew() 沥惑 累悼X!");
			  reAttr.addFlashAttribute("attend_result", "fail");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  }
	  }
	  
	  // 曼咯磊 昏力
	  @GetMapping("/attend-delete")
	  public String attendDelete(Integer member,
			  RedirectAttributes reAttr, String userid, Integer bno,
			  @ModelAttribute("page") int page){ 
		  int result;
		  // member = 曼啊茄 捞侩磊 荐, userid = 秦寸 捞侩磊, bno = 霸矫臂 绊蜡锅龋
		  StudyVO vo = studyService.read(bno);
		  
		  String userList = vo.getStudy_crew_user();
		  if (userList.split(",").length == 1) { // 曼咯磊 疙窜俊 窍唱父 乐阑 版快
			  userList = userList.replace(userid + ",", "0");
			  userList = userList.replace(userid, "0");
		  } else if (userList.split(",").length > 1){
			  userList = userList.replace(userid + ",",	"");
			  userList = userList.replace("," + userid, "");
			  userList = userList.replace(userid ,	"");
		  }
		  
		  vo.setStudy_crew_count(member - 1);
		  vo.setStudy_crew_user(userList);
		  
		  // 喉发栏肺 眠啊
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
			  logger.info("attendDelete() 沥惑 累悼X");
			  reAttr.addFlashAttribute("atend_delete_result", "fail");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  }
	  }
	
	  // 措扁磊 昏力
	  @GetMapping("/attend-reject")
	  public String attendReject(Integer member, RedirectAttributes reAttr, String userid, Integer bno,
			  	@ModelAttribute("page") int page) {
		  int result;
		  // member = 曼啊茄 捞侩磊 荐, userid = 秦寸 捞侩磊(昏力寸且), bno = 霸矫臂 绊蜡锅龋
		  StudyVO vo = studyService.read(bno);
		  
		  String userList = vo.getStudy_crew_wait();
		  if (userList.split(",").length == 1) {		// 措扁磊俊 茄疙父 粮犁
			  userList = userList.replace(userid + ",", "0");
			  userList = userList.replace(userid, "0");
		  } else if (userList.split(",").length > 1) {  // 措扁磊啊 茄疙 捞惑 粮犁
			  userList = userList.replace(userid + ",", ""); 	// 盖 第啊 酒囱 何盒俊 乐栏搁 背眉
			  userList = userList.replace("," + userid, "");	// 盖 第俊 酒捞叼啊 粮犁且锭
			  userList = userList.replace(userid, "");
		  }
		  
		  // 喉发栏肺 眠啊
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
			  logger.info("attend-reject 沥惑 累悼 X");
			  reAttr.addFlashAttribute("wait_reject_result", "fail");
			  return "redirect:/studyBoard/detail-admin?bno=" + bno + "&page=" + page;
		  }
	  }
	  
	  // ===========================================================
	  
	 
}
