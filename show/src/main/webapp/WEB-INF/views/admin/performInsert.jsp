<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<table class="notice" id="title">
				<tr>
					<th class="notice" width="20%">공연 제목</th>
					<td width="80%">
						<input type="text" name="perform_title">
					</td>
				</tr>
				<tr>
					<th class="notice" width="20%">관람 시간</th>
					<td width="80%">
						<input type="text" name="showtime">
					</td>
				</tr>
				<tr>
					<th class="notice" width="20%">관람 등급</th>
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
					<th class="notice" width="20%">공연 시작 일자</th>
					<td width="80%">
						<input type="date" name="start_date">
					</td>
				</tr>
				<tr>
					<th class="notice" width="20%">공연 종료 일자</th>
					<td width="80%">
						<input type="date" name="end_date">
					</td>
				</tr>
				<tr>
					<th class="notice" width="20%">공연 포스터</th>
					<td width="80%">
						<input type="file" name="pics" accept="image/*">
					</td>
				</tr>
				
				<tr>
					<th class="notice" width="20%">상세 내용</th>
					<td width="80%">
						<div>
							<textarea  rows="20" cols="80" name="detail" id="detail"
			                style="width:100%;resize: none;" placeholder="내용을 입력하세요."></textarea>
						</div>
					</td>
				</tr>
			</table>
			<div style="text-align:center;">
				<button type="button" onclick="validCheck()">등록</button>
				<button type="button" onclick="location.href='main.do'">취소</button>
			</div>
		</form>
	</div>
</section>
</body>
</html>