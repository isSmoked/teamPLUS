<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div style="padding: 0 10% 0 10%">
	<table class="table table-hover" id="List">
	    <thead>
	      <tr class="active">
	        <th style="width: 60px;">번호</th>
	        <th style="width: 700px;">제목</th>
	        <th style="width: 60px;">작성자</th>
	        <th style="width: 100px;">작성일</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:forEach var="EmpVO" items="${EmpBoardList }">
	        <tr>
	          <td>${EmpVO.eno }</td>
	          <td><a href="detail?eno=${EmpVO.eno }&page=${pageMaker.criteria.page}">${EmpVO.employTitle }</a></td>
	          <td>${EmpVO.userid }</td>
	          <fmt:formatDate value="${EmpVO.edate }"
	            pattern="yyyy-MM-dd HH:mm:ss"
	            var="edate"/>
	          <td>${edate }</td>
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
    
  	<div class="btn-group form-row float-right" style="padding: 0 10% 0 0"> <!-- float-right or float-left를 부모클래스에 정의하면 왼쪽, 오른쪽 정렬 -->
	</div>
	
	</nav>
</body>
</html>