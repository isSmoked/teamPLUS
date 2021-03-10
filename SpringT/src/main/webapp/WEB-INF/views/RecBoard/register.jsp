<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성 페이지</title>

<style type="text/css">
	.indent {text-indent: 20%}
	
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
	<br>
	<br>
	<br>
	
	<h2 class="indent">Recruit게시판 구인하기</h2>
	<br>
	<br>
	<br>
  	<div class="container">
  		<div class="col-md-12">
  			<form name="regForm" action="register" method="POST">
  				<div class="form-group row mb-3">
		  			<label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
		            <div class="col-sm-10">
		                <input type="text" name="recruit_title" class="form-control" id="inputTitle" required="required">
		            </div>
  				</div>
  				
  				<div class="form-group row mb-3">
		  			<label for="inputTitle" class="col-sm-2 col-form-label"><strong>이름</strong></label>
		            <div class="col-sm-10">
		                <input type="text" name="rname" class="form-control" id="inputTitle" required="required">
		            </div>
  				</div>
  				<p>작성자 : ${loginId }
      			<input type="hidden" name="userid" value="${loginId}">
  				
  				
  				<div class="form-group row mb-3">
					<label for="inputTitle" class="col-sm-2 col-form-label"><strong>지원자격</strong></label>
		            &emsp;
		            <a>경력</a>&emsp;
		            <select name="career" >
					  <option value="newcomer" selected>신입</option>
					  <option value="threeYears">1~3년</option>
					  <option value="sixYears">4~6년</option>
					  <option value="nineYears">7~9년</option>
					  <option value="tenOver">10년 이상</option>
					  <option value="RegardlessCareer">경력무관</option>
					</select>
					&emsp;
					&emsp;
					&emsp;
					<a>학력</a>&emsp;
		            <select name="education" >
					  <option value="GraduatedUniversity" selected>대학교(4년) 졸업</option>
					  <option value="GraduatedCollege">대학교(2,3년) 졸업</option>
					  <option value="GraduatedMaster">대학원 석사 졸업</option>
					  <option value="GraduatedDoctor">대학원 박사 졸업</option>
					  <option value="GraduatedHighsch">고등학교 졸업</option>
					  <option value="RegardlessEducation">학력무관</option>
					</select>
  				</div>
				
		         <label for="inputTitle" class="col-form-label"><strong>근무조건</strong></label>
		            &emsp;
		            <div class="col-sm-10">
		            <div class="indent">급여&emsp;
		            <select name="salary" >
					  <option value="twentyFive" selected>~ 2,500</option>
					  <option value="thirtyFive">2,500 ~ 3,500</option>
					  <option value="fourtyFive">3,500 ~ 4,500</option>
					  <option value="fourtyFiveOver">4,500 ~</option>
					  <option value="decisionAfter">면접 후 결정</option>
					</select>
					</div>
					<br>
					
					<div class="indent">지역&emsp;
		            <select name="work_area" >
					  <option value="서울" selected>서울</option>
					  <option value="경기">경기</option>
					  <option value="인천">인천</option>
					</select>
					</div>
					
					<br>
					<div class="indent">직책&emsp;
		            <select name="position" >
					  <option value="employee" selected>사원급</option>
					  <option value="assistant">주임~대리급</option>
					  <option value="deputy">과장~차장급</option>
					  <option value="generalMng">부장급</option>
					  <option value="preident">임원급</option>
					</select>
					</div>
					
					<br>
					<div class="indent">근무요일&emsp;
		            <select name="workday" >
					  <option value="threeDays">주3일</option>
					  <option value="fourDays">주4일</option>
					  <option value="fiveDays" selected>주5일</option>
					  <option value="sixDays">주6일</option>
					</select>
					</div>
					</div>
					<br>
					<br>
  				
  				
  				<div class="form-group row mb-3">
		  			<label for="inputTitle" class="col-sm-2 col-form-label"><strong>담당업무</strong></label>
		            <div class="col-sm-10">
		                <textarea rows="10" cols="30"  name="responsibility" class="form-control" id="inputTitle" required="required"></textarea>
		            </div>
  				</div>
  				
  				<div class="form-group row mb-3">
		  			<label for="inputTitle" class="col-sm-2 col-form-label"><strong>지원자격</strong></label>
		            <div class="col-sm-10">
		                <textarea rows="10" cols="30"  name="eligibility" class="form-control" id="inputTitle" required="required"></textarea>
		            </div>
  				</div>
  				
  				<div class="form-group row mb-3">
		  			<label for="inputTitle" class="col-sm-2 col-form-label"><strong>채용절차</strong></label>
		            <div class="col-sm-10">
		                <textarea rows="" cols="" name="recruitstep" class="form-control" id="inputTitle" required="required"></textarea>
		            </div>
  				</div>
  				
  				<div class="form-group row mb-3">
		  			<label for=
		  			"inputTitle" class="col-sm-2 col-form-label"><strong>제출서류</strong></label>
		            <div class="col-sm-10">
		                <textarea rows="" cols="" name="requireddoc" class="form-control" id="inputTitle" required="required"></textarea>
		            </div>
  				</div>
  				
  				
  				<div class="form-group row mb-3">
		  			<label for="inputTitle" class="col-sm-2 col-form-label"><strong>접수방법</strong></label>
		            <div class="col-sm-10">
		            <textarea rows="" cols="" name="applyway" class="form-control" id="inputTitle" required="required"></textarea>
		            </div>
  				</div>
  				
  				<div class="form-group row mb-3">
		  			<label for="inputTitle" class="col-sm-2 col-form-label"><strong>접수기간</strong></label>
		            <div class="col-sm-10">
		            <textarea rows="" cols="" name="applyperiod" class="form-control" id="inputTitle" required="required"></textarea>
		            </div>
  				</div>
  				
  				<div>  		
  					<button class="btn btn-dark float-right" type="submit" id="insertCheck" value="등록" onclick="return confirm('글을 등록하면 수정할 수 없습니다.\n 글을 등록하시겠습니까?')">등록</button>
			    </div>
  				
			</form>
			
  		</div>
  	</div>
 	<br><br><br><br><br><br>
</body>
</html>

