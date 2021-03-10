<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">

</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<meta charset="UTF-8">
<title>소모임 게시판</title>
</head>
<body>
	<h2>소모임게시판</h2>
	<hr>
  
  <!-- 글 작성 -->
  
  <c:if test="${not empty loginId}">
  	<a href="register"><input class="btn btn-light" type="button" value="글작성"></a>
  </c:if>
  
  <br> <br>
  
  <!-- 내 작성글 상단에 고정 / 작성글이 3개가 넘어가면 <글작성>버튼 숨기기 -->
  <c:if test="${loginId ne null }">
  <p> 나의 작성글 </p>
  <table class="table table-hover" id="List">
  	<thead>
  		<tr class="active">
	  		<th style="width: 60px;">번호</th>
	  	    <th style="width: 700px;">제목</th>
	  	    <th style="width: 70px;">조회수</th>
	  	    <th style="width: 60px;">정원</th>
	  	    <th style="width: 90px;">작성일</th>
  		</tr>
  	</thead>
  	
  	<tbody>
  		<c:forEach items="${boardList}" var="vo">
  	    <c:if test="${vo.study_userid eq loginId}">
  	    <tr>
  	      <td>${vo.study_bno }</td>
  	      <td>
  	      		<c:if test="${vo.study_crew_count < vo.study_crew_limit }">
  	      			<a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);"
	           href="detail-admin?bno=${vo.study_bno }&page=${pageMaker.criteria.page}">${vo.study_title }</a> <!-- 내글 -->
  	      		</c:if>
  	      		<c:if test="${vo.study_crew_count == vo.study_crew_limit }">
  	      			<a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);"
	           href="detail-admin?bno=${vo.study_bno }&page=${pageMaker.criteria.page}">${vo.study_title }&nbsp;(만원)</a> <!-- 내글 / 만원 -->
  	      		</c:if>
  	      </td>
  	      <c:set var="readcount">${vo.study_readcount }</c:set>
  	      <td>${readcount }</td>
  	      <c:set var="crewBno">${vo.study_crew_count }</c:set>
  	      <c:set var="crewLimit">${vo.study_crew_limit }</c:set>
  	      <td>${crewBno} / ${crewLimit }</td>
  	      <fmt:formatDate value="${vo.study_date }"
  	      	pattern="YYYY-MM-dd E a HH:mm:ss"
  	      	var="cdate"/>
  	      <td>${cdate }</td>
  	    </tr>
  	  </c:if>
  	  </c:forEach>
  	</tbody>
  </table>
  </c:if>
  
  <p>게시글 검색</p>
  <!-- 게시글 테이블 -->
  <table class="table table-hover" id="List">
  	<thead>
  	  <tr class="active">
  	    <th style="width: 60px;">번호</th>
  	    <th style="width: 500px;">제목</th>
  	    <th style="width: 60px;">작성자</th>
  	    <th style="width: 70px;">조회수</th>
  	    <th style="width: 60px;">정원</th>
  	    <th style="width: 200px;">선호지역</th>
  	    <th style="width: 90px;">작성일</th>
  	  </tr>
  	</thead>
  	<tbody>
  	  <c:forEach items="${boardList}" var="vo">
  	    <tr>
  	      <td>${vo.study_bno }</td>
  	      <td>
  	      	<c:if test="${vo.study_userid eq loginId }">
  	      		<c:if test="${vo.study_crew_count < vo.study_crew_limit }">
  	      			<a style="color: blue; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);"
	           href="detail-admin?bno=${vo.study_bno }&page=${pageMaker.criteria.page}">${vo.study_title }</a> <!-- 내글 -->
  	      		</c:if>
  	      		<c:if test="${vo.study_crew_count == vo.study_crew_limit }">
  	      			<a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);" href="detail-admin?bno=${vo.study_bno }&page=${pageMaker.criteria.page}">** ${vo.study_title }&nbsp;(만원)</a> <!-- 내글 / 만원 -->
  	      		</c:if>
  	      	</c:if>
  	      	<c:if test="${vo.study_userid ne loginId }">
  	      		<c:if test="${vo.study_crew_count < vo.study_crew_limit }">
	  	      		<a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);" href="detail?bno=${vo.study_bno }&page=${pageMaker.criteria.page}">${vo.study_title }</a> <!-- 남의 글 -->  	      		
  	      		</c:if>
  	      		<c:if test="${vo.study_crew_count == vo.study_crew_limit }">
  	      			<a style="color: black; 
	          text-decoration: none;
	          text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);" href="detail?bno=${vo.study_bno }&page=${pageMaker.criteria.page}">${vo.study_title }&nbsp;(만원)</a> <!-- 남의글 / 만원 -->
  	      		</c:if>
  	      	</c:if>
  	      </td>
  	      <td>${vo.study_userid }</td>
  	      <c:set var="readcount">${vo.study_readcount }</c:set>
  	      <td>${readcount }</td>
  	      <c:set var="crewBno">${vo.study_crew_count }</c:set>
  	      <c:set var="crewLimit">${vo.study_crew_limit }</c:set>
  	      <c:if test="${crewBno == crewLimit }"><td style="color:red;">${crewBno} / ${crewLimit }</td></c:if>
  	      <c:if test="${crewBno != crewLimit }"><td style="color:blue;">${crewBno } / ${crewLimit}</td></c:if>
  	      <td>
  	      	${vo.study_location } <br> ${vo.study_detail_location }
  	      </td>
  	      <fmt:formatDate value="${vo.study_date }"
  	      	pattern="YYYY-MM-dd E a HH:mm:ss"
  	      	var="cdate"/>
  	      <td>${cdate }</td>
  	    </tr>
  	  </c:forEach>
  	</tbody>
  </table>
  
  <hr>
   <nav aria-label="Page navigation example">
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
  </nav>
  
  <div>
    <form id="pagingForm" style="display: none;">
      <input type="text" name="page">
      <input type="hidden" name="keyword">
      <input type="hidden" name="select_keyword">
    </form>
  </div>
  
  <%-- 검색 기능 --%>
  <div>
    <form id="search" action="list" method="post">
    	<select name="select_keyword">
      	  <option value="userid">아이디</option>
      	  <option value="keyword">키워드</option>
      	  <option value="location">희망지역</option>
      	</select>
    	<input style="width:50%;" type="text" name="keyword">
      	<c:if test="${page ne null }">
      		<input type="hidden" name="page" value="${page }"/>
      	</c:if>
      	<c:if test="${page eq null }">
      		<input type="hidden" name="page" value="1"/>
      	</c:if>
      	<input class="btn btn-dark" type="submit" value="검색">
    </form>
  </div>
  <br><hr><br>
  
  
  <input id="insertAlert" type="hidden" value="${insert_result}">
  <input id="loginAlert" type="hidden" value="${login_result }">
  <input id="registerAlert" type="hidden" value="${register_result }">
  <input id="deleteAlert" type="hidden" value="${delete_result }">
  
  
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
  		
  	  $('.pager li a').click(function() {
  	    // pager 클래스의 하위 li 요소의 a 요소를 찾아감
  	    event.preventDefault(); // a 태그의 기본 동작(페이지 이동)을 금지
  	    var targetPage = $(this).attr('href'); // a 태그 href 속성의 값을 저장
  	    console.log(targetPage);
  	    
  	    var frm = $('#pagingForm'); // form의 정보를 frm에 저장
  	    frm.find('[name="page"]').val(targetPage);
  	    // name="page"인 요소를 찾아서 value값을 저장
  	    frm.attr('action', 'list.do'); // form에 action 속성-값 추가
  	    
  	    // keyword를 세션으로 받아오기
  	    var keyword = '${keyword}';
  	    var select_keyword = '${select_keyword}';
  	    
  	    // 조건문으로 get/post방식을 나눠준다
  	    if (keyword !== null) {
  	    	frm.attr('method', 'post');
  	    	frm.find('[name="keyword"]').val(keyword);
  	    	frm.find('[name="select_keyword"]').val(select_keyword);
  	    } else if (keyword === null){
	  	    frm.attr('method', 'get'); 
  	    }
  	    
  	    frm.submit(); // form 데이터 전송
  	  }); // end click()
  	  
  	  confirmInsertResult();
  	  function confirmInsertResult() {
  	    var result = $('#insertAlert').val();
  	    if (result === 'success') {
  	    	toastr["success"]("새 글 작성 성공");
  	    } else if(result === 'fail'){
  	      	toastr["error"]("새 글 작성 실패!");
  	    }
  	  }
  	  
	  
	  	confirmDeleteResult();
	  	function confirmDeleteResult() {
	    	var result = $('#deleteAlert').val();
	    	if (result === 'success') {
	    		toastr["success"]("게시글 삭제 성공");
	    	} else if(result === 'fail'){
	    		toastr["error"]("게시글 삭제 실패");
	    	}
	  	}
	  	
  	}); // end document
  	
  	</script>
  	
  	<br><hr>
  	
</body>
</html>