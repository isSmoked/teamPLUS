<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- TinyMCE -->
<script src="https://cdn.tiny.cloud/1/mvtgkc47o2k8wy7wo80m0ts2g1zdax79ywcue2h5b9o9ectc/tinymce/5/tinymce.min.js"></script>
<title>${freeboardVO.freeboard_title }</title>
</head>
<body>
  <h6><a href="list" style="color: black; 
	          text-decoration: none;"><strong>자유게시판</strong></a> > <a href="detail?bno=${freeboardVO.freeboard_bno }&page=${page}"  style="color: black; 
	          text-decoration: none;">>${freeboardVO.freeboard_bno }</a> > 수정</h6>
  <hr>
  <form action="update" method="POST">
	<div>
  	<input type="hidden" name="page" value="${page }">
    <input type="hidden" name="userid" value="${loginId }">
    <input type="hidden" name="freeboard_bno" value="${freeboardVO.freeboard_bno }">
      <fmt:formatDate value="${freeboardVO.freeboard_date }" pattern="yyyy-MM-dd HH:mm:ss" var="freeboard_date" />
      <p>작성자 : ${freeboardVO.userid } | 작성일 : ${freeboard_date } | 글 번호 : ${freeboardVO.freeboard_bno }</p>
      <p>제목 : 
      	<input style="width:50%;" type="text" name="freeboard_title" placeholder="제목 입력" required="required" value="${freeboardVO.freeboard_title }" >
      	<!-- 공지글 설정 (관리자 전용) -->
      	<c:if test="${part eq 'manager' }"> | 
       	  <select name="freeboard_notice" id="notice">
		  	<option value="0" <c:if test="${freeboardVO.freeboard_notice eq '0' }">selected</c:if>>공지_0</option>
		  	<option value="1" <c:if test="${freeboardVO.freeboard_notice eq '1' }">selected</c:if>>공지_1</option>
		  	<option value="2" <c:if test="${freeboardVO.freeboard_notice eq '2' }">selected</c:if>>공지_2</option>
		  	<option value="3" <c:if test="${freeboardVO.freeboard_notice eq '3' }">selected</c:if>>공지_3</option>
		  </select>
		</c:if>
      </p>
    </div>
    <hr>
	<!-- TinyMCE -->
    <div>
		<textarea id="editor" name="freeboard_content" required>${freeboardVO.freeboard_content }</textarea>
    </div>
    <!-- 하단버튼 -->
    <div>
      <input type="submit" class="btn btn-light" style="background: lightgrey;" onclick="check()" value="수정">
      <input type="button" class="btn btn-light" style="background: lightgrey;" onclick="goBack()" value="취소">
    </div>

  </form>
  
  <br>
  <br>
  <br>
  <br>
  <br>
  
  <input id="resultAlert" type="hidden" value="${resultAlert}">
  
  <script type="text/javascript">
  // 수정버튼
  function check() {
	  var content = $('#editor').val();
		  console.log("check : " + content);
	  if (content === "") {
		  alert("글을 작성해 주세요.");
		  return false;
	  }
  } // check()
  
	// 취소버튼
	function goBack(){
		if (confirm("취소 하시겟습니까?")){
			window.history.back();
		}
	} // goBack
	
	// 결과 알림
	resultAlert();
  	function resultAlert() {
	    var result = $('#resultAlert').val();
	    if (result === 'updateFail') {
	      alert('글 수정 실패.');
	    }
	  } // resultAlert()
	  
   
  	   /* TinyMCE */  
	   tinymce.init({
	      selector: '#editor',
	      mode: 'textareas',
	      plugins: [
	    	  'a11ychecker advcode casechange formatpainter linkchecker autolink lists checklist media mediaembed', 
	    	  'pageembed permanentpen table advtable tinymcespellchecker',
	          
	          "advlist autosave link image charmap preview hr pagebreak",
	          "searchreplace wordcount code fullscreen insertdatetime nonbreaking",
	          "directionality emoticons template paste textpattern",
	    	  
	    	  'codesample autoresize'
	    	  /* 'spellchecker powerpaste colorpicker contextmenu textcolor fullpage anchor help print visualblocks visualchars tinycomments' */
	    	  ],
	      toolbar: [
	      	"undo redo | fullscreen preview code | searchreplace | outdent indent blockquote | subscript superscript | insertdatetime",
	       	"bold italic underline strikethrough | bullist numlist | hr | charmap emoticons | link unlink image media table",
	       	"fontselect fontsizeselect | forecolor backcolor | alignleft aligncenter alignright alignjustify | codesample"
	       	/* "anchor formatselect print pagebreak visualblocks visualchars ltr rtl restoredraft removeformat" */
	     	],
	      menubar: false,
	      toolbar_mode: 'floating',
	      tinycomments_mode: 'embedded',
	      tinycomments_author: 'Author name',
	      min_height: 500,
	      width: '90%',
	      toolbar_sticky: true,
	      autoresize_bottom_margin: 50,
	      language: 'ko_KR',
	      setup: function (editor) {
	          editor.on('change', function (e) {
	              editor.save();
	          });
	      }
	   }); // TinyMCE
	   
	   
	   $(document).ready(function() {
			  
			// ******************************************************************
			
			// WebSocket
		  	var URL = window.location.host + window.location.pathname;
		  	var serverURL = URL.split("/")[0];
		  	console.log('url : ' + URL);
		  	console.log('host : ' + window.location.host);
		  	
		  	
		  	var sock = new WebSocket('ws://' + window.location.host + '/prj/freeboard/websocket');
		  	
	  		var message2 = "a"; // 보낼 메시지 가공!!
	  	
			sock.onopen = function() {
				console.log('websocket opened');
				console.log('will send : ' + message2)
			};
			
			// event는 메세지로 받아오는 데이터
			sock.onmessage = function(event) {
				// <a> 태그 형식의 alert이 넘어올 예정
				$('#toast').show();		// 메세지가 오면 보이도록하기
				console.log('receive message : ' + event);
				const message = document.getElementById('toast');
		  		message.innerHTML = event.data;
			}; // end onmessage()
			
			sock.onclose = function (event) {
				console.log('websocket closed : ' + event);
			};
			
			// message 보내기
			function messageSend() {
				console.log('something sent : ' + message2);
				sock.send(message2);
			}
			
			// ****************************************************************  
	  }); // end document
	   
  </script>
 
</body>
</html>

