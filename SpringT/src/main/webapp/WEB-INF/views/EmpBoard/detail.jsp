<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<title>${EmpBoardVO.employ_title }</title>
<style type="text/css">
	#btn_style{
		margin-left : 2px;
	}
	.indent {text-indent: 20%}
	
	div > div > input{
		style="border:none;"
	}
	/* .dropdown:hover > .dropdown-menu {display:block; margin:0;} - 드롭다운 마우스오버 */
</style>
</head>
<body>
	
	<%-- <jsp:include page="secondHeader.jsp" flush="true"></jsp:include> --%>
	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
  <h2 style="text-indent: 20%">Employees</h2>
  
  <br>
	<br>
  <div class="container">
  <div class="col-md-12">
  <form action="detail" method="get">
  
  <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
	<div class="col-sm-10">
		<input type="text" name="employTitle" class="form-control" id="employ_title" value="${EmpBoardVO.employ_title }" style="border:none;">
	</div>
  </div>
  
  <div class="form-group row mb-3">
	<label for="inputTitle" class="col-sm-2 col-form-label">작성자</label>
	 <div class="col-sm-10">
		<input type="text" name="userid" class="form-control" id="userid" value="${EmpBoardVO.userid }" style="border:none;">
	</div>
  </div>
  <br>
  <div>
    <fmt:formatDate value="${EmpBoardVO.e_date }" pattern="yyyy-MM-dd HH:mm:ss"
      var="edate" />
    <p style="font-size: 0.9em;">작성날짜 : ${edate }</p>
  </div>
  
  <br>
  <hr>
  <br>
  
  <div class="form-group row mb-3">
  <label for="inputTitle" class="col-sm-2 col-form-label"><strong>이름</strong></label>
	<div class="col-sm-10">
		<input type="text" name="uname" class="form-control" id="uname" value="${EmpBoardVO.uname }" style="border:none;">
	</div>
  </div>
  
  <div class="form-group row mb-3">
	<label for="birth" class="col-sm-2 col-form-label"><strong>생년월일</strong></label>
	<div class="col-sm-10">
		<input type="tel" name="birth" class="form-control" id="birth" value="${EmpBoardVO.birth }" style="border:none;">
	</div>
  </div>
  
  <div class="form-group row mb-3">
	<label for="email" class="col-sm-2 col-form-label"><strong>이메일</strong></label>
	<div class="col-sm-10">
		<input type="email" name="email" class="form-control" id="email" value="${EmpBoardVO.email }" style="border:none;">
	</div>
  </div>
  
  <div class="form-group row mb-3">
  	<label for="phone" class="col-sm-2 col-form-label"><strong>핸드폰</strong></label>
	<div class="col-sm-10">
		<input type="tel" name="phone" class="form-control" id="phone" value="${EmpBoardVO.phone }" style="border:none;">
	</div>
  </div>
  
  <div class="form-group row mb-3">
	<label for="gender" class="col-sm-2 col-form-label"><strong>성별</strong></label>
	<div class="col-sm-10">
		<c:set var="gender" target="${EmpBoardVO }" value="${gender }"></c:set>
		            <c:choose>
		            <c:when test="${EmpBoardVO.gender eq 'woman' }">여자</c:when>
		            <c:when test="${EmpBoardVO.gender eq 'man' }">남자</c:when>
		            <c:otherwise>${EmpBoardVO.gender}</c:otherwise>
		            </c:choose>
	</div>
  </div>
  
  <div class="form-group row mb-3">
	<label for="oaddress" class="col-sm-2 col-form-label"><strong>우편번호</strong></label>
	<div class="col-sm-10">
		<input type="text" name="oaddress" class="form-control" id="oaddress" value="${EmpBoardVO.oaddress }" readonly="readonly">
	</div>
  </div>
  
  <div class="form-group row mb-3">
	<label for="address" class="col-sm-2 col-form-label"><strong>도로명 주소</strong></label>
	<div class="col-sm-10">
		<input type="text" name="address" class="form-control" id="address" value="${EmpBoardVO.address }" style="border:none;">
	</div>
  </div>
  
  <div class="form-group row mb-3">
	<label for="detailAddress" class="col-sm-2 col-form-label">상세주소</label>
	<div class="col-sm-10">
		<input type="text" name="detailAddress" class="form-control" id="detail_address" value="${EmpBoardVO.detail_address }" style="border:none;">
	</div>
  </div>
  
  <br>
  <hr>
  <br>
  
  <!-- select Option 작성 -->
  <br>
  <div>
					<div class="form-group row mb-3">
		            <div><strong>고용형태</strong>&emsp;
		            <c:set var="emplementType" target="${EmpBoardVO }" value="${emplementtype }"></c:set>
		            <c:choose>
		            <c:when test="${EmpBoardVO.emplementtype eq 'intern' }">인턴</c:when>
		            <c:when test="${EmpBoardVO.emplementtype eq 'contract' }">계약직</c:when>
		            <c:when test="${EmpBoardVO.emplementtype eq 'regular' }">정규직</c:when>
		            <c:when test="${EmpBoardVO.emplementtype eq 'freelancer' }">프리랜서</c:when>
		            <c:otherwise>${EmpBoardVO.emplementtype}</c:otherwise>
		            </c:choose>
		            </div>
		            </div>
		            <br>
					<div class="form-group row mb-3">
		            <div><strong>희망연봉</strong>&emsp;
		            <c:set var="salary" target="${EmpBoardVO }" value="${salary }"></c:set>
		            <c:choose>
		            <c:when test="${EmpBoardVO.salary eq 'twentyFive' }">~ 2,500</c:when>
		            <c:when test="${EmpBoardVO.salary eq 'thirtyFive' }">2,500 ~ 3,500</c:when>
		            <c:when test="${EmpBoardVO.salary eq 'fourtyFive' }">3,500 ~ 4,500</c:when>
		            <c:when test="${EmpBoardVO.salary eq 'fourtyFiveOver' }">4,500 ~</c:when>
		            <c:when test="${EmpBoardVO.salary eq 'decisionAfter' }">면접 후 결정</c:when>
		            <c:otherwise>${EmpBoardVO.salary}</c:otherwise>
		            </c:choose>
		            </div>
		            </div>
		         
		         
		        	<br>
				    <div class="form-group row mb-3">
		            <div><strong>병역</strong>&emsp;
		            <c:set var="militeryService" target="${EmpBoardVO }" value="${militeryservice }"></c:set>
		            <c:choose>
		            <c:when test="${EmpBoardVO.militeryservice eq 'uncomMiltr' }">미필</c:when>
		            <c:when test="${EmpBoardVO.militeryservice eq 'comMiltr' }">군필</c:when>
		            <c:when test="${EmpBoardVO.militeryservice eq 'naMiltr' }">해당없음</c:when>
		            <c:otherwise>${EmpBoardVO.militeryservice}</c:otherwise>
		            </c:choose>
		            </div>
		            </div>
					<br>
					<hr>
					<br>
					
					<div class="form-group row mb-3">
					<div><strong>희망 근무지역</strong>&emsp;
					<c:set var="workArea" target="${EmpBoardVO }" value="${work_area }"></c:set>
		            <c:choose>
		            <c:when test="${EmpBoardVO.work_area eq 'Seoul' }">서울</c:when>
		            <c:when test="${EmpBoardVO.work_area eq 'Gyunggi' }">경기</c:when>
		            <c:when test="${EmpBoardVO.work_area eq 'Incheon' }">인천</c:when>
		            <c:otherwise>${EmpBoardVO.work_area}</c:otherwise>
		            </c:choose>
		            </div>
		            </div>
					<br>
					<hr>
					<br>
					
					<div class="form-group row mb-3">
					<div><strong>학력</strong>&emsp;
					<c:set var="education" target="${EmpBoardVO }" value="${education }"></c:set>
		            <c:choose>
		            <c:when test="${EmpBoardVO.education eq 'GraduatedHighsch' }">고등학교 졸업</c:when>
		            <c:when test="${EmpBoardVO.education eq 'GraduatedCollege' }">대학교(2,3년) 졸업</c:when>
		            <c:when test="${EmpBoardVO.education eq 'GraduatedUniversity' }">대학교(4년) 졸업</c:when>
		            <c:when test="${EmpBoardVO.education eq 'GraduatedMaster' }">대학원 석사 졸업</c:when>
		            <c:when test="${EmpBoardVO.education eq 'GraduatedDoctor' }">대학원 박사 졸업</c:when>
		            <c:otherwise>${EmpBoardVO.education}</c:otherwise>
		            </c:choose>
		            </div>
		            </div>
		            <br>
		            
		            <div class="form-group row mb-3">
		            <div><strong>경력</strong>&emsp;
					<c:set var="career" target="${EmpBoardVO }" value="${career }"></c:set>
		            <c:choose>
		            <c:when test="${EmpBoardVO.career eq 'newcomer' }">신입</c:when>
					<c:when test="${EmpBoardVO.career eq 'threeYears' }">1~3년</c:when>
					<c:when test="${EmpBoardVO.career eq 'sixYears' }">4~6년</c:when>
					<c:when test="${EmpBoardVO.career eq 'nineYears' }">7~9년</c:when>
					<c:when test="${EmpBoardVO.career eq 'tenOver' }">10년 이상</c:when>
		            <c:otherwise>${EmpBoardVO.career}</c:otherwise>
		            </c:choose>
		            </div>
		            </div>
					</div>
					<br>
					<hr>
  
  
  <div class="form-group row mb-3">
	<label for="certificates" class="col-sm-2 col-form-label"><strong>자격증/어학</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="certificates" class="form-control" id="certificates" style="border:none;">${EmpBoardVO.certificates }</textarea>
	</div>
 </div>
 
 <div class="form-group row mb-3">
	<label for="selfintroduce" class="col-sm-2 col-form-label"><strong>자기소개서</strong></label>
	<div class="col-sm-10">
		<textarea rows="" cols=""  name="selfintroduce" class="form-control" id="selfintroduce" style="border:none;">${EmpBoardVO.selfintroduce }</textarea>
	</div>
 </div>
 
 	<!-- <div class="form-group text-center float-right"> 
		<button type="button" value="새창" class="btn btn-light btn_register" style="background-color: dimgrey; color: white;" onclick="window.open('../RecBoard/applRegister','지원하기','width=650, height=800')">지원하기</button> 
	</div>
  	<br> -->
	<br>
	<br>
 	<div>  	
 	<div>	
  		<input type="button" id="bookmark" onclick="bookmark()" value="찜">
  		&nbsp;&nbsp;
  		<button class="btn btn-dark float-right" type="button" value="글 목록" onclick="location.href='employees?page=${page }'">글 목록</button>
  	</div>
  	<div>
		<a class="btn btn-dark" type="button" onclick="return confirm('글을 삭제하시겠습니까?')" href="empDelete?eno=${EmpBoardVO.eno }">글 삭제</a>
	</div>
	</div>
	
	 
  
  </form>
  </div>
  </div>
  <input type="hidden" id="eno" value="${EmpBoardVO.eno }">
  <script type="text/javascript">
  	var phoneNum = $('#phone');
  	var frm = document.employTable;
  	function 
  	if(employTable.)phoneNum = phoneNum.replace
  	
  	$(document).ready(function(){
  		
  		// ******************************************************************
		
  		// WebSocket
	  	var URL = window.location.host + window.location.pathname;
	  	var serverURL = URL.split("/")[0];
	  	console.log('url : ' + URL);
	  	console.log('host : ' + window.location.host);
	  	
	  	
		var sock = new WebSocket('ws://' + window.location.host + '/prj/EmpBoard/websocket');
	  	
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
		/* 북마크 추가&삭제 */
		function bookmark(){
			console.log("bookmark start");
			var bookmark = $('#bookmark');
			if (bookmark.val() === "찜됨") {
				var id = $('#loginId').val();  // 로그인아이디
				var bno = $('#eno').val();   // 게시글 번호
					var bookmark = {
					userid : id,
					bookmark_table_name : "employ_table",
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
					bookmark_table_name : "employ_table",
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


		=============  찜되었는지 확인해서 표시해주기 (JS) ============= 

			/* 북마크 확인 */
			bookmarkCheck();
			function bookmarkCheck(){
				var id = $('#loginId').val(); 
				var bno = $('#bno').val();
					var bookmark = {
					userid : id,
					bookmark_table_name : "employ_table",
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
  	});
  </script>
</body>
</html>