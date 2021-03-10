<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- Jquery 3.5.1 버전 -->
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>


<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<meta charset="UTF-8">
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnWrite").click(function(){
			// 페이지 주소 변경(이동)
			location.href = "../recboard/register";
		});
	});
</script>
</head>
<body>
	
	
	
	<br>
	<h2>구인게시판</h2>
	<hr>
	<c:if test="${loginId ne null and blacklist ne 1}">
	<p><a href="register.do"><input type="button" class="btn btn-light" value="글작성"></a></p>
	</c:if>
	<div>
	<table class="table table-hover" id="List">
	    <thead>
	      <tr class="active">
	        <th style="width: 60px;">번호</th>
	        <th style="width: 700px;">제목</th>
	        <th style="width: 60px;">작성자</th>
	        <th style="width: 100px;">작성일</th>
	        <th style="width: 50px;">조회수</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:forEach var="RecVO" items="${RecBoardList }">
	        <tr>
	          <td>${rno }</td>
	          <td><a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);" 
	          href="detail?rno=${rno }&page=${pageMaker.criteria.page}">${RecVO.recruit_title }</a></td>
	          <td>${RecVO.userid }</td>
	          <fmt:formatDate value="${RecVO.r_date }"
	            pattern="yyyy-MM-dd HH:mm:ss"
	            var="rdate"/>
	          <td>${rdate }</td>
	          <td><c:out value="${RecVO.rhit }"/></td>
	        </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	</div>
	
  <hr>
  <!-- page maker -->
  <nav aria-label="Page navigation example">
  <ul class="pagination" style="justify-content: center;">
    <c:if test="${pageMaker.hasPrev }">
    <li class="page-item">
      <a class="page-link" href="${pageMaker.startPageNo - 1}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    </c:if>
    <c:forEach begin="${pageMaker.startPageNo }" 
      end="${pageMaker.endPageNo }" var="num">
    <li class="page-item"><a class="page-link" href="${num }">${num }</a></li>
    </c:forEach>
    <c:if test="${pageMaker.hasNext }">
    <li class="page-item">
      <a class="page-link" href="${pageMaker.endPageNo + 1}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    </c:if>
  	</ul>
  	
  	<div>
    <form id="pagingForm" style="display: none;">
      <input type="text" name="page">
      <input type="hidden" name="keyword">
      <input type="hidden" name="select_keyword">
    </form>
  </div>
  
  <%-- 검색 기능 --%>
  <div>
    <form id="search" action="recruits" method="post">
    	<input type="text" name="keyword">
    	<select name="select_keyword">
      	  <option value="userid">아이디</option>
      	  <option value="keyword">내용</option>
      	  <option value="work_area">근무지역</option>
      	</select>
      	<c:if test="${page ne null }">
      		<input type="hidden" name="page" value="${page }"/>
      	</c:if>
      	<c:if test="${page eq null }">
      		<input type="hidden" name="page" value="1"/>
      	</c:if>
      	<input type="submit" value="검색">
    </form>
    <br>
  </div>
    
  	<div class="btn-group form-row float-right" style="padding: 0 10% 0 0"> <!-- float-right or float-left를 부모클래스에 정의하면 왼쪽, 오른쪽 정렬 -->
	
	  	
 	</div>
	</nav>
  
	<div>
  <form id="pagingForm" style="display: none;">
      <input type="text" name="page">
  </form>
	</div>
  
  <input id="insertAlert" type="hidden" value="${insert_result}">
  
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
  	  $('.pagination li a').click(function(){
  	    // pager 클래스의 하위 li 요소의 a 요소를 찾아감
  	    event.preventDefault(); // a 태그의 기본 동작(페이지 이동)을 금지
  	    var targetPage = $(this).attr('href'); // a 태그 href 속성의 값을 저장
  	    console.log(targetPage);
  	    
  	    var frm = $('#pagingForm'); // form의 정보를 frm에 저장
  	    frm.find('[name="page"]').val(targetPage);
  	    // name="page"인 요소를 찾아서 value값을 저장
  	    frm.attr('action', 'recruits'); // form에 action 속성-값 추가
  	    
  	// keyword를 세션으로 받아오기
  	    var keyword = '${keyword}';
  	    var select_keyword = '${select_keyword}';
  	    var workarea = '${work_area}';
  	    
  	    // 조건문으로 get/post방식을 나눠준다
  	    if (keyword !== null) {
  	    	frm.attr('method', 'post');
  	    	frm.find('[name="keyword"]').val(keyword);
  	    	frm.find('[name="select_keyword"]').val(select_keyword);
  	    	frm.find('[name="work_area"]').val(work_area);
  	    } else if (keyword === null){
	  	    frm.attr('method', 'get'); 
  	    }
  	    
  	    frm.submit(); // form 데이터 전송
  	  }); // end click()
  	  
  	  confirmInsertResult();
  	  function confirmInsertResult() {
  	    var result = $('#insertAlert').val();
  	    if (result === 'success') {
  	      alert('글을 성공적으로 작성했습니다.');
  	    } else if(result === 'fail'){
  	      alert('글을 작성하는데 실패했습니다.')
  	    }
  	  }
  	  
  		// WebSocket
		var sock = new WebSocket('ws://' + window.location.host + '/prj/studyBoard/websocket');
		  	  	
	  	sock.onopen = function() {
	  		console.log('websocket opened');
	  	};
	  	
	  	sock.onmessage = function (event) {
	  		// alarm
	  		if (event.data.split(',')[0] !== 'chatMsg') {
	  			$('#toast').show();		// 메세지가 오면 보이도록하기
		  		console.log('receive message : ' + event.data);
		  		message.innerHTML = event.data;	
	  		}
		  	
	  		
	  	};
	  	
	  	sock.onclose = function (event) {
	  		console.log('websocket closed : ' + event);
	  	};
	
	  	// detail-admin -> 참가 동의 / 참가 거절 알림 보내기!
	  	
  	}); // end document
  </script>
  
  
</body>
</html>