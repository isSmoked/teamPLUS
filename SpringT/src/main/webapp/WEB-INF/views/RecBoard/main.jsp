<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
body
	{padding-top: 100px;}
</style>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>메인 화면</title>

</head>

<body>
	<div class=jumbotron">
		<div class="container">
		
			<h1 class="display-3"><span style="font-size:60%">team</span> PLUS</h1>
			<p>
			This homepage connects businesses between individual developers and companies, organizes meetings between developers, and organizes meetings between developers. You can freely discuss and study here.
			</p>
			
		</div>
	</div>
	
	
    
    <div class="container">
	    <div class="row">
	    	<div class="col-md-4">
	    		<h2>Recruits</h2>
	    		<p>
	    		Find a job and unleash your skills</p>
	    		<br><br>
	    		<p>
	    		<a class="btn btn-light" style="background: silver;" href="/prj/RecBoard/recruits" role="button">
	    		Go Recruits</a>
	    		</p>
	    	</div>
	    	<div class="col-md-4">
	    		<h2>Study</h2>
	    		<p>
	    		Study with others and develop together</p>
	    		<br><br>
	    		<p>
	    		<a class="btn btn-light" style="background: silver;" href="/prj/studyBoard/list" role="button">
	    		Go Study</a>
	    		</p>
	    	</div>
	    	<div class="col-md-4">
	    		<h2>Q&A</h2>
	    		<p>
	    		Ask questions you don't know and let us know</p>
	    		<br><br>
	    		<p>
	    		<a class="btn btn-light" style="background: silver;" href="/prj/qaboard/list" role="button">
	    		Go Q&A</a>
	    		</p>
	    	</div>
	    	<div class="col-md-4">
	    	<br><br>
	    		<h2>employ</h2>
	    		<p>
	    		Introduce yourself to companies and get a job</p>
	    		<br><br>
	    		<p>
	    		<a class="btn btn-light" style="background: silver;" href="/prj/EmpBoard/employees" role="button">
	    		Go Employ</a>
	    		</p>
	    	</div>
	    	<div class="col-md-4">
	    	<br><br>
	    		<h2>Free</h2>
	    		<p>
	    		Talk freely with others</p>
	    		<br><br><br>
	    		<p>
	    		<a class="btn btn-light" style="background: silver;" href="/../prj/freeboard/list" role="button">
	    		Go Free</a>
	    		</p>
	    	</div>
	    	<div class="col-md-4">
	    	<br><br>
	    		<h2>Share</h2>
	    		<p>
	    		Share your own information with others and get new information</p>
	    		<br>
	    		<p>
	    		<a class="btn btn-light" style="background: silver;" href="/../prj/shareboard/list" role="button">
	    		Go Share</a>
	    		</p>
	    	</div>
	    </div>
    </div>
    
  </body>
</html>
