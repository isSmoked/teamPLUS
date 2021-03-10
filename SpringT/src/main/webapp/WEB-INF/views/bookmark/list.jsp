<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="UTF-8">
<title>Bookmark</title>
</head>
<body>
	
  <h2>찜 목록</h2>
  <hr>
  
   <div id="totalCount"></div>
  <div style="width:90%;">
  <button id="deleteList" class="btn btn-dark">선택된글삭제</button>&nbsp;|&nbsp;<button class="btn btn-dark" id="deleteDeadList">삭제된목록삭제</button>
  	<div style="float: right;">
	  	PAGE : 
	  	<select name="perPage">
	  		<option value="10">10</option>
	  		<option value="20">20</option>
	  		<option value="30">30</option>
	  		<option value="40">40</option>
	  		<option value="50">50</option>
	  	</select>
	</div>
  </div>
  
  <br>
  
  <!-- ********************** Board Table ********************** -->
<!--   <table style="width: 90%;" class="table table-hover" id="List">
    <thead>
      <tr class="active">
        <th style="min-width: 60px; width: 5%;">글번호</th>
        <th style="min-width: 100px; width: 10%;">게시판</th>
        <th style="min-width: 100px; width: 50%;">제목</th>
        <th style="min-width: 60px; width: 10%;">작성자</th>
        <th style="min-width: 60px; width: 10%;">날짜</th>
        <th style="min-width: 50px; width: 5%;">삭제</th>
      </tr>
    </thead>
 -->    
      <table style="width: 90%; clear: both;">
    <thead>
      <tr class="active">
      	<th style="width:3%;"><input type="checkbox" id="checkAll"></th>
        <th style="min-width: 60px; width: 5%;">번호</th>
        <th style="min-width: 100px; width: 10%;">게시판</th>
        <th style="min-width: 100px; width: 50%;">제목</th>
        <th style="min-width: 60px; width: 10%;">작성자</th>
        <th style="min-width: 60px; width: 10%;">날짜</th>
        <th style="min-width: 50px; width: 5%;">삭제</th>
      </tr>
    </thead>
    <tbody id="tableBody">
 <%--      <c:forEach var="vo" items="${bookmarkList}">
        <tr>
          <td>${vo.bookmark_bno }</td>
          <td>
          	<c:if test="${vo.bookmark_table_name eq 'freeboard_table'}">자유게시판</c:if>
       	  	<c:if test="${vo.bookmark_table_name eq 'qaboard_table'}">질문게시판</c:if>
        	<c:if test="${vo.bookmark_table_name eq 'shareboard_table'}">공유게시판</c:if>
          </td>
          <td>
          	<c:choose>
	          <c:when test="${vo.bookmark_title ne null }">
	          	<a href="/project/<c:if test="${vo.bookmark_table_name eq 'freeboard_table'}">freeboard</c:if><c:if test="${vo.bookmark_table_name eq 'qaboard_table'}">qaboard</c:if><c:if test="${vo.bookmark_table_name eq 'shareboard_table'}">shareboard</c:if>/detail?bno=${vo.bookmark_bno }&page=${pageMaker.criteria.page}"><c:out value="${vo.bookmark_title}"/></a>
	          </c:when>
	          <c:otherwise>
	          	게시글이 삭제 되었거나 변경 되었습니다.
	          </c:otherwise>
	         </c:choose>
          </td>
          <td>${vo.bookmark_writer }</td>
          <fmt:formatDate value="${vo.bookmark_date }"
            pattern="yyyy-MM-dd HH:mm:ss"
            var="bookmark_date"/>
          <td>${bookmark_date }</td>
          <td>
          <a href="delete?no=${vo.bookmark_no }" class="deleteLink" onclick="return false"><input type="button" style="color:red;" onclick="deleteConfirm()" value="X"></a>
          </td>
        </tr>
      </c:forEach> --%>
    </tbody>
  </table>
  <hr>
  
  <!-- ********************** Board Paging ********************** -->
<%--   <nav aria-label="Page navigation example">
  <div style="width:90%; font-size: xx-large;">
	  <ul class="pagination" style="justify-content: center;">
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
  </nav> --%>
    <div id="paging" style="width:90%;"></div>
  
  <div>
    <form id="pagingForm" style="display: none;">
      <input type="text" name="page">
    </form>
  </div>
  
  <input type="hidden" id="loginId" value="${loginId }">
  <input id="resultAlert" type="hidden" value="${resultAlert}">
  
  <script type="text/javascript">
