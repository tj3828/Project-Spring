<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
	<link rel="stylesheet" href="../resources/css/freeboard.css">
</head>
<body>
<div class="wrap">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="container">
		<div class="title_label_div">
			<span class="fas fa-align-justify"></span>
			<font class="title_label" >FAQ</font>
			<form name="myform" action="../freeboard/freeboard.do" style="display: none; right: 0; text-align:center; width:50%; float: right; margin-top: 0.7%;">
		  	 	<select class="selectpicker" name="keyfield" onchange="changeclear();" style="height: calc(2.25rem + 2px); width: 15%;">
		  	 	   <option value="nickname"  <c:if test="${paging.keyfield == 'nickname'}">selected</c:if>> 글쓴이 </option>
		  	 	   <option value="title" <c:if test="${paging.keyfield == 'title'}">selected</c:if>> 제목 </option>
		  	 	</select>
		  	 	<input type="text" class="form-control" style="width:50%; display:inline-block;" id="keyword" name="keyword" value="${paging.keyword}" size=10>
		  	 	<input type="submit" class="btn btn-success" value="검색"> 
		  	 </form>
		</div>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th class="th-xs">No.</th>
					<th class="th-l">제목</th>
					<th class="th-s">글쓴이</th>
					<th class="th-s">작성일</th>
					<th class="th-xs">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
				<tr>
					<c:choose>
						<c:when test="${list.lev > 1}">
							<td class="th-xs"></td>
							<td colspan="1" style="width:20%; padding-left: 10px; position: relative; ">
								<c:forEach begin="1" end="${list.lev}">
									&nbsp;&nbsp;
								</c:forEach>
								<span style="text-align: center;">
									<c:choose>
										<c:when test="${list.title.length() > 20 }"><a href="../faqDetail/faqDetail.do?num=${list.num}">└ RE : ${fn:substring(list.title, 0, 15)}...</a></c:when>
									<c:otherwise>
										<a href="../faqDetail/faqDetail.do?num=${list.num}">└ RE : ${list.title}</a>
									</c:otherwise>
									</c:choose>
									
								</span>
								<c:if test="${list.upload_file != '' }">
									<i class="fas fa-file-download" style="font-size: 22px; position: absolute; right: 1%;"></i>
								</c:if>
							</td>
						</c:when>
						<c:otherwise>
							<td class="th-xs">${list.rn}</td>
							<td class="th-l" style="padding-left: 10px; position: relative;">
								<span style="text-align: center;">
									<c:choose>
										<c:when test="${list.title.length() > 20 }"><a href="../faqDetail/faqDetail.do?num=${list.num}">${fn:substring(list.title, 0, 19)}...</a></c:when>
									<c:otherwise>
										<a href="../faqDetail/faqDetail.do?num=${list.num}">${list.title}</a>
									</c:otherwise>
									</c:choose>
									<c:if test="${list.childCnt != 0 && list.lev == 1}"><span style="color:red;">[${list.childCnt}]</span></c:if>
								</span>
								<c:if test="${list.upload_file != '' }">
									<i class="fas fa-file-download" style="font-size: 22px; position: absolute; right: 1%;"></i>
								</c:if>
							</td>
						</c:otherwise>
					</c:choose>
					<td class="th-s"><img src="${pageContext.request.contextPath}/resources/upload/${list.profile_img}" width="30px;" height="30px;"> &nbsp;${list.nickname}</td>
					<td class="th-s"><i class="far fa-clock"></i>&nbsp;${list.writeDate}</td>
					<td class="th-xs"><i class="far fa-eye"></i>&nbsp;${list.viewCnt}</td>
				</tr>
				 </c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5" align="center">
						<nav aria-label="..." >
							<ul class="pagination justify-content-center">
								<c:choose>
							 		<c:when test="${paging.prev}">
										<li class='page-item'><a href='../faq/faq.do?pageNum=1${paging.returnPage}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;&lt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;&lt;</span></a></li>
									</c:otherwise>
								</c:choose>
								<c:choose>
							 		<c:when test="${paging.startPage != 1 }">
										<li class='page-item'><a href='../faq/faq.do?pageNum=${paging.startPage-1}${paging.returnPage}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;</span></a></li>
									</c:otherwise>
								</c:choose>
								<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" step="1">
									<c:choose>
										<c:when test="${paging.pageNum ==i }">
											<li class='page-item active'><a href='../faq/faq.do?pageNum=${i}${paging.returnPage}' class="page-link"><span>${i}</span><span class='sr-only'>${i}</span></a></li>
										</c:when>
										<c:otherwise>
											<li class='page-item'><a href='../faq/faq.do?pageNum=${i}${paging.returnPage}' class="page-link"><span>${i}</span><span class='sr-only'>${i}</span></a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:choose>
									<c:when test="${paging.endPage == paging.pageCount }">
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Next'><span aria-hidden='true'>&gt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item'><a href='../faq/faq.do?pageNum=${paging.endPage+1}${paging.returnPage}' class="page-link" aria-label='Next'><span aria-hidden='true'>&gt;</span></a></li>
									</c:otherwise>
								</c:choose>
								<c:choose>
							 		<c:when test="${paging.next}">
										<li class='page-item'><a href='../faq/faq.do?pageNum=${paging.pageCount}${paging.returnPage}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&gt;&gt;</span></a></li>
									</c:when>
									<c:otherwise>
										<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&gt;&gt;</span></a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<input type=button class="btn btn-outline-success" value="글쓰기" onclick="return writeForm();">
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<jsp:include page="../common/chatBt.jsp"></jsp:include>
<script type="text/javascript">
	function changeclear() {
		$('#keyword').val("");
	}
	
	function writeForm() {
		var session_id = "${sessionScope.dto.id}";
		if(session_id == "null" || session_id == "") {
			swal("글쓰기 오류" , "로그인을 먼저 해주세요.", "error");
			return;
		}
		location.href='../faq/faqWritePre.do';
	}
</script>
</body>
</html>