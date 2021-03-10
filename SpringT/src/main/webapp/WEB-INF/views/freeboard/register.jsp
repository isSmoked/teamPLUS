<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- TinyMCE -->
<script src="https://cdn.tiny.cloud/1/mvtgkc47o2k8wy7wo80m0ts2g1zdax79ywcue2h5b9o9ectc/tinymce/5/tinymce.min.js"></script>
<title>자유게시판</title>
</head>
<body>
  <h6><a href="list" style="color: black; 
	          text-decoration: none;"><strong>자유게시판</strong></a> > 글 작성</h6>
  <hr>
  <form action="register" id="form" method="POST">
	<div>
    <input type="hidden" name="userid" value="${loginId }">
      <p>작성자 : ${loginId }</p>
      <p>제목 : 
      	<input style="width:70%;" type="text" id="title" name="freeboard_title" placeholder="제목 입력" required="required">
      	<!-- 공지글 설정 (관리자 전용) -->
      	<c:if test="${part eq 'manager' }"> | 
       	  <select name="freeboard_notice">
		  	<option value="0">공지_0</option>
		  	<option value="1">공지_1</option>
		  	<option value="2">공지_2</option>
		  	<option value="3">공지_3</option>
		  </select>
		</c:if>
      </p>
    </div>
    <hr>
	<!-- TinyMCE -->
    <div>
		<textarea id="editor" name="freeboard_content" required></textarea>
    </div>
    <!-- 하단버튼 -->
    <div>
      <input type="submit" class="btn btn-light" style="background: lightgrey;" onclick="check()" value="등록">
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
  // 등록버튼
  function check() {
	  var content = $('#editor').val();
		  console.log("check : " + content);
	  if (content === "") {
		  alert("글을 작성해 주세요.");
		  return false;
	  }
  } // check()
  
	//취소버튼
	function goBack() {
		if (confirm("취소 하시겟습니까?")){
			window.history.back();
		}
	} // goBack
	
	/* 결과 알림 */
	resultAlert();
  	function resultAlert() {
	    var result = $('#resultAlert').val();
	    if (result === 'insertFail') {
	      alert('새 글 작성 실패.');
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
      
      // image upload test =======================================
      image_title: true, // 이미지창에 이미지제목 추가
      automatic_uploads: true, // 자동업로드 활성화
      //images_upload_url: '/Web_Project/src/main/webapp/WEB-INF/images', // 이미지 업로드 핸들러 추가 (이미지전용) ??? 뭐 어떻게 하라고?
      file_picker_types: 'file image media',
      /* and here's our custom image picker*/
      file_picker_callback: function (cb, value, meta) {
        var input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');

        /*
          Note: In modern browsers input[type="file"] is functional without
          even adding it to the DOM, but that might not be the case in some older
          or quirky browsers like IE, so you might want to add it to the DOM
          just in case, and visually hide it. And do not forget do remove it
          once you do not need it anymore.
        */

        input.onchange = function () {
          var file = this.files[0];

          var reader = new FileReader();
          reader.onload = function () {
            /*
              Note: Now we need to register the blob in TinyMCEs image blob
              registry. In the next release this part hopefully won't be
              necessary, as we are looking to handle it internally.
            */
            var id = 'blobid' + (new Date()).getTime();
            var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
            var base64 = reader.result.split(',')[1];
            var blobInfo = blobCache.create(id, file, base64);
            blobCache.add(blobInfo);

            /* call the callback and populate the Title field with the file name */
            cb(blobInfo.blobUri(), { title: file.name });
          };
          reader.readAsDataURL(file);
        };

        input.click();
      },
      // test =====================================
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

