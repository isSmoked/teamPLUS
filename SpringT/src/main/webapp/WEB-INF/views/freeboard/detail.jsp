<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<title>${freeboardVO.freeboard_title }</title>
<style type="text/css">
.spanUpdate, .spanCancel, .spanDelete {
cursor: pointer;
color: blue;
}
.spanUpdate:hover, .spanCancel:hover, .spanDelete:hover {
text-decoration: underline;
}
</style>
</head>
<body>
	<h6><a href="list" style="color: black; 
	          text-decoration: none;"><strong>자유게시판</strong></a> > ${freeboardVO.freeboard_bno }</h6>
	<hr>
	<!-- 본문 -->
	<H2><c:out value="${freeboardVO.freeboard_title }"/></H2>
	<fmt:formatDate value="${freeboardVO.freeboard_date }" pattern="yyyy-MM-dd HH:mm:ss" var="freeboard_date" />
		작성자 : ${freeboardVO.userid } | 작성일 : ${freeboard_date } | 	
		<!-- 공지글 설정 (관리자 전용) -->
      	<c:if test="${part eq 'manager' }"> 
       	  <select id="notice">
		  	<option value="0" <c:if test="${freeboardVO.freeboard_notice eq '0' }">selected</c:if>>공지_0</option>
		  	<option value="1" <c:if test="${freeboardVO.freeboard_notice eq '1' }">selected</c:if>>공지_1</option>
		  	<option value="2" <c:if test="${freeboardVO.freeboard_notice eq '2' }">selected</c:if>>공지_2</option>
		  	<option value="3" <c:if test="${freeboardVO.freeboard_notice eq '3' }">selected</c:if>>공지_3</option>
		  </select>
		  <input type="button" onclick="updateNotice()" value="공지변경">
		</c:if>
	<hr>
	<table style="width:90%;">
		<tr>
			<td>
		    	<br>
			    	<div>${freeboardVO.freeboard_content }</div>
		    	<br>
			</td>
		</tr>
	</table>
	<hr>
	<!-- 하단 버튼 -->
	<div>
		<c:if test="${loginId ne null }"><input type="button" class="btn btn-light" style="background: silver;" id="bookmark" onclick="bookmark()" value="찜"></c:if>&nbsp;&nbsp;&nbsp;
		
		<a href="list?page=${page }&searchType=${searchType }&keyword=${keyword }"><input type="button" class="btn btn-light" value="글 목록"></a>
		<c:if test="${freeboardVO.userid eq loginId and blacklist ne 1}">
			<a href="update?bno=${freeboardVO.freeboard_bno }&page=${page}"><input type="button" class="btn btn-light" value="글 수정"></a>
			<a href="delete?bno=${freeboardVO.freeboard_bno }" class="deleteLink" onclick="return false"><input type="button" class="btn btn-light" onclick="deleteConfirm()" value="글 삭제"></a>
		</c:if>
	</div>
	<br>

	<!-- 댓글 입력 -->
		<table style="background-color: ghostwhite; width:90%; height:50px;">
			<tr>
				<td>
					<c:choose>
						<c:when test="${loginId ne null and blacklist ne 1}">
							&nbsp;
							<input type="text" id="reply_content" placeholder="댓글 입력" style="width:80%;" maxlength="60">
							<button type="button" class="btn btn-light" style="background: silver;" id="btn_reply">작성</button>
						</c:when>
						<c:when test="${blacklist eq 1 }">오늘도 즐거운 하루가 되세요!</c:when>
						<c:otherwise>
							&nbsp;&nbsp;<a href="../member/login">로그인</a> 하고, 댓글을 작성하세요!
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	<br>
	
	<div>
		<div id="replies" style="width:90%;"></div>
	</div>
	
	<br>
	<br>
	<br>
	<br>
	<br>

	<!-- 댓글 입력 및 확인용 정보 -->
	<input type="hidden" id="tableName" value="${tableName }">
	<input type="hidden" id="bno" value="${freeboardVO.freeboard_bno }">
	<input type="hidden" id="loginId" value="${loginId}"> 
	<input type="hidden" id="blacklist" value="${blacklist}"> 
	
	<input id="resultAlert" type="hidden" value="${resultAlert}">

	<script type="text/javascript">
	// toastr
	toastr.options = {
					  "closeButton": false,
					  "debug": false,
					  "newestOnTop": true,
					  "progressBar": false,
					  "positionClass": "toast-bottom-center",
					  "preventDuplicates": true,
					  "onclick": null,
					  "showDuration": "300",
					  "hideDuration": "1000",
					  "timeOut": "5000",
					  "extendedTimeOut": "1000",
					  "showEasing": "swing",
					  "hideEasing": "linear",
					  "showMethod": "fadeIn",
					  "hideMethod": "fadeOut"
					} // toastr
					
	$(document).ready(function() {
		
		// ******************************************************************
		
		
		
		var bno = $('#bno').val(); // 게시판 번호 값
        var tableName = $('#tableName').val(); // 테이블 이름
        var loginId = $('#loginId').val(); // 댓글 아이디
        getAllReplies(); // 메소드 호출
        
        /* 댓글 입력 */
        $('#btn_reply').click(function() {
	        var content = $('#reply_content').val(); // 댓글 내용
            if (content === null || content === "") {
            } else {
		        var obj = {
		      	  'reply_table_name' : tableName,
		          'reply_bno' : bno,
		          'userid' : loginId,
		          'reply_content' : content
		          };
            	console.log(obj);
            	$.ajax({
	            	type : 'post',
	                url : 'replies',
	                //url : '/' + reply_table_name + '/replies',
	                headers : {
	                	'Content-Type' : 'application/json',
	                    'X-HTTP-Method-Override' : 'POST'
	                    },
	                    data : JSON.stringify(obj),
	                    success : function(result, status) {
	                    console.log(result);
	                    console.log(status);
	                    if (result === 1) {
	                    	toastr["success"]("댓글이 작성되었습니다.");
	                        getAllReplies();
	                        $('#reply_content').val('');
	                        // $('#userid').val('');
	                    	} else {
		                    	toastr["error"]("댓글 작성 실패.");
	                    	}
	                    }, // end success
	                    error : function(result, status) {
	                    	alert("result: " + result + "\n" + "status: " + status);
	                    } // end error
	                  }); // end ajax()
            	
            } // else 
        }); // end btn_reply()

                
                
	  /* 게시판의 댓글 전체 가져오기 */
	  function getAllReplies() {
	    var url = 'replies/all/' + bno;
	    console.log("getAllReplies url : " + url);
	    $.getJSON(
	    		url,
	            function(jsonData) {
	              console.log(jsonData);
	              var list = ''; // JSON 데이터를 표현할 변수
	              $(jsonData)
	                  .each(
	                      function() { // jsonData를 사용하는 each 반복문
	                        var replyDate = moment(new Date(this.reply_date)).format('YYYY-MM-DD HH:mm:ss');
	                        // this : jsonData
	                        if (this.reply_table_name === $('#tableName').val()) {
	                        list += '<div class="reply_item">'
		                            + '<pre style="background-color:lightblue;">'
			                            + '<input type="text" class="reply_content" value="' + this.reply_content 
			                            + '" style="width:100%; border:none; outline:none; background-color:#e3f8ff;" readonly>'
			                            + '<input type="hidden" class="hidden_content" value="' + this.reply_content + '">'
			                            + '<br>'
			                            + '<div style="float:right;">'
				                            	+ '<div class="updateBtn" style="display:none;">'
				                            		+ '<c:if test="${blacklist ne 1 }">'
						                            + '<input type="hidden" class="reply_no" value="' + this.reply_no + '">'
						                            + '<span class="spanUpdate">수정</span> | '
						                            + '<span class="spanCancel" style="display:none;">취소</span><span class="spanDelete">삭제</span> | '
						                            + '</c:if>'
					                            + '</div>'
				                            + '<span class="spanId">' + this.userid + '</span> | ' + replyDate
			                            + '</div>'
			                            + '<br>'
		                            + '</pre>' 
	                            + '</div>'
	                        }
	                      }); // end each()
	              $('#replies').html(list);
	              showReplyBtn();
	            } // end callback()
	        ); // end getJSON()
	  } // end getAllReplies()
			  
	  
		/* 댓글 삭제 */
		$('#replies').on('click', '.reply_item .spanDelete',
	          	function() {
	          	  	if (confirm("댓글을 삭제하시겠습니까?")) {
					console.log(this);
	                      // 선택된 댓글 reply_no
	                      var reply_no = $(this).prevAll('.reply_no').val();
	                      console.log("선택된 댓글 번호 : " + reply_no);
	                      console.log("선택된 댓글 테이블 : " + tableName);
	
	                      // ajax 요청
	                      $.ajax({
	                      type : 'delete',
	                      url : 'replies/' + reply_no,
	                      headers : {
	                      	'Content-Type' : 'application/json',
	                          'X-HTTP-Method-Override' : 'DELETE'
	                          },
	                          data : JSON.stringify({
	                          'reply_bno' : bno,
	                          'reply_table_name' : tableName
	                          }),
	                          success : function(result) {
	                          	if (result === 'success') {
	                           	/* alert('댓글 삭제 성공'); */
	                           	toastr["info"]("댓글이 삭제되었습니다.");
	                           	getAllReplies();
	                          	} else {
	                           	toastr["error"]("댓글 삭제 실패.");
	                          	}
						}, // end success
						error : function(result){
							alert("error : " + result);
						}
					}); // end ajax()
				} // if deleteConfirm
			}); // end btn_delete()
			
                              
  		/* 댓글 수정 버튼 */
        $('#replies').on('click', '.reply_item .spanUpdate',
       		  function(){
       	  		console.log("spanUpdate clicked");
   	  			var reply_no = $(this).prevAll('.reply_no').val();
     	  		var content = $(this).parents(['pre']).children('.reply_content');
       	  		if ($(this).text() === "수정") {
	    	    	
	         		$(this).text("수정완료");  
	          	  	$(this).nextAll('.spanCancel').css("display", "inline");
	        	  	$(this).nextAll('.spanDelete').css("display", "none");
	        	  	content.attr("readonly", false);
	        	  	content.css("border", "3px solid red");
	        	  	content.css("background-color", "white");
       	  		} else {
       	  			console.log("reply update start");
	 	         	console.log("선택된 댓글 번호 : " + reply_no);
	    	    	console.log("선택된 댓글 내용 : " + content.val());
	
	                 // ajax 요청
	                 $.ajax({
	                   type : 'put',
	                   url : 'replies/' + reply_no,
	                   headers : {
	                     'Content-Type' : 'application/json',
	                     'X-HTTP-Method-Override' : 'PUT'
	                   },
	                   data : JSON.stringify({
	                     'reply_bno' : bno,
	                     'reply_content' : content.val(),
	                   }),
	                   success : function(result) {
	                     if (result === 'success') {
	                       toastr["success"]("댓글을 수정하였습니다.");
	                       //getAllReplies();
	                     } else {
	                       toastr["error"]("댓글 수정 실패.");
	                     }
	                   }, error : function(result){
	                	   alert("error : " + result);
	                   }
	                 }); // ajax
	                 
	      	  		var hidden = $(this).parents(['pre']).children('.hidden_content');
	      	  		
	          		$(this).prev('.spanUpdate').text("수정");  
	           	  	$(this).text("수정");
	           	 	$(this).nextAll('.spanCancel').css("display", "none");
	         	  	$(this).nextAll('.spanDelete').css("display", "inline");
	         	  	content.attr("readonly", true);
	         	  	content.css("border", "none");
	         	  	content.css("background-color", "#e3f8ff");
	         	  	hidden.val(content.val());
	                 
       	  		} // else
        }); // 댓글수정버튼
				
		/* 댓글 취소 버튼 */
        $('#replies').on('click', '.reply_item .spanCancel',
         	  function(){
       	  		console.log("spanCancel clicked");
     	  		var content = $(this).parents(['pre']).children('.reply_content');
     	  		var hidden = $(this).parents(['pre']).children('.hidden_content').val();
        	
     	  		
         		$(this).prev('.spanUpdate').text("수정");  
          	  	$(this).css("display", "none");
        	  	$(this).nextAll('.spanDelete').css("display", "inline");
        	  	content.attr("readonly", true);
        	  	content.css("border", "none");
        	  	content.css("background-color", "#e3f8ff");
        	  	content.val(hidden);
       	  	
        }); // 댓글취소버튼
				
		}); // end ready()
		
		// ======================================================================================
              
			/* 게시글 삭제 버튼 */
		    function deleteConfirm(){
				  console.log("삭제확인");
				  if(confirm("삭제하시겠습니까?")){
					  $('.deleteLink').attr("onclick", "return true");
				  }
			} // deleteConfirm()
		
			/* 결과 알림 */
		   	resultAlert();
		  	function resultAlert() {
		   	    var result = $('#resultAlert').val();
		   	    if (result === 'deleteFail') {
		   	      	alert('삭제실패.');
		   	    } else if (result === 'updateSuccess') {
		   	    	toastr["success"]("게시글이 수정 되었습니다.");
		   	    }
		   	  } // resultAlert()

            /* 공지변경 버튼 */
			function updateNotice() {
				var bno = $('#bno').val();
				var notice = $('#notice').val(); 
				var tableName = $('#tableName').val();
 				var noticeData = {
					freeboard_bno : bno,
					freeboard_notice : notice,
					table_name : tableName
				};
 				console.log(noticeData);
				// ajax로 보내기
				$.ajax({
					type : "post",
					url : "managerRest/updateNotice",
					data : noticeData,
					success : function(data){
						console.log(data);
						if (data === 1){
							toastr["success"]("공지 단계를 수정하였습니다.");
						} else {
							toastr["error"]("공지 수정 실패.");
						}
					},
					error : function(error, request){
						alert("* code:"+request.status+"\n"+"* message:"+request.responseText+"\n"+"* error:"+error);
					} // error
				}); // ajax
			} // end updateNotice()
			
			
			/* 댓글 수정&삭제 보이기 */
			function showReplyBtn (){
					
					console.log("showReplyBtn() start");
					var spanId = $('#replies .reply_item').find('.spanId');
					var btn = $('#replies .reply_item').find('.updateBtn');
					var loginId = $('#loginId').val();
					/* for (var i = 0; i < spanId.length; i++) {
						if(spanId.eq(i).text() === loginId) {
							btn.eq(i).css("display", "inline");
						}
					} */
					spanId.each(function(i){
						if (spanId.eq(i).text() === loginId){
							btn.eq(i).css("display", "inline");
						}
					});
			} // showReplyBtn()
			
			/* 북마크 확인 */
			bookmarkCheck();
			function bookmarkCheck(){
				var id = $('#loginId').val(); 
				var bno = $('#bno').val();
 				var bookmark = {
					userid : id,
					bookmark_table_name : "freeboard_table",
					bookmark_bno : bno
				};
 				console.log(bookmark);

 				$.ajax({
					type : "post",
					url : "bookmark/check",
					data : bookmark,
					success : function(result, status){
						console.log("success : " + result + ", status : " + status);
						if (result === 0){
							$('#bookmark').val("찜");
							$('#bookmark').css("color", "black");
						} else {
							$('#bookmark').val("찜됨");
							$('#bookmark').css("color", "red");
						}
					}, error : function(error, status, result){
						console.log("error : " + error + status + result);
						alert("bookmark error");
					} // error
				}); // ajax

			} // end bookmark()
			
			/* 북마크 추가&삭제 */
			function bookmark(){
				console.log("bookmark start");
				var bookmark = $('#bookmark');
				if (bookmark.val() === "찜됨") {
					var id = $('#loginId').val(); 
					var bno = $('#bno').val();
	 				var bookmark = {
						userid : id,
						bookmark_table_name : "freeboard_table",
						bookmark_bno : bno
					};
	 				console.log("Bookmark delete : " + bookmark);

	 				$.ajax({
						type : "post",
						url : "bookmark/delete",
						data : bookmark,
						success : function(result, status){
							console.log("success : " + result + ", status : " + status);
							if (result === 1){
								$('#bookmark').val("찜");
								$('#bookmark').css("color", "black");
								toastr["info"]("찜이 해제되었습니다.")
							} else {
								$('#bookmark').val("찜됨");
								$('#bookmark').css("color", "red");
								toastr["error"]("찜 해제 실패.")
							}
						}, error : function(error, status, result){
							console.log("error : " + error + status + result);
							alert("bookmark error");
						} // error
					}); // ajax
					
				} else {
					var id = $('#loginId').val(); 
					var bno = $('#bno').val();
	 				var bookmark = {
						userid : id,
						bookmark_table_name : "freeboard_table",
						bookmark_bno : bno
					};
	 				console.log("Bookmark insert : " + bookmark);

	 				$.ajax({
						type : "post",
						url : "bookmark/insert",
						data : bookmark,
						success : function(result, status){
							console.log("success : " + result + ", status : " + status);
							if (result === 1){
								$('#bookmark').val("찜됨");
								$('#bookmark').css("color", "red");
								toastr["success"]("찜!");
							} else {
								$('#bookmark').val("찜");
								$('#bookmark').css("color", "black");
								toastr["error"]("찜 실패.");
							}
						}, error : function(error, status, result){
							console.log("error : " + error + status + result);
							alert("bookmark error");
						} // error
					}); // ajax
					
				} // else
			} // bookmark()
			
	</script>

</body>
</html>
