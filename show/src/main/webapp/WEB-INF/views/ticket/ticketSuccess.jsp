<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 완료</title>
<style type="text/css">
.clearp{
	display:flex;
	justify-content:center;
	font-size: 18px;
}
.perform_info{
	margin:20px;
	align-items:center;
	width:450px;
}
.perform_info>table{
	width:90%;
}
.poster{
	margin:20px;
}

</style>
</head>
<body>
<div class="clearp">
	<h2>예매가 완료되었습니다. 이용해 주셔서 감사합니다.</h2>
</div>
<div class="clearp">
	<h3>예매 내역</h3>
</div>
<div class="clearp">
	<div class="poster">
		<img src="/upload/${performinfo.poster}" width="175px" height="250px" style="object-fit:contain">
	</div>
	<div class="perform_info">
		<h4>${performinfo.perform_title}</h4>
		<hr>
		<table style="text-align:left;">
			<tr>
				<th>예매 번호</th>
				<td>${ticketno}</td>
			</tr>
			<tr>
				<th style="width:30%;">극장</th>
				<td>${performinfo.theater_name}</td>
			</tr>
			<tr>
				<th>공연일</th>
				<td><fmt:formatDate value="${scheduleinfo.perform_date}" pattern="yyyy년 MM월 dd일"/></td>
			</tr>
			<tr>
				<th>공연 시간</th>
				<td>${scheduleinfo.start_time}</td>
			</tr>
			<tr>
				<th>인원</th>
				<td>${number} 명</td>
			</tr>
			<tr>
				<th>좌석</th>
				<td>${choicedseat}</td>
			</tr>

		</table>
	</div>
</div>
<div class="clearp">
	<button onclick="location.href='${pageContext.request.contextPath}'">홈으로</button>
</div>
</body>
</html>