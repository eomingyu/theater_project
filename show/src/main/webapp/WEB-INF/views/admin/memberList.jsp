<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');

*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}
</style>
</head>
<body>
<h3>회원 목록</h3>
<hr>
<div style="margin:auto;">
	<div style="text-align:right;">
		<form action="search.do">
			<select name="columns" id="columns">
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="authority">권한</option>
			</select>
			<!-- 아래 find는 2개 중에 하나만 화면에 표시  -->
			<span id="content">
				<input name="find" placeholder="검색할 내용 입력" value="${find}">
			</span>
			<span id="authority">
				<select name="find" id="authorities">
				<!-- 사용자 선택하는 텍스트와 db테이블에 저장된 값이 다릅니다. -->
					<option value="1">일반 회원</option>
					<option value="0">관리자</option>
				</select>
			</span>
			<button>검색</button>
			<button type="button" onclick="location.href='memberList.do'">전체보기</button>
		</form>
	</div>
	<table>
		<tr>
		<th width="8%">No</th>
		<th width="15%">아이디</th>
		<th width="15%">이름</th>
		<th width="20%">생년월일</th>
		<th width="20%">가입일자</th>
		<th width="10%">구분</th>
		<th width="7%">?</th>
		</tr>
		<c:forEach var="vo" items="${list}" varStatus="status">
		<tr>
			<td>${status.count+(page.pageNo-1)*10}</td> 	
	 		<td><%-- <a href="detail?idx=${vo.id}&pageNo=${page.pageNo}" class="title"> --%>${vo.id}</td>
	 		<td>${vo.name }</td>
	 		<td>${vo.birth_date}</td>
	 		<td>
	 		<fmt:formatDate value="${vo.reg_date }" pattern="yyyy-MM-dd"/>  <!-- 출력패턴 -->
	 		</td>
	 		<td>
	 		<c:if test="${vo.authority==1}">
	 			<span>일반 회원</span>
	 		</c:if>
	 		<c:if test="${vo.authority==0}">
	 			<span style="color:red;font-weight:bolder;">관리자</span>
	 		</c:if>
	 		<%-- <c:choose>
	 			<c:when test="${vo.authority==1}">
	 				<span>일반 회원</span>
	 			</c:when>
	 			<c:otherwise>
	 				<span style="color:red;font-weight:bolder;">관리자</span>
	 			</c:otherwise>
	 		</c:choose> --%>
	 		</td>
	 		<td>?</td>
	 	</tr>
 	 	</c:forEach>
 	 	<!-- list의 데이터가 없을 때 list애트리뷰트가 null X,size()가 0(jstl의 함수) -->
	<c:if test="${fn:length(list)==0 }">
				<tr>
					<td colspan="7">조회 결과가 없습니다.</td>
				</tr>
	</c:if>
	</table>
</div>

<div style="text-align: center;">
	<a class="pagenum" href="?pageNo=1">&lt;&lt;</a>   <!-- 요청url은 동일하고 파라미터만 변경됩니다. -->
	<a class="${page.startPage>1? 'pagenum':'none'}" 
		href="?pageNo=${page.startPage-1 }">&lt;</a>  
	
	<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">  <!-- 페이지목록의 범위  -->
		<a class="pagenum" href="?pageNo=${i}">${i}</a>     <!-- 현재페이지 i값으로 변경  -->
	</c:forEach>
	
	<a class="${page.endPage!=page.totalPage? 'pagenum':'none'}" 
		href="?pageNo=${page.endPage+1 }">&gt;</a> 
	<a class="pagenum" href="?pageNo=${page.totalPage }">&gt;&gt;</a>
</div>

<script type="text/javascript">
   		//조회 후에 select 남아있게 하기
		const sel = document.querySelectorAll("#columns>option");	/* > 자식요소  */
		sel.forEach(function(item){
			if(item.value=='${columns}'){
				item.selected='selected';
				//column 애트리뷰트 값과 일치하는 option 항목일 때입니다.
			}
		});
		document.querySelectorAll("#authorities>option").forEach(function(item){
			if(item.value=='${find}'){
				item.selected='selected';
			}
		});
		//화면 표시 변경하기
 		const authority = document.getElementById('authority');		//span grade
		const content = document.getElementById('content');
		if('${columns}'=='authority'){
			authority.style.display='inline-block';
			content.style.display='none';
		}else{
			content.style.display='inline-block';
			authority.style.display='none';
		}
 		//검색 컬럼 선택 변경될 때
		document.getElementById('columns').addEventListener("change",changeView);
		
		function changeView(){
			const col = document.forms[0].columns.value;
			if(col=='authority'){
				authority.style.display='inline-block';
				content.style.display='none';
			}else{
				content.style.display='inline-block';
				authority.style.display='none';
				//form 요소 가져오기
				document.forms[0].elements[1].value="";
			}
		}
		
		//authority.style.display='none';		//안보이게 하는 방법
   </script>

</body>
</html>