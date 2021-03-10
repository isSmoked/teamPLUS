<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta charset="UTF-8">
<title>질문게시판</title>
</head>
<body>
  <h2>질문게시판</h2>
  <hr>
  <br>
  <c:if test="${loginId ne null and blacklist ne 1}">
  	<p><a href="register"><input type="button" class="btn btn-light" value="글작성"></a></p>
  </c:if>
  <br>
  <!-- ********************** Board Table ********************** -->
  <table style="width:90%;" class="table table-hover" id="List">
  
    <thead>
      <tr class="active">
        <th style="width: 80px;">번호</th>
        <th style="width: 700px;">제목</th>
        <th style="width: 100px;">작성자</th>
        <th style="width: 100px;">작성일</th>
      </tr>
    </thead>
    
    <tbody>
      <!-- 공지글 -->
	   <c:forEach var="vo" items="${qaboardNotice }">
	   	<tr>
	    	<td>${vo.qaboard_bno }</td>
	    	<td>
	    		<a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);"
	            href="detail?bno=${vo.qaboard_bno }&page=${pageMaker.criteria.page}">
	    			<span style="color:red;"><c:out value="${vo.qaboard_title }"/> 
	    				<c:if test="${vo.qaboard_replycount ne '0' }"> (${vo.qaboard_replycount })</c:if>
	    			</span>
    			</a>
    		</td>
	    	<td>${vo.userid }</td>
	    	<fmt:formatDate value="${vo.qaboard_date }" pattern="yyyy-MM-dd HH:mm:ss" var="qaboard_date"/>
	    	<td>${qaboard_date }</td>
	   	</tr>
	   </c:forEach>
		
		<!-- 게시글 -->	   
	     <c:forEach var="vo" items="${qaboardList }">
	       <tr>
	         <td>${vo.qaboard_bno }</td>
	         <td>
	         	<a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);"
	            href="detail?bno=${vo.qaboard_bno }&page=${pageMaker.criteria.page}">
	         		<c:out value="${vo.qaboard_title }"/> 
	         		<c:if test="${vo.qaboard_replycount ne '0' }"><span style="color:red;"> (${vo.qaboard_replycount })</span></c:if>
	         	</a>
         	 </td>
	         <td>${vo.userid }</td>
	         <fmt:formatDate value="${vo.qaboard_date }" pattern="yyyy-MM-dd HH:mm:ss" var="qaboard_date"/>
	         <td>${qaboard_date }</td>
	       </tr>
	     </c:forEach>
      
    </tbody>
  </table>
  <hr>
  
  <!-- 게시판 검색 -->
  <form action="list" method="get">
	  <select name="searchType">
	  	<option value="tc">제목+내용</option>
	  	<option value="writer">작성자</option>
	  	<option value="title">제목</option>
	  	<option value="content">내용</option>
	  	<option value="all">전체검색</option>
	  </select>
	  <input style="width:50%;" type="text" name="keyword" placeholder="검색">&nbsp;&nbsp;<input type="submit" class="btn btn-dark" value="검색">
  </form>

 <hr>
  
  <!-- ********************** Board Paging ********************** -->
  <nav aria-label="Page navigation example">
  <div style="width:90%; font-size: xx-large;">
	  <ul class="pager pagination" style="justify-content: center;">
	    <c:if test="${pageMaker.hasPrev }">
	    	<li class="page-item"><a class="page-link" href="${pageMaker.startPageNo - 1}" aria-label="Previous">
	    	<span aria-hidden="true">&laquo;</span>
	    	</a>
	    	</li>
	    </c:if>
	    
	    <c:forEach begin="${pageMaker.startPageNo }" end="${pageMaker.endPageNo }" var="num">
	    	<li class="page-item">
	    	<a class="page-link" href="${num }">${num }</a></li>
	    </c:forEach>
	    
	    <c:if test="${pageMaker.hasNext }">
	    	<li class="page-item"><a class="page-link" href="${pageMaker.endPageNo + 1}" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
	    </c:if>
	  </ul>
  </div>
  </nav>
  
  <!-- 페이지처리를 위한 폼 -->
  <div>
    <form id="pagingForm" style="display: none;">
      	<input type="text" name="page">
  		<input type="hidden" name="searchType" value="${searchType }">
  		<input type="hidden" name="keyword" value="${keyword }">
    </form>
  </div>
  
  <br>
  <br>
  <br>
  <br>
  <br>
  
  <input id="resultAlert" type="hidden" value="${resultAlert}">
  
  <script type="text/javascript">
	// toastr
	toastr.options = {
					  "closeButton": false,
					  "debug": false,
					  "newestOnTop": false,
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
					
	$(document).ready(function(){
	  $('.pager li a').click(function(){
	    // pager 클래스의 하위 li 요소의 a 요소를 찾아감
	    event.preventDefault(); // a 태그의 기본 동작(페이지 이동)을 금지
	    var targetPage = $(this).attr('href'); // a 태그 href 속성의 값을 저장
	    console.log(targetPage);
	    
	    var frm = $('#pagingForm'); // form의 정보를 frm에 저장
	    frm.find('[name="page"]').val(targetPage);
	    // name="page"인 요소를 찾아서 value값을 저장
	    frm.attr('action', 'list'); // form에 action 속성-값 추가
	    frm.attr('method', 'get'); // form에 method 속성 추가
	    frm.submit(); // form 데이터 전송
	  }); // end click()
	  
	  
	// 결과 알림
	resultAlert();
	  	function resultAlert() {
	    var result = $('#resultAlert').val();
	    if (result === 'insertSuccess') {
	      toastr["success"]("새 글이 작성되었습니다.");
	    } else if(result === 'deleteSuccess'){
	      toastr["info"]("삭제되었습니다.");
	    }
	  } // resultAlert()
	  
	  
	  
  	// ******************************************************************
		
		// WebSocket
	  	var URL = window.location.host + window.location.pathname;
	  	var serverURL = URL.split("/")[0];
	  	console.log('url : ' + URL);
	  	console.log('host : ' + window.location.host);
	  	var sockURL = 'ws://' + window.location.host + '/prj/freeboard/websocket';
	  	
		var sock = new WebSocket(sockURL);
	  	
	  	sock.onopen = function() {
	  		console.log('websocket opened');
	  	};
	  	
	  	sock.onmessage = function (event) {
	  		// alarm
	  		if (event.data.split(',')[0] !== 'chatMsg') {
	  			$('#toast').show();		// 메세지가 오면 보이도록하기
		  		console.log('receive message : ' + event.data);
		  		const message = document.getElementById('toast');
		  		message.innerHTML = event.data;	
	  		}
		  	
	  		
	  	};
	  	
		
	  	
	  	sock.onclose = function (event) {
	  		console.log('websocket closed : ' + event);
	  	};
		
	 	// toast 알림창 없앴다가 보이게 하기
	  	$('#toast').hide();
	  	
	  	// ***************************************************************************
	}); // end document
	
</script>
</body>
</html>
