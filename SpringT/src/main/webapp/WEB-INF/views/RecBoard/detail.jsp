<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<title>${RecBoardVO.recruit_title }</title>
<style type="text/css">
	#btn_style{
		margin-left : 2px;
	}
	

</style>

</head>
<body>
<%-- <!-- secondHeader.jsp -->
	<jsp:include page="secondHeader.jsp" flush="true"></jsp:include> --%>
	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
  <h2 style="text-indent: 10%">Recruits</h2>
  <br>
  
	<br>
  <div class="container">
  <div class="col-md-12">
  <form action="detail" method="get">
  
  <label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
	<div class="form-control" style="border:none; float: left;" id="inputTitle">${RecBoardVO.recruit_title }</div>
	<div class="form-control" style="border:none; float: right;" id="inputTitle">${RecBoardVO.userid }</div>
  
  
  
  <div>
    <fmt:formatDate value="${RecBoardVO.r_date }" pattern="yyyy-MM-dd HH:mm:ss"
      var="rdate" />
    <p>작성일 : ${rdate }</p>
  </div>
  <br>
  <hr>
  
  <!-- select Option 작성 -->
  <br>
  <div class="form-group row mb-3">
					<label for="inputTitle" class="col-sm-2 col-form-label"><strong>지원자격</strong></label>
		            <br>
		            
		            <div class="col-sm-10">
		            <div>경력&emsp;
		            <c:set var="career" target="${RecBoardVO }" value="${career }"></c:set>
		            <c:choose>
		            <c:when test="${RecBoardVO.career eq 'newcomer' }">신입</c:when>
		            <c:when test="${RecBoardVO.career eq 'threeYears' }">1~3년</c:when>
		            <c:when test="${RecBoardVO.career eq 'sixYears' }">4~6년</c:when>
		            <c:when test="${RecBoardVO.career eq 'nineYears' }">7~9년</c:when>
		            <c:when test="${RecBoardVO.career eq 'tenOver' }">10년 이상</c:when>
		            <c:when test="${RecBoardVO.career eq 'RegardlessCareer' }">경력무관</c:when>
		            <c:otherwise>${RecBoardVO.career}</c:otherwise>
		            </c:choose>
		            </div>
		            &emsp;
					&emsp;
					&emsp;
					<div>학력&emsp;
					<c:set var="education" target="${RecBoardVO }" value="${education }"></c:set>
		            <c:choose>
		            <c:when test="${RecBoardVO.education eq 'GraduatedUniversity' }">대학교(4년) 졸업</c:when>
		            <c:when test="${RecBoardVO.education eq 'GraduatedCollege' }">대학교(2,3년) 졸업</c:when>
		            <c:when test="${RecBoardVO.education eq 'GraduatedMaster' }">대학원 석사 졸업</c:when>
		            <c:when test="${RecBoardVO.education eq 'GraduatedDoctor' }">대학원 박사 졸업</c:when>
		            <c:when test="${RecBoardVO.education eq 'GraduatedHighsch' }">고등학교 졸업</c:when>
		            <c:when test="${RecBoardVO.education eq 'RegardlessEducation' }">학력무관</c:when>
		            <c:otherwise>${RecBoardVO.education}</c:otherwise>
		            </c:choose>
		            </div>
		         </div>
		         </div>
		         <br>
		         <br>
				
		         <label for="inputTitle" class="col-form-label"><strong>근무조건</strong></label>
		            <br>
		            <br>
		            <div class="col-sm-10">
		            <div>급여&emsp;
		            <c:set var="education" target="${RecBoardVO }" value="${salary }"></c:set>
		            <c:choose>
		            <c:when test="${RecBoardVO.salary eq 'twentyFive' }">~ 2,500</c:when>
		            <c:when test="${RecBoardVO.salary eq 'thirtyFive' }">2,500 ~ 3,500</c:when>
		            <c:when test="${RecBoardVO.salary eq 'fourtyFive' }">3,500 ~ 4,500</c:when>
		            <c:when test="${RecBoardVO.salary eq 'fourtyFiveOver' }">4,500 ~</c:when>
		            <c:when test="${RecBoardVO.salary eq 'decisionAfter' }">면접 후 결정</c:when>
		            <c:otherwise>${RecBoardVO.salary}</c:otherwise>
		            </c:choose>
		            </div>
					<br>
					
					<div>지역&emsp;
					<c:set var="education" target="${RecBoardVO }" value="${work_area }"></c:set>
		            <c:choose>
		            <c:when test="${RecBoardVO.work_area eq '서울' }">서울</c:when>
		            <c:when test="${RecBoardVO.work_area eq '경기' }">경기</c:when>
		            <c:when test="${RecBoardVO.work_area eq '인천' }">인천</c:when>
		            <c:otherwise>${RecBoardVO.work_area}</c:otherwise>
		            </c:choose>
		            </div>
					
					<br>
					<div>직책&emsp;
					<c:set var="education" target="${RecBoardVO }" value="${position }"></c:set>
		            <c:choose>
		            <c:when test="${RecBoardVO.position eq 'employee' }">사원급</c:when>
		            <c:when test="${RecBoardVO.position eq 'assistant' }">주임~대리급</c:when>
		            <c:when test="${RecBoardVO.position eq 'deputy' }">과장~차장급</c:when>
		            <c:when test="${RecBoardVO.position eq 'generalMng' }">부장급</c:when>
		            <c:when test="${RecBoardVO.position eq 'preident' }">임원급</c:when>
		            <c:otherwise>${RecBoardVO.position}</c:otherwise>
		            </c:choose>
		            
		            </div>
					
					<br>
					<div>근무요일&emsp;
					<c:set var="education" target="${RecBoardVO }" value="${workday }"></c:set>
		            <c:choose>
		            <c:when test="${RecBoardVO.workday eq 'threeDays' }">주3일</c:when>
		            <c:when test="${RecBoardVO.workday eq 'fourDays' }">주4일</c:when>
		            <c:when test="${RecBoardVO.workday eq 'fiveDays' }">주5일</c:when>
		            <c:when test="${RecBoardVO.workday eq 'sixDays' }">주6일</c:when>
		            <c:otherwise>${RecBoardVO.workday}</c:otherwise>
		            </c:choose>
		            </div>
					</div>
					<br>
					<br>
					<hr>
					<br>
  
  
  <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>담당업무</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="responsibility" class="form-control" id="inputTitle" style="border:none;">${RecBoardVO.responsibility }</textarea>
	</div>
 </div>
 
 <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>우대조건</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="eligibility" class="form-control" id="inputTitle" style="border:none;">${RecBoardVO.eligibility }</textarea>
	</div>
 </div>
 <br>
 <hr>
 <br>
 
 <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>채용절차</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="recruitStep" class="form-control" id="inputTitle" style="border:none;">${RecBoardVO.recruitstep }</textarea>
	</div>
 </div>
 <br>
 
 <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>제출서류</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="requiredDoc" class="form-control" id="inputTitle" style="border:none;">${RecBoardVO.requireddoc }</textarea>
	</div>
 </div>
 <br>
 <hr>
 <br>
 
 <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>접수방법</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="applyWay" class="form-control" id="inputTitle" style="border:none;">${RecBoardVO.applyway }</textarea>
	</div>
 </div>
 <br>
 
 <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>접수기간</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="applyPeriod" class="form-control" id="inputTitle" style="border:none;">${RecBoardVO.applyperiod }</textarea>
	</div>
 </div>
 <hr>
  
  <!-- <div class="form-group text-center float-right"> 
		<button type="button" value="새창" class="btn btn-light btn_register" style="background-color: dimgrey; color: white;" onclick="window.open('../RecBoard/applRegister','지원하기','width=650, height=800')">지원하기</button> 
	</div>  -->
	<br>
	<br>
 	<div>  	
 	<div>	
 		<c:if test="${loginId ne null }"><input type="button" id="bookmark" class="btn btn-light" style="background: silver;" onclick="bookmarkresult()" value="찜"></c:if>&nbsp;&nbsp;&nbsp;
  		<button class="btn btn-dark float-right" type="button" value="글 목록" onclick="location.href='recruits?page=${page }'">글 목록</button>
  	</div>
  	
  	<c:if test="${RecBoardVO.userid eq loginId }">
  	<div>
		<a class="btn btn-dark" type="button" onclick="return confirm('글을 삭제하시겠습니까?')" href="delete?rno=${RecBoardVO.rno }">글 삭제</a>
	</div>
	</c:if>
	</div>
  </form>
  </div>
  </div>
  <br>
  <input type="hidden" id="rno" value="${RecBoardVO.rno }">
<script type="text/javascript">
  	
  	$(document).ready(function(){
			/* 북마크 확인 */
			bookmarkCheck();
			function bookmarkCheck(){
				var id = $('#loginId').val(); 
				var bno = $('#rno').val();
					var bookmark = {
					userid : id,
					bookmark_table_name : "recruit_table",
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
  		
  		
		


	//	=============  찜되었는지 확인해서 표시해주기 (JS) ============= 

  	});
  	
  	/* 북마크 추가&삭제 */
	function bookmarkresult(){
		console.log("bookmark start");
		var bookmark = $('#bookmark');
		if (bookmark.val() === "찜됨") {
			var id = $('#loginId').val();  // 로그인아이디
			var bno = $('#rno').val();   // 게시글 번호
				var bookmark = {
				userid : id,
				bookmark_table_name : "recruit_table",
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
			var bno = $('#rno').val();
				var bookmark = {
				userid : id,
				bookmark_table_name : "recruit_table",
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










