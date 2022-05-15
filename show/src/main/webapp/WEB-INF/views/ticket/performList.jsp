<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공연 목록</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
ul{
	list-style:none;
	padding-left:1px;]
}
.poster{
	margin:20px;
}

.clearp{
	display:flex;
	justify-content:center;
}
.perform_info{
	margin:20px;
	align-items:center;
	width:380px;
}
.perform_button{
	align-items:center;
	margin-top:117px;
	margin-left:10px;
}
.perform_button > button{
	margin:5px;
}
</style>
</head>
<body>
<div style="margin:auto;">
	<div class="clear2">
		<c:forEach var="vo" items="${list}">
		<div class="clearp">
				<div class="poster">
				<img src="/upload/${vo.poster}" width="175px" height="250px" style="object-fit:contain">
				</div>
				<div class="perform_info">
					<h3>${vo.perform_title}</h3>
					<hr>
					<ul>
						<li><span>공연 일정 : </span>
							<fmt:formatDate value="${vo.start_date}" pattern="yyyy년 MM월 dd일"/> ~ 
							<fmt:formatDate value="${vo.end_date}" pattern="yyyy년 MM월 dd일"/>
						</li>
						<li><span>공연 장소 : </span>${vo.theater_name}</li>
						<li><span>입 장 료  : </span>${vo.theater_fee}</li>
						<li><span>관람 등급 : </span>${vo.grade} 관람가</li>
						<li><span></span></li>
						<li><span></span></li>
					</ul>
				</div>
				<div class="perform_button">
					<button type="button" onclick="location.href='#'">상세정보</button><br>
					<button type="button" onclick="location.href='choice.do?idx=${vo.perform_idx}&tidx=${vo.theater_idx}'">예매하기</button>
				</div>
		</div>
		</c:forEach>
	</div>
</div>
</body>
</html>