//toastr
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
					
					
		// paging
	  	$(document).ready(function(){
	  		bodyList();
	  		paging();
	  	}); // end document
  	
 		// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  	
		/* perPage */
		$(document).on("change", "select[name=perPage]", function(){
	  		console.log($(this).val()); //value값 가져오기
	  		console.log($("select[name=perPage] option:selected").text()); //text값 가져오기
	  		bodyList();
	  		paging();
		}); // perPage
		
	 	/* 리스트 불러오기 */
	 	function bodyList(target){
	 		console.log("ajax bodyList start");
	 		var loginId = $('#loginId').val();
	 		var perPage = $("select[name=perPage] option:selected").val();

		 	var listData = {
		 		"loginId" : loginId,
		 		"page" : target,
		 		"perPage" : perPage
		 	};
		 	console.log("listData : " + listData);
		 	
	 		$.ajax({
	 			url : "bookmark/list",
	 			type : "get",
	 			data : listData,
	 			success : function(data){
	 				console.log("bodyList start");
	 				console.log(data);
	 				$('#tableBody').html("");
	 				var list = "";
	 				$(data).each(function(){
	 					var bookmark_date = moment(new Date(this.bookmark_date)).format('YYYY-MM-DD HH:mm:ss');
	 					list += '<tr>'
	 				      	+ '<td><input type="checkbox" name="checkRow" value="' + this.bookmark_no + '"></td>'
	 				   		+ '<td>' + this.bookmark_bno + '</td>'
	  	 				+ '<td>'
	  	 				switch(this.bookmark_table_name){
	  	 				case "freeboard_table" : list += '자유게시판'; break; 
	  	 				case "qaboard_table" : list += '질문게시판'; break;
  	 					case "shareboard_table" : list += '공유게시판'; break;
  	 					case "recruit_table" : list += '구직게시판'; break;
	  	 				}
						list += '</td>'
	  	 				+ '<td>'
	  	 				if (this.bookmark_title != null){
	  	 					list += '<a href="/prj/'
	  	 					switch(this.bookmark_table_name){
	  	 					case "freeboard_table" : list += 'freeboard'; break;
	  	 					case "qaboard_table" : list += 'qaboard'; break;
	  	 					case "shareboard_table" : list += 'shareboard'; break;
	  	 					case "recruit_table" : list += 'RecBoard'; break; 
	  	 					}
	  	 					list += '/detail?bno=' + this.bookmark_bno + '&page=1">'
		  	 				+ this.bookmark_title + '</a>'
	  	 				} else {
	  	 				list += '<div style="color:lightgrey;">게시글이 삭제 되었습니다.</div>'
	  	 				}
	  	 				list += '</td>'
	  	 				+ '<td>' 
	  	 				if (this.bookmark_writer != null){
	  	 					list += this.bookmark_writer
	  	 				} else {
	  	 					list += '.'
	  	 				}
	  	 				list += '</td>'
	  	 				
	  	 				+ '<td>' + bookmark_date + '</td>'
	  	 				+ '<td>'
	  	 				+ '<a href="javascript:deleteOne(' + this.bookmark_no 
	 							+ ')" class="deleteOne" onclick="return false">'
	 							+ '<span onclick="deleteConfirm()">삭제</span>'
	 							//+ '<input type="button" style="color:red;" onclick="deleteConfirm()" value="X">'
	 						+'</a>'
	  	 				+ '</td>'
	  	 				+ '</tr>'
	 				}); // each
	 					$('#tableBody').html(list);
	 					$("#checkAll").prop("checked", false);
	 			}, error : function(error, request){
	 				console.log("*** code:"+request.status+"\n"+"*** message:"+request.responseText+"\n"+"*** error:"+error);
	 				alert("error");
	 			} // error
	 		}); // ajax
	 	} // bodyList()
	 	
	 	
	  /* 페이징 */
	  $(document).on('click', '.pager li a', function(){
		  console.log("paging start");
	    // pager 클래스의 하위 li 요소의 a 요소를 찾아감
	    event.preventDefault(); // a 태그의 기본 동작(페이지 이동)을 금지
	    var targetPage = $(this).attr('href'); // a 태그 href 속성의 값을 저장
	    console.log(targetPage);
	    bodyList(targetPage);
	    paging(targetPage);
	  }); // end click()
  
	  
	/* 리스트 페이징 */
	function paging(target){
		console.log("ajax paging");
		var loginId = $('#loginId').val();
		var perPage = $("select[name=perPage] option:selected").val();
	 	
	 	var listData = {
	 			"userid" : loginId,
	 			"page" : target,
	 			"perPage" : perPage
	 	};
	 	console.log("listData : " + listData);
	 	
		$.ajax({
			url : "bookmark/paging",
			type : "get",
			data : listData,
			success : function(data){
				console.log("paging start");
				console.log("paging data : " + data);
				console.log("paging totalCount : " + data.totalCount);
				$('#totalCount').html("<p>총 게시물 : " + data.totalCount + "</p>");
				
				$('#paging').html("");
				var list ="";
	 				list += '<ul class="pager pagination" style="justify-content: center;">'
	 			    if (data.hasPrev){
	 			    	var start = data.startPageNo - 1;
	 			    	list += '<li class="page-item"><a href="'+ start + '" class="page-link" aria-label="Previous">이전</a></li>'
	 			    } 
			    	for (var i = data.startPageNo; i <= data.endPageNo; i++) {
			    		list += '<li class="page-item">&nbsp;<a href="' + i + '" class="page-link">' + i + '</a></li>'
			    	}
	 			    if (data.hasNext){
	 			    	var end = data.endPageNo + 1;
	 			    	list += '<li class="page-item"><a href="' + end + '" class="page-link" aria-label="Previous">다음</a></li>'
	 			    }
	 			  	list += '</ul>'
				
				$('#paging').html(list);
			}, error : function(error, request){
				console.log("paging error : " + error);
				console.log("*** code:"+request.status+"\n"+"*** message:"+request.responseText+"\n"+"*** error:"+error);
				alert("error");
			} // error
		}); // ajax
	} // paging()


	/* 전체선택 */
