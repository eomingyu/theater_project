<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}

</style>
<script src="https://kit.fontawesome.com/7ebf19920b.js" crossorigin="anonymous"></script>
</head>
<body>
<!-- 메뉴바 include -->
<%@include file="menubar.jsp" %>
<section>
	<h3>1:1 문의 목록</h3>
	<hr>
	<div style="margin:auto;">
		<div style="text-align:right;">
			<form action="questionsearch.do" method="post">
				<select name="columns" id="columns">
					<option value="id">아이디</option>
					<option value="question_title">제목</option>
					<option value="status">답변 상태</option>
				</select>
				<!-- 아래 find는 2개 중에 하나만 화면에 표시  -->
				<span id="content">
					<input name="find" placeholder="검색할 내용 입력" value="${find}">
				</span>
				<span id="status">
					<select name="find" id="astatus">
						<option value="진행중">답변 대기</option>
						<option value="답변 완료">답변 완료</option>
					</select>
				</span>
				<button>검색</button>
				<button type="button" onclick="location.href='questionlist.do'">전체보기</button>
			</form>
		</div>
		<table>
			<tr>
				<th width="10%">No</th>
				<th width="50%">제목</th>
				<th width="12%">아이디</th>
				<th width="16%">작성시간</th>
				<th width="12%">답변 상태</th>
			</tr>
			<c:forEach var="vo" items="${list}" varStatus="status">
			<tr class="list">
				<td>${vo.question_idx}</td> 	
		 		<td><a href="questiondetail.do?idx=${vo.question_idx}&pageNo=${page.pageNo}" class="title">${vo.question_title}</a></td>
		 		<td>${vo.id}</td>
		 		<td>
		 			<fmt:formatDate value="${vo.question_date}" pattern="yyyy-MM-dd"/>  <!-- 출력패턴 -->
		 		</td>
		 		<td>
			 		<c:if test="${vo.status=='진행중'}">
			 			<span style="color:red;font-weight:bolder;">답변 대기</span>
			 		</c:if>
			 		<c:if test="${vo.status=='답변 완료'}">
			 			<span style="color:#3d3;font-weight:bolder;">답변 완료</span>
			 		</c:if>
		 		</td>
		 		<td>
		 	</tr>
	 	 	</c:forEach>
	 	 	<!-- list의 데이터가 없을 때 list애트리뷰트가 null X,size()가 0(jstl의 함수) -->
		<c:if test="${fn:length(list)==0 }">
					<tr>
						<td colspan="7" style="text-align:center;"><br>조회 결과가 없습니다.</td>
					</tr>
		</c:if>
		</table>
	</div>
	<c:if test="${fn:length(list)!=0 }">	<!-- 데이터가 없으면 페이지 출력 x -->
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
	</c:if>
	<form action="" method="post">
		<input name="columns" type="hidden">
		<input name="find" type="hidden">		<!-- find[0] -->
		<input name="find" type="hidden">		<!-- find[1] -->
		<input name="pageNo" type="hidden">
	</form>
</section>
<script type="text/javascript">
var href=window.location.pathname;				//memberList.do 또는 search.do 가져오기
	function goPage(no){
		const frm = document.forms[1];
		frm.action=href;
		frm.pageNo.value=no;
		frm.columns.value='${columns}';
		if('${columns}'=='status')			
			frm.find[1].value='${find}';		//컨트롤러에서 find 값 2개를 배열로 받기 때문  ArrayIndexOutOfBoundsException
		else
			frm.find[0].value='${find}';
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
		document.querySelectorAll("#astatus>option").forEach(function(item){
			if(item.value=='${find}'){
				item.selected='selected';
			}
		});
		//화면 표시 변경하기
 		const status = document.getElementById('status');		
		const content = document.getElementById('content');
		if('${columns}'=='status'){
			status.style.display='inline-block';
			content.style.display='none';
		}else{
			content.style.display='inline-block';
			status.style.display='none';
		}
 		//검색 컬럼 선택 변경될 때
		document.getElementById('columns').addEventListener("change",changeView);
		
		function changeView(){
			const col = document.forms[0].columns.value;
			if(col=='status'){
				status.style.display='inline-block';
				content.style.display='none';
			}else{
				content.style.display='inline-block';
				status.style.display='none';
				//form 요소 가져오기
				document.forms[0].elements[1].value="";
			}
		}
   </script>
</body>
</html>