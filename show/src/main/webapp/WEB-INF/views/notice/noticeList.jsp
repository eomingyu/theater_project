<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>   
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<script type="text/javascript">
	setTimeout(function(){			//setTimeout 설정(100ms)
		if(${message != null}) alert('${message}');
	},210);
</script>
<script src="https://kit.fontawesome.com/7ebf19920b.js" crossorigin="anonymous"></script>
</head>
<body>
<!-- 메뉴바 include -->
<%@ include file="../includes/banner.jsp" %>
		<!-- 컨테이너시작 -->
	<section id="main" class="wrapper">
		<header>
			<h2>FREDDO</h2>
				<p class="location">
				NOTICE <span class="path">/</span> 공지사항
				</p>
		</header>
		<div class="inner">
	<h3>공지사항 목록</h3>
	<hr>
	<div style="margin:auto;">
		<div style="text-align:right;">
			<form action="noticesearch.do" method="post">
			<div class="row gtr-uniform">
			<div class="col-4">
				<select name="columns" id="columns">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="titleContent">제목+내용</option>
				</select>
			</div>
				<!-- 아래 find는 2개 중에 하나만 화면에 표시  -->
				<span id="content">
					<input name="find" placeholder="검색할 내용 입력" value="${find}">
				</span>
				<div>
				<button>검색</button>
				<button type="button" onclick="location.href='noticelist.do'">전체보기</button>
				</div>
				</div>
			</form>
		</div>
		<table>
			<tr>
			<th width="12%">No</th>
			<th width="55%">제목</th>
			<th width="20%">등록일</th>
			<th width="13%">조회수</th>
			</tr>
			<c:forEach var="vo" items="${list}" varStatus="status">
			<tr class="list">
				<td>${status.count+(page.pageNo-1)*10}</td> 	
		 		<td><a href="noticedetail.do?idx=${vo.notice_idx}&pageNo=${page.pageNo}&columns=${columns}&find=${find}" class="title">${vo.notice_title}</a></td>
		 		<td>
		 		<fmt:formatDate value="${vo.notice_date}" pattern="yyyy-MM-dd"/>  <!-- 출력패턴 -->
		 		</td>
		 		<td>${vo.notice_view}</td>
		 	</tr>
	 	 	</c:forEach>
	 	 	<!-- list의 데이터가 없을 때 list애트리뷰트가 null X,size()가 0(jstl의 함수) -->
		<c:if test="${fn:length(list)==0 }">
					<tr>
						<td colspan="4" style="text-align:center;"><br>조회 결과가 없습니다.</td>
					</tr>
		</c:if>
		</table>
	</div>
	<div style="text-align: center;">		<!-- a태그에서 onclick 사용할 땐 자바스크립트라고 표시 -->
		<a class="pagenum" onclick="javascript:goPage(1)">&lt;&lt;</a>   <!-- 요청url은 동일하고 파라미터만 변경됩니다. -->
		<a class="${page.startPage>1? 'pagenum':'none'}" 
			 onclick="javascript:goPage('${page.startPage-1 }')">&lt;</a>  
		
		<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">  <!-- 페이지목록의 범위  -->
			<c:choose>
				<c:when test="${i==page.pageNo}">	<!-- 현재 페이지인 경우 링크 제거 -->
					<span class="pagenum">${i}</span>
				</c:when>
				<c:otherwise>
					<a class="pagenum" onclick="javascript:goPage('${i}')">${i}</a>     <!-- 현재페이지 i값으로 변경  -->
				</c:otherwise>			
			</c:choose>
		</c:forEach>
		
		<a class="${page.endPage!=page.totalPage? 'pagenum':'none'}" 
			onclick="javascript:goPage('${page.endPage+1 }')">&gt;</a> 
		<a class="pagenum" onclick="javascript:goPage('${page.totalPage }')">&gt;&gt;</a>
	</div>
	<form action="" method="post">
		<input name="columns" type="hidden">
		<input name="find" type="hidden">		
		<input name="pageNo" type="hidden">
	</form>
	</div>
</section>
<%@ include file="../includes/footer.jsp" %>
<script type="text/javascript">
	var href=window.location.pathname;				//memberList.do 또는 search.do 가져오기
	function goPage(no){
		const frm = document.forms[1];
		frm.action=href;
		frm.pageNo.value=no;
		frm.columns.value='${columns}';
		frm.find.value='${find}';
		frm.submit();
	}
   		//조회 후에 select 남아있게 하기
		const sel = document.querySelectorAll("#columns>option");	/* > 자식요소  */
		sel.forEach(function(item){
			if(item.value=='${columns}'){
				item.selected='selected';
				//column 애트리뷰트 값과 일치하는 option 항목일 때입니다.
			}
		});
/* 		document.querySelectorAll("#authorities>option").forEach(function(item){
			if(item.value=='${find}'){
				item.selected='selected';
			}
		}); */
		
   </script>

</body>
</html>