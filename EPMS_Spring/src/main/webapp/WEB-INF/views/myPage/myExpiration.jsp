<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만료내역</title>
	<link rel="stylesheet" href="../resources/css/freeboard.css">
</head>
<style>
	table th, table td{
		vertical-align: middle !important; 
	}
</style>
<body>
<div class="wrap">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="container">
		<div class="title_label_div">
			<span class="fas fa-align-justify"></span>
			<font class="title_label" >만료내역</font>
		</div>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th class="th-xs">신청자</th>
					<th class="th-xs">대여자</th>
					<th class="th-l">주소</th>
					<th class="th-xs">주차공간</th>
					<th class="th-s">대여기간</th>
					<th class="th-xs">만료시간</th>
					<th class="th-xs">상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
					<tr>
						<td class="th-xs"><img src="${pageContext.request.contextPath}/resources/upload/${list.r_guest_profileImg}" width="30px;" height="30px;"> &nbsp;${list.r_guest}</td>
						<td class="th-xs"><img src="${pageContext.request.contextPath}/resources/upload/${list.r_host_profileImg}" width="30px;" height="30px;"> &nbsp;${list.r_host}</td>
						<td class="th-l">${list.r_address}</td>
						<td class="th-xs">${list.r_area}</td>
						<td class="th-s">${list.r_from} ~ <br>${list.r_to}</td>
						<td class="th-xs">${list.r_statusDate}</td>
						<td class="th-xs">
							<c:if test="${list.r_status == '예약취소'}"><font color="red">예약취소</font></c:if>
							<c:if test="${list.r_status == '사용완료'}"><font color="blue">사용완료</font></c:if>
						</td>
					</tr>
				 </c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7" align="center">
						<nav aria-label="..." >
							<ul class="pagination justify-content-center">
								<c:choose>
							 		<c:when test="${paging.prev}">
										<li class='page-item'><a href='../myInfo/myExpirationPage.do?pageNum=1${paging.returnPage}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;&lt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;&lt;</span></a></li>
									</c:otherwise>
								</c:choose>
								<c:choose>
							 		<c:when test="${paging.startPage != 1 }">
										<li class='page-item'><a href='../myInfo/myExpirationPage.do?pageNum=${paging.startPage-1}${paging.returnPage}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;</span></a></li>
									</c:otherwise>
								</c:choose>
								<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" step="1">
									<c:choose>
										<c:when test="${paging.pageNum ==i }">
											<li class='page-item active'><a href='../myInfo/myExpirationPage.do?pageNum=${i}${paging.returnPage}' class="page-link"><span>${i}</span><span class='sr-only'>${i}</span></a></li>
										</c:when>
										<c:otherwise>
											<li class='page-item'><a href='../myInfo/myExpirationPage.do?pageNum=${i}${paging.returnPage}' class="page-link"><span>${i}</span><span class='sr-only'>${i}</span></a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:choose>
									<c:when test="${paging.endPage == paging.pageCount }">
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Next'><span aria-hidden='true'>&gt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item'><a href='../myInfo/myExpirationPage.do?pageNum=${paging.endPage+1}${paging.returnPage}' class="page-link" aria-label='Next'><span aria-hidden='true'>&gt;</span></a></li>
									</c:otherwise>
								</c:choose>
								<c:choose>
							 		<c:when test="${paging.next}">
										<li class='page-item'><a href='../myInfo/myExpirationPage.do?pageNum=${paging.pageCount}${paging.returnPage}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&gt;&gt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&gt;&gt;</span></a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<jsp:include page="../common/chatBt.jsp"></jsp:include>
</body>
</html>
<jsp:include page="../common/footer.jsp"></jsp:include>