package edu.spring.prj.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.spring.prj.domain.ReplyVO;
import edu.spring.prj.service.ReplyService;

@RestController
@RequestMapping(value = "*/replies")
public class ReplyRESTController {
	private static final Logger logger = LoggerFactory.getLogger(ReplyRESTController.class);

	@Autowired
	private ReplyService replyService;

	// 댓글 입력
	@PostMapping() // POST : 댓글 입력
	public ResponseEntity<Integer> createReply(@RequestBody ReplyVO vo) {
		// @RequestBody
		// - 클라이언트에서 전송받은 json 데이터를 자바 객체로 변환해주는 annotation
		logger.info(vo.toString());
		int result;
		try {
			result = replyService.create(vo);
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<Integer>(0, HttpStatus.OK);
		}

	}

	// 댓글 불러오기
	@GetMapping("/all/{reply_bno}") // GET : 댓글 선택(all)
	public ResponseEntity<List<ReplyVO>> readReplies(@PathVariable("reply_bno") int reply_bno) {
		// @PathVariable(name) : {name}값을 설정된 변수에 적용
		List<ReplyVO> list = replyService.read(reply_bno);
		return new ResponseEntity<List<ReplyVO>>(list, HttpStatus.OK);
	}

	@PutMapping("/{reply_no}") // PUT : 댓글 수정
	public ResponseEntity<String> updateReply(@PathVariable("reply_no") int reply_no, @RequestBody ReplyVO vo) {
		vo.setReply_no(reply_no);
		int result = replyService.update(vo);
		ResponseEntity<String> entity = null;
		if (result == 1) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		return entity;
	}

	// 댓글 삭제
	@DeleteMapping("/{reply_no}")
	public ResponseEntity<String> deleteReply(@PathVariable("reply_no") int reply_no, @RequestBody ReplyVO vo) {
		logger.info("reply_bno = " + vo.getReply_bno());
		logger.info("delete vo = " + vo.toString());
		try {
			replyService.delete(reply_no, vo.getReply_bno(), vo.getReply_table_name());
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<String>("fail", HttpStatus.OK);
		}
	} // deleteReply

} // ReplyRESTController
