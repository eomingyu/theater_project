<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매내역 조회</title>
</head>
<body>
<h3>예매 내역</h3>
<br>
<form action="ticket.do" method="post">
	<input type="hidden" name="id" value="aaaa3">
	<button>조회</button>
</form>
<table>
	<tr>
		<th width="5%">No</th>
		<th width="15%">예매번호</th>
		<th width="15%">공연</th>
		<th width="15%">극장</th>
		<th width="15%">공연일자</th>
		<th width="8%">공연시간</th>
		<th width="15%">좌석</th>
		<th width="5%">인원</th>
		<th width="7%">예매취소</th>
	</tr>
	<c:forEach var="vo" items="${list}" varStatus="status">
	<tr class="list">
		<td>${status.count}</td> 	
 		<td>${vo.ticket_no}</td>
 		<td>${vo.perform}</td>
 		<td>${vo.theater}</td>
 		<td>
 		<fmt:formatDate value="${vo.perform_date }" pattern="yyyy-MM-dd"/>  <!-- 출력패턴 -->
 		</td>
 		<td>${vo.start_time}</td>
 		<td>${vo.seat}</td>
 		<td>${vo.num}명</td>
 		<td>
 		<!-- 현재 날짜 -->
 		<jsp:useBean id="now" class="java.util.Date"/>
 		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
 		<c:if test="${vo.perform_date>today}">
 			<form action="cancel.do" method="post">
 			<input type="hidden" name="ticket_no" value="${vo.ticket_no}">
 			<button>취소</button>
 			</form>
 		</c:if>
 		</td>
 	</tr>
	 	</c:forEach>
	<c:if test="${fn:length(list)==0 }">
		<tr>
			<td colspan="7" style="text-align:center;"><br>조회 결과가 없습니다.</td>
		</tr>
	</c:if>
</table>
</body>
</html>