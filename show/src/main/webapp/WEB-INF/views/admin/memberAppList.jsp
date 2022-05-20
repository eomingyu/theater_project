<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 가입 승인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/freeboard.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@200&family=IBM+Plex+Sans+KR:wght@300&display=swap');
*{
	font-family: 'Hahmlet', serif;
	font-family: 'IBM Plex Sans KR', sans-serif;	
}

</style>
<script type="text/javascript">
	function updateAdmin(id){
		var answer = prompt(id+"님을 관리자로 승인하시겠습니까?\n승인하려면 '가입 승인'을 입력하세요.","")
		if(answer=='가입 승인'){
			var form = document.createElement('form');
			var input = document.createElement('input');
			input.setAttribute('type', 'hidden');
			input.setAttribute('name', 'id');
			input.setAttribute('value', id);
			
			
			form.appendChild(input);
			form.setAttribute('method', 'post');
			form.setAttribute('action', 'memberok.do')
			document.body.appendChild(form);
			form.submit();
		}else
			alert('등록이 취소되었습니다.');
	}
	function deleteMember(id){
		var answer = prompt(id+"님의 관리자 가입을 거절하시겠습니까?\n거절하려면 '가입 거절'를 입력하세요.","")
		if(answer=='가입 거절'){
			var form = document.createElement('form');
			var input = document.createElement('input');
			input.setAttribute('type', 'hidden');
			input.setAttribute('name', 'id');
			input.setAttribute('value', id);
			
			form.appendChild(input);
			form.setAttribute('method', 'post');
			form.setAttribute('action', 'memberno.do')
			document.body.appendChild(form);
			form.submit();
		}else
			alert('삭제가 취소되었습니다.');
	
	}
</script>
<script type="text/javascript">
	setTimeout(function(){			//setTimeout 설정(210ms)
		if(${message != null}) alert('${message}');
	},210);
</script>
<script src="https://kit.fontawesome.com/7ebf19920b.js" crossorigin="anonymous"></script>
</head>
<body>
<body>
<!-- 메뉴바 include -->
<%@include file="menubar.jsp" %>
<section>
	<h3>관리자 가입 승인</h3>
	<hr>
	<div style="margin:auto;">
		<table>
			<tr>
			<th width="10%">No</th>
			<th width="18%">아이디</th>
			<th width="17%">이름</th>
			<th width="20%">생년월일</th>
			<th width="20%">신청일자</th>
			<th width="10%"></th>
			</tr>
			<c:forEach var="vo" items="${list}" varStatus="status">
			<tr class="list">
				<td>${status.count+(page.pageNo-1)*10}</td> 	
		 		<td>${vo.id}</td>
		 		<td>${vo.name }</td>
		 		<td>${vo.birth_date}</td>
		 		<td>
		 		<fmt:formatDate value="${vo.reg_date }" pattern="yyyy-MM-dd"/>  <!-- 출력패턴 -->
		 		</td>
		 		<td>
		<div class="dropdown">
		  <button class="dropbtn">•••</button>
		  <div class="dropdown-content">
		    <a href="javascript:updateAdmin('${vo.id}')">가입 승인</a>
		    <a href="javascript:deleteMember('${vo.id}')">가입 거절</a>
		  </div>
		</div>
				</td>
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
	<form action="memberapprove.do">
		<input name="pageNo" type="hidden">
	</form>
</section>
<script type="text/javascript">
	function goPage(no){
		const frm = document.forms[0];
		frm.pageNo.value=no;
		frm.submit();
	}
   </script>

</body>
</html>