$('#checkAll').click(function(){
    if ($("input:checkbox[id='checkAll']").prop("checked")) {
        $("input[type=checkbox]").prop("checked", true);
    } else {
        $("input[type=checkbox]").prop("checked", false);
    }
}); // 전체선택


/* 선택된 게시글 삭제 */
$(document).on("click", "#deleteList", function(){
	console.log("deleteList click");
	var checkCount = $("input[name='checkRow']:checked").length;
	console.log(checkCount);
	if (checkCount === 0){
	} else {
		
    	if (confirm("선택된 데이터가 삭제됩니다.\n삭제하시겠습니까?")){
    		var count = 0;
	    	$("input[name='checkRow']:checked").each(function(){
	    		count++;
	    		var n = $(this).val();
	    		$.ajax({
	    			url : "bookmark/deleteBookmark?n=" + n,
	    			type : "get",
	    			success : function(data){
	    				if(data === 1){
	    					console.log("삭제완료 : " + data);
	    				} else {
	    					console.log("삭제실패 : " + data);
	    				}
	    			}, error : function(error, reqeust){
	    				console.log("*** code:"+request.status+"\n"+"*** message:"+request.responseText+"\n"+"*** error:"+error);
	       				alert("error");
	    			}
	    		}); // ajax
	    	}); // each
	    	bodyList();
	    	paging();
	    	toastr["info"](count + "개의 데이터가 삭제되었습니다.");
    	} // if
	}
}); // deleteList


/* Dead List 삭제 */
$(document).on("click", "#deleteDeadList", function(){
	console.log("deleteDeadList click");
	if (confirm("삭제된 게시글 목록이 삭제됩니다.\n삭제하시겠습니까?")){
    	var loginId = {"loginId" : $('#loginId').val()};
    	$.ajax({
    		url : "bookmark/deleteDeadList",
    		data : loginId,
    		success : function(data){
    			console.log("삭제성공 : " + data);
    			toastr["info"](data + "개의 데이터가 삭제되었습니다.");
    			bodyList();
    			paging();
    		}, error : function(error, request){
    			console.log("*** code:"+request.status+"\n"+"*** message:"+request.responseText+"\n"+"*** error:"+error);
   				alert("error");
    		}
    	}); // ajax
	} // if
}); // deleteDeadList


/* 삭제 버튼 */
function deleteConfirm(){
	if(confirm("선택된 데이터가 삭제됩니다.\n삭제하시겠습니까?")){
		  $('.deleteOne').attr("onclick", "return true");
	  } else {
		  $('.deleteOne').attr("onclick", "return false");
	  }
  } // deleteConfirm()

  
/* 한개씩 삭제 */
function deleteOne(e){
	console.log(e);
	$.ajax({
		  url : "bookmark/deleteBookmark?n=" + e,
		  success : function(data){
			  if(data === 1){
				  toastr["info"]("데이터가 삭제되었습니다.");
				  bodyList();
				  paging();
			  } else {
				  toastr["error"]("삭제 실패.");
			  }
		  }, error : function(error, request){
			  console.log("*** code:"+request.status+"\n"+"*** message:"+request.responseText+"\n"+"*** error:"+error);
			  alert("error");	
		  }
	  }); // ajax
} // deleteOne
  	
  	
  </script>
</body>
</html>
