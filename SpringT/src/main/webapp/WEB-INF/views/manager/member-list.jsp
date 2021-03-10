<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table, th, td {
  border-style : solid;
  border-width : 1px;
  text-align : center;
}

ul {
  list-style-type: none;
}

li {
  display: inline-block;
}

/* 레이어팝업 (상세정보) */
#popup.active { display: block; } 
#popup { display: none; position: fixed; top: 0; left: 0; bottom: 0; right: 0; width: 100%; height: 100%; z-index: 100; }  /* background-color: rgba(0,0,0,0.5); */  
#popup .popup-wrap { position: absolute; border: 5px solid lightblue;}  /* 위치조절  top: 50%; margin-top: -25%; left: 50%; margin-left: -25%; width: 570px; height: 500px; */
#popup .popup-wrap .popup-content { background-color: #fff; color: #0f0f0f; padding: 20px 60px 20px; } /* border-radius: 3px; */ 
#popup .popup-wrap.text-popup { background-color: #fff; padding-bottom: 40px; } 
#popup .popup-wrap .popup-content .title { text-align: center; font-size: 24px; line-height: 24px; } 
#popup .popup-wrap.text-popup .popup-content .info-text { margin-top: 20px; text-align: center; font-size: 16px; line-height: 27px; width: 450px; height: 400px; } /* 스크롤 확인 overflow-y: scroll; */
#popup .popup-wrap .btn-close { position: absolute; top: -35px; right: 0; cursor: pointer; }
/* 레이어팝업 (상세정보) : 끝 */
</style>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/toggle.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="UTF-8">
<title>관리자페이지 : 회원관리</title>
</head>
<body>
<h2>회원관리</h2>
<hr>
  

  <!-- 레이어팝업 -->
  <div id="popup">
	  <div class="popup-wrap text-popup">
	    <div class="popup-content">
		    <div class="title"></div>
		    <div class="info-text">
				<div id="ajaxData"></div>
		    </div>
	    <button type="button" class="btn-close">창닫기</button>
	    </div>
	  </div>
  </div>
  
  <!-- 회원검색 -->
  <form name="searchMember" method="get">
  	<div id="searchOptions">
  		<p>
	  		<label><input type="checkbox" name="searchPart" value="personal">&nbsp;개인회원&nbsp;&nbsp;</label>
	  		<label><input type="checkbox" name="searchPart" value="company">&nbsp;기업회원&nbsp;&nbsp;</label>
	  		<label><input type="checkbox" name="searchPart" value="manager">&nbsp;관리자</label>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
	  		<label><input type="checkbox" name="searchBlacklist" value="1" onclick="checkOne(this)">&nbsp;불량회원&nbsp;&nbsp;</label>
	  		<label><input type="checkbox" name="searchBlacklist" value="0" onclick="checkOne(this)">&nbsp;불량회원 제외&nbsp;&nbsp;</label>
  		</p> 
  	</div>
  	<select name="searchColumn">
		<option value="all">전체</option>
		<option value="userid">아이디</option>
		<option value="email">이메일</option>
		<option value="phone">연락처</option>
	</select>
	<input style="width:50%;" type="text" name="keyword" placeholder="검색">
	<input type="button" onclick="search()" value="검색">
  </form>
  <hr>
  
  <!-- ********************** Board Table ********************** -->
  <div style="width:90%;">
  	<div id="totalCount" style="float: left;"></div>
  	<div style="float: right;">
	  	PAGE : 
	  	<select name="perPage">
	  		<option value="10">10</option>
	  		<option value="20">20</option>
	  		<option value="30">30</option>
	  		<option value="40">40</option>
	  		<option value="50">50</option>
	  	</select>
	  	&nbsp;|&nbsp;
	  	<button id="register">관리자등록</button>
  	</div>
  </div>
  
  <div style="clear: both;">
	  <table  id="memberTable" style="width:90%;">
	    <thead style="background-color:lightblue;">
	      <tr>
	        <th>구분</th>
	        <th>ID</th>
	        <th>이메일</th>
	        <th>연락처</th>
	        <th>상세정보</th>
	        <th>불량회원</th>
	        <th>가입일</th>
	        <th>삭제</th>
	      </tr>
	    </thead>
	    
	    <tbody id="tableBody"></tbody>
	  </table>
	    
	  <hr>
	  
	  <!-- ********************** Board Paging ********************** -->
	  <div id="paging" style="width:90%; font-size: xx-large;"></div>
  </div>
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
  		bodyList();
  		paging();
  		
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
  	  
  	  	/* 상세정보 클릭 */
		$(document).on("click", ".detail", function(){
  			var pop = $(this).attr("href");
  			console.log(pop);
  			var a = $(this);
  			var tableBody = a.parents(["#tableBody"]);
  			var td = tableBody.children('td');
  			var rowPart = td.eq(0).text();
  			var rowId = td.eq(1).text();
  			console.log("rowPart : " + rowPart);
  			console.log("rowId : " + rowId);
  			var rowData = {
  					userid : rowId,
  					table_name : rowPart
  			};
  			
  			ajaxPopup(rowData);
        
        	// 팝업 화면 중앙에 위치 시키기
    		var popupWidth = 570;
    		var popupHeight = 500;
    		var popupX = (window.screen.width/2) - (popupWidth/2);
    		var popupY = (window.screen.height/2) - (popupHeight/2);
    	    $('.popup-wrap').css({height: popupHeight, width: popupWidth, left: popupX, top: popupY});
        
        
        	$('.info-text').css("overflow","auto"); // body 스크롤바 생성
  			$(pop).fadeIn();
  			$(pop).addClass("active");
  			
  		});
  		
  		$(".btn-close").on("click",function(){ 
  			$('#popup').fadeOut('fast');
  			$("#popup").removeClass("active"); 
		}); 
  		
  		// 팝업 : 외부영역 클릭시 창 닫힘
  		$(document).mouseup(function(e){
  			var container = $('#popup');
  		    if( container.has(e.target).length === 0){
	  			$('#popup').fadeOut('fast');
	  			$("#popup").removeClass("active"); 
	  		    }
	  		});
  		
  		/* 회원 삭제 버튼 */
  		$(document).on("click", ".delete", function(){
  			console.log("삭제버튼 클릭"	);
  			var a = $(this);
  			var tableBody = a.parents(["#tableBody"]);
  			var td = tableBody.children('td');
  			var rowPart = td.eq(0).text();
  			var rowId = td.eq(1).text();
  			console.log(rowId);
  			if (confirm("회원정보가 전부 삭제됩니다.\n삭제된 데이터는 복구할 수 없습니다.\n삭제하시겠습니까?")){
  				console.log("회원삭제 시작");
  				$.ajax({
  					type : 'delete',
  					url : 'managerRest/' + rowId,
  					success : function(data){
  						console.log("delete result data : " + data);
  						if (data === 1){
  							toastr["info"]("회원 데이터가 전부 삭제되었습니다.");
  							bodyList();
  						} else {
  							toastr["error"]("회원 삭제 실패");
  						}
  					}, error : function(error){
  						alert("error : " + error);
  					}
  				}); // ajax
  			} // if 
  		}); // 회원 삭제 버튼
  		
  		
  		/* perPage */
  		$(document).on("change", "select[name=perPage]", function(){
  	  		console.log($(this).val()); //value값 가져오기
  	  		console.log($("select[name=perPage] option:selected").text()); //text값 가져오기
  	  		bodyList();
  	  		paging();
  		}); // perPage
  	  
  	}); // end document
  	
			
	/* 불량회원 추가/삭제 */
	// 토글버튼
	function toggle(e) {
		var thisInput = $(e);
		var tableBody = thisInput.parents(["#tableBody"]);
		var td = tableBody.children('td');
		var rowId = td.eq(1).text();
	    console.log("선택된 아이디 : " + rowId);
	    
		if(e.checked) {
			// 블량회원 추가

		    var blacklist = {
			    	userid : rowId,
			    	blacklist : '1'
			     };

		    	$.ajax({
						type : "put",
						url : "managerRest/blacklist",
						data : JSON.stringify(blacklist),
						headers : {
		                    'Content-Type' : 'application/json',
		                    'X-HTTP-Method-Override' : 'PUT'
		                  },
						error : function(error, result, status){
							console.log("error : " + error + ", result : " + result + ", status : " + status);
							alert("updateBlacklist error");
						},
						success : function(result, status){
							console.log("success : " + result + ", status : " + status);
							if (result === 1){
								toastr["error"]("불량 회원 등록.");
							} else {
								alert("실패.");
							}
						} // end success
					}); 
				      
			} else {
				// 불량회원 해제
				console.log("선택된 아이디 : " + rowId);

			    var blacklist = {
				    	userid : rowId,
				    	blacklist : '0'
				     };

			    	$.ajax({
							type : "put",
							url : "managerRest/blacklist",
							data : JSON.stringify(blacklist),
							headers : {
			                    'Content-Type' : 'application/json',
			                    'X-HTTP-Method-Override' : 'PUT'
			                  },
							error : function(error, result, status){
								console.log("error : " + error + ", result : " + result + ", status : " + status);
								alert("updateBlacklist error");
							},
							success : function(result, status){
								console.log("success : " + result + ", status : " + status);
								if (result === 1){
									toastr["info"]("불량 회원 해제.");
								} else {
									alert("실패.");
								}
							} // end success
						}); 
			}
		} // toggle()
  	
  		
  		 /* 상세정보 팝업 데이터 가져오기 */
  		 function ajaxPopup(rowData){
  			 console.log("ajaxPopup id : " + rowData.userid);
  			 console.log("ajaxPopup part : " + rowData.table_name);
  			 $.ajax ({
  				 type : "post",
  				 url : "managerRest/detail",
  				 data : JSON.stringify(rowData),
  				 headers : {
                    'Content-Type' : 'application/json',
                    'X-HTTP-Method-Override' : 'post'
                 },
  				 success : function(data){
  					 console.log(data);
  					 console.log(data.userid);
  					 
  					 var list = '';
  					 if(rowData.table_name === "personal"){
  						 console.log("Part : Personal");
  						 
  						 if (data.personal_address != null){
							 var jsonAdd = JSON.parse(data.personal_address);
							 var roadAdd = jsonAdd.roadAddress;
							 var detailAdd = jsonAdd.detailAddress;
							 var postcode = jsonAdd.postcode;
  						 }
  						 
						 if (data.personal_json != null){
							 var jsonData = JSON.parse(data.personal_json);
							 var education = jsonData.education;
							 var career = jsonData.career;
							 var certificate = jsonData.certificate;
							 var intern = jsonData.intern;
							 var activity = jsonData.activity;
							 var award = jsonData.award;
							 var abroad = jsonData.abroad;
							 var language = jsonData.language;
							 var portfolio = jsonData.portfolio;
							 var militaryService = jsonData.militaryService;
						 	 var introduction = jsonData.introduction;
						 }
							
  					 	 var updateDate = moment(new Date(data.personal_update_date)).format('YYYY-MM-DD HH:mm:ss');
  						 list += '<div>'
	  						 + '<hr>'
	  						 + '이름 : ' + data.personal_name + '<br>'
	  						 + '생년월일 : ' + data.personal_birth + '<br>'
	  						 + '성별 : ' + data.personal_gender + '<br>'
	  						 + '주소 : (' + postcode + ') ' + roadAdd + ',&nbsp;' + detailAdd + '<br>'
	  						 + '<hr>'
	  						 + '학력 : ' + education + '<br>'
	  						 + '경력 : ' + career + '<br>'
	  						 + '자격증 : ' + certificate + '<br>'
	  						 + '인턴, 대외활동 : ' + intern + '<br>'
	  						 + '교육이수 : ' + activity + '<br>'
	  						 + '수상 : ' + award + '<br>'
	  						 + '해외경험 : ' + abroad + '<br>'
	  						 + '어학 : ' + language + '<br>'
	  						 + '포트폴리오 : ' + portfolio + '<br>'
	  						 + '병역 : ' + militaryService + '<br>'
	  						 + '자기소개서 : ' + introduction + '<br>'
	  						 + '<hr>'
	  						 + '업데이트데이트 : ' + updateDate + '<br>'
	  						 + '<hr>'
	  						 + '</div>'
	  						 
  					 } else {
  						 console.log("Part : Company");
  						 
  						 if (data.company_addrss != null){
	  						 var jsonAdd = JSON.parse(data.company_address);
							 var roadAdd = jsonAdd.roadAddress;
							 var detailAdd = jsonAdd.detailAddress;
							 var postcode = jsonAdd.postcode;
  						 }
						 
  						 if (data.company_json != null){
						 	var jsonMoreInfo = JSON.parse(data.company_json);
							var financial = jsonMoreInfo.financial;
							var employees = jsonMoreInfo.employees;
							var introduction = jsonMoreInfo.introduction;
  						 }
	
  					 	 var updateDate = moment(new Date(data.company_update_date)).format('YYYY-MM-DD HH:mm:ss');
  						 list += '<div>'
  	  						 + '<hr>'
  	  						 + '회사명 : ' + data.company_name + '<br>'
  	  						 + '사업자번호 : ' + data.company_number + '<br>'
  	  						 + '대표 : ' + data.company_president + '<br>'
  	  						 + '주소 : (' + postcode + ') ' + roadAdd + ',&nbsp;' + detailAdd + '<br>'
  	  						 + '<hr>'
  	  						 + '담당자 : ' + data.company_manager + '<br>'
  	  						 + '담당자 연락처 : ' + data.company_manager_phone + '<br>'
  	  						 + '담당자 이메일 : ' + data.company_manager_email + '<br>'
  	  						 + '<hr>'
  	  						 + '재무정보 : ' + financial + '<br>'
  	  						 + '사원수 : ' + employees + '<br>'
  	  						 + '회사소개 : ' + introduction + '<br>'
  	  						 + '<hr>'
  	  						 + '업데이트데이트 : ' + updateDate + '<br>'
  	  						 + '<hr>'
  	  						 + '</div>'
  					 }
  					 $('#ajaxData').html(list);
  					 $('.title').html(data.userid);
  				 }, error : function(data){
  					 console.log("error : " + data);
  				 }
  			 }); // ajax
  		 } // ajaxPopup()

  		 
 	/* 리스트 불러오기 */
 	function bodyList(target){
 		console.log("ajax bodyList");
 		console.log("ajax bodyList page : " + target);
 		var perPage = $("select[name=perPage] option:selected").val();
 		console.log("ajax bodyList perPage : " + perPage);

 		var listData = $("form[name=searchMember]").serialize();
	 	if (target != null){
		 	listData = listData + "&page=" + target + "&perPage=" + perPage;
	 	} else {
	 		listData = listData + "&perPage=" + perPage;
	 	}
	 	console.log("ajax bodyList listData : " + listData);
	 	
 		$.ajax({
 			url : "managerRest/search-member",
 			type : "get",
 			data : listData,
 			dataType : 'json',
 			headers : {
                'Content-Type' : 'application/json',
                'X-HTTP-Method-Override' : 'post'
             },
 			success : function(data){
 				console.log("bodyList start");
 				console.log(data);
 				$('#tableBody').html("");
 				var list = "";
 				$(data).each(function(){
 					var register_date = moment(new Date(this.register_date)).format('YYYY-MM-DD HH:mm:ss');
 					list += '<tr>' 
 					+ '<td>' + this.part + '</td>'
 					+ '<td>' + this.userid + '</td>'
 					+ '<td>' + this.email + '</td>'
 					+ '<td>' + this.phone + '</td>'
 					if (this.part === "manager"){
	 					list += '<td>'
 						+ 'X'
	 					+ '</td>'
 					} else {
	 					list += '<td>'
	 					+ '<a href="#popup" class="detail">상세정보</a>'
	 					+ '</td>'
 					}
 					list += '<td>'
 					+ '<label class="switch">'
 					+ '<input type="checkbox" class="btn_toggle" onclick="toggle(this)" '
 					if (this.blacklist === 1){
 						list += 'checked/>'
 					} else {
 						list += '/>'
 					}
 					list += '<span class="slider round"></span>'
 					+ '</label>'
 					+ '</td>'
 					+ '<td>' + register_date + '</td>'
 					+ '<td><a href=#delete class="delete">삭제</a>'
 			        + '</tr>'
 				}); // each
 			   $('#tableBody').html(list);
 				
 			}, error : function(error){
 				console.log("bodyList error : " + error);
 			} // error
 			
 		}); // ajax
 		
 	} // bodyList()

 	/* 리스트 페이징 */
 	function paging(target){
 		console.log("ajax paging");
 		var listData = $("form[name=searchMember]").serialize();
 		var perPage = $("select[name=perPage] option:selected").val();
 		console.log("ajax bodyList perPage : " + perPage);
 		
	 	if (target != null){
		 	listData = listData + "&page=" + target + "&perPage=" + perPage;
	 	} else {
	 		listData = listData + "&perPage=" + perPage;
	 	}
	 	console.log("ajax paging listData : " + listData);
	 	
 		$.ajax({
 			url : "managerRest/paging",
 			type : "get",
 			data : listData,
 			success : function(data){
 				console.log("paging start");
 				console.log("paging data : " + data);
 				console.log("paging totalCount : " + data.totalCount);
 				$('#totalCount').html("<p>검색된 회원수 : " + data.totalCount + "</p>");
 				
 				$('#paging').html("");
 				var list ="";
	 				list += '<ul class="pager">'
	 			    if (data.hasPrev){
	 			    	var start = data.startPageNo - 1;
	 			    	list += '<li><a href="'+ start + '">이전</a></li>'
	 			    } 
 			    	for (var i = data.startPageNo; i <= data.endPageNo; i++) {
 			    		list += '&nbsp;<li><a href="' + i + '">' + i + ' </a></li>'
 			    	}
	 			    if (data.hasNext){
	 			    	var end = data.endPageNo + 1;
	 			    	list += '<li><a href="' + end + '">다음</a></li>'
	 			    }
	 			  	list += '</ul>'
 				
 				$('#paging').html(list);
 			}, error : function(error){
 				console.log("paging error : " + error);
 				alert("error : " + error);
 			} // error
 		}); // ajax
 	} // paging()

 	/* 검색 버튼 */
 	function search(){
 		bodyList();
 		paging();
 	}
  	
 	/* 블랙리스트 하나만 선택 */
	function checkOne(a){
        var obj = document.getElementsByName("searchBlacklist");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != a){
                obj[i].checked = false;
            }
        }
    } // checkOne

	/* 관리자등록 새 창 */
	$(document).on("click", "#register", function(){
		console.log("register manager test");
		var popWidth  = '500'; // 파업사이즈 너비
		var popHeight = '450'; // 팝업사이즈 높이
		
		var winWidth  = document.body.clientWidth;  // 현재창의 너비
		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
		var w = winX + (winWidth - popWidth) / 2;
		var h = winY + (winHeight - popHeight) / 2;
	    window.open('register', 'register', 'status=no, height=' + popHeight  + ', width=' + popWidth  + ', left='+ w + ', top='+ h);
	}); // 관리자 등록
	

  </script>

</body>
</html>