<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE HTML>
<!--
	Prototype by Pixelarity
	pixelarity.com | hello@pixelarity.com
	License: pixelarity.com/license
-->
<html>
	<head>
		<title>Elements - Prototype by Pixelarity</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/main.css" />
	</head>
	<body class="is-preload">
<script type="text/javascript">
	if(${message != null}) alert('${message}');
</script>
		<!-- Header -->
			<header id="header">
				<h1><a href="${pageContext.request.contextPath }/">FREDDO</a></h1>
				<a href="#menu">Menu</a>
			</header>

		<!-- Menu -->
			<nav id="menu">
				<ul class="links">
				<c:if test="${member == null && admin == null || member != null}">
					<li><a href="${pageContext.request.contextPath }/">Home</a></li>
					<li><a href="">Performance</a></li>
					<li>
						<a href="">Community</a>
						<ul class="open">
							<li><a href="${pageContext.request.contextPath }/admin/noticelist.do">Notice</a></li>
							<li><a href="${pageContext.request.contextPath }/community/list.do">관람 후기</a></li>
						</ul>
					</li>
					</c:if>
				<c:if test="${member != null}">
					<li><a href="">Service center</a>
						<ul class="open">
							<li><a href="${pageContext.request.contextPath }/member/Board1to1.do">1:1 문의하기</a></li>
						</ul>
					</li>
					</c:if>
				<c:if test="${admin != null}">
				<li><a href="${pageContext.request.contextPath }/main.do">ADMIN PAGE</a></li>
					<li><a href="${pageContext.request.contextPath }/admin/memberlist.do">Member List</a></li>
					<li>
						<a href="">Performance</a>
						<ul class="open">
							<li><a href="${pageContext.request.contextPath }/admin/performinsert.do">공연 등록</a></li>
							<li><a href="${pageContext.request.contextPath }/admin/scheduleinsert.do">공연 스케줄 등록</a></li>
						</ul>
					</li>
					<li>
						<a href="">Community</a>
						<ul class="open">
							<li><a href="${pageContext.request.contextPath }/admin/noticelist.do">Notice List</a></li>
							<li><a href="${pageContext.request.contextPath }/admin/noticeinsert.do">Notice Insert</a></li>
							<li><a href="">관람 후기</a></li>
						</ul>
					</li>
					<li><a href="">Service center</a>
						<ul class="open">
							<li><a href="${pageContext.request.contextPath }/member/qinsert.do">1:1 문의하기</a></li>
							<li><a href="${pageContext.request.contextPath }/admin/questionlist.do">1:1 문의 답변 등록</a></li>
						</ul>
					</li>
				</c:if>
				</ul>
				<ul class="actions stacked">
					<c:if test="${member == null && admin == null}">
						<li><a href="${pageContext.request.contextPath }/login.do" class="button fit">Log In</a></li>
						<li><a href="${pageContext.request.contextPath }/member/join.do" class="button primary fit">Sign Up</a></li>
					</c:if>
					<c:if test="${admin != null }">
						<li>${admin.id }님 안녕하세요. <a href="${pageContext.request.contextPath }/logout.do" class="button fit">Log Out</a></li>
						<li><a href="${pageContext.request.contextPath }/admin/main.do" class="button primary fit">Admin Page</a></li>
					</c:if>
					<c:if test="${member != null}">
						<li>${member.id }님 환영합니다.<a href="${pageContext.request.contextPath }/logout.do" class="button fit">Log Out</a></li>
						<li><a href="${pageContext.request.contextPath }/member/mypage.do" class="button primary fit">MyPage</a></li>
					</c:if>
				</ul>
			</nav>

		<!-- Main -->
			
			
		<!-- Scripts -->
			<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/jquery.min.js"></script>
			<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/jquery.scrollex.min.js"></script>
			<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/browser.min.js"></script>
			<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/breakpoints.min.js"></script>
			<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/util.js"></script>
			<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/main.js"></script>
			
</body>
</html>