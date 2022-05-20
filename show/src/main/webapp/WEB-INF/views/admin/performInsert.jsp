<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공연 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
.inputs{
	border-top:0;
	border-right:0;
	border-left:0;
	border-bottom: 1px solid #ccc;
	width:250px;
}
.inputs:focus{
	border-top:0;
	border-right:0;
	border-left:0;
	border-bottom: 2px solid #3498db;
	outline: 0;
}
#notable{
	border-bottom: 1px solid #fff;
}
#notable>tr{
	border-bottom: 1px solid #fff;
}
</style>
<script type="text/javascript">
//공연 시작일자 최소값: 오늘
/* 	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	if(dd<10){
	  dd='0'+dd
	} 
	if(mm<10){
	  mm='0'+mm
	} 

	today = yyyy+'-'+mm+'-'+dd;
	form.start_date.setAttribute("min", today); */
	function validCheck(){
	var form=document.forms[0];
	var title = form.perform_title;
	var theater_idx = form.theater_idx;
	var showtime = form.showtime;
	var grade = form.grade;
	var start_date = form.start_date;
	var end_date = form.end_date;
	var pics = form.pics;
	var detail = form.detail;
		if(title.value==""){
			alert('공연 제목을 입력해주세요')
			title.focus();
		}
		else if(theater_idx.value=="none"){
			alert('극장을 선택해주세요')
			theater_idx.focus();
		}
		else if(showtime.value==""){
			alert('관람 시간을 입력해주세요')
			showtime.focus();
		}
		else if(grade.value=='none'){
			alert('관람 등급을 선택해주세요.');
			grade.focus();
		}
		else if(start_date.value==""){
			alert('공연 시작 일자를 선택해주세요')
			start_date.focus();
		}
		else if(end_date.value==""){
			alert('공연 종료 일자를 선택해주세요')
			end_date.focus();
		}
		else if(pics.value==""){
			alert('공연 포스터를 첨부해주세요')
			pics.focus();
		}
		else if(detail.value==""){
			alert('상세 내용을 입력해주세요')
			detail.focus();
		}
		else if(form.end_date.value<form.start_date.value){
			alert('공연 시작/종료 일자를 확인하세요.');
			form.start_date.focus();
		}
		else
			form.submit();
	}
</script>
<script src="https://kit.fontawesome.com/7ebf19920b.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	setTimeout(function(){			//setTimeout 설정(210ms)
		if(${message != null}) alert('${message}');
	},210);
</script>
</head>
<body>
<!-- 메뉴바 include -->
<%@include file="menubar.jsp" %>
<section>
	<h3>공연 등록</h3>
	<hr>
	<div style="margin:auto;">
		<form action="performinsert.do" method="post" enctype="multipart/form-data">
			<table id="notable">
				<tr>
					<th width="20%">공연 제목</th>
					<td width="80%">
						<input type="text" name="perform_title" class="inputs">
					</td>
				</tr>
				<tr>
					<th width="20%">극장 선택</th>
					<td width="80%">
						<select name="theater_idx" id="theater_idx">
							<option value="none" selected disabled>----선택----</option>
							<c:forEach var="vo" items="${list}">
								<option value="${vo.theater_idx}">${vo.theater_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th width="20%">관람 시간</th>
					<td width="80%">
						<input type="text" name="showtime" class="inputs">
					</td>
				</tr>
				<tr>
					<th width="20%">관람 등급</th>
					<td width="80%">
						<select name="grade" id="grade">
							<option value="none" selected disabled>----선택----</option>
							<option value="전체">전체 관람가</option>
							<option value="12세 이상">12세 이상 관람가</option>
							<option value="15세 이상">15세 이상 관람가</option>
							<option value="18세 이상">18세 이상 관람가</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="20%">공연 시작 일자</th>
					<td width="80%">
						<input type="date" name="start_date">
					</td>
				</tr>
				<tr>
					<th width="20%">공연 종료 일자</th>
					<td width="80%">
						<input type="date" name="end_date">
					</td>
				</tr>
				<tr>
					<th width="20%">공연 포스터</th>
					<td width="80%">
						<input type="file" name="pics" accept="image/*">
					</td>
				</tr>
				
				<tr>
					<th width="20%">상세 내용</th>
					<td width="80%">
						<div>
							<textarea  rows="20" cols="80" name="detail" id="detail"
			                style="width:100%;resize: none;" placeholder="내용을 입력하세요."></textarea>
						</div>
					</td>
				</tr>
			</table>
			<div style="text-align:center;">
				<button type="button" class="adbutton" onclick="validCheck()">등록</button>
				<button type="button" class="adbutton" onclick="location.href='main.do'">취소</button>
			</div>
		</form>
	</div>
</section>
</body>
</html>