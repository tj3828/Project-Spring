<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 - ${list[0].title}</title>
	<link rel="stylesheet" href="../resources/css/freeboard.css">
</head>
<style>
	p {
		margin-bottom: 0 !important;
	}
</style>
<body>
	<div class="wrap">
		
		<jsp:include page="../common/top.jsp"></jsp:include>
		<div class="container" >
			<div class="title_label_div">
				<span class="fas fa-file-alt"></span>
				<font class="title_label" >${list[0].title}</font>
			</div>
			<div class="panel panel-default"> 
				<div class="panel-body">
					<div class="container container-out">  
						<div class="form-group" style="font-size: 2.5vmin;">
							<strong>작성자 :</strong> <img src="${pageContext.request.contextPath}/resources/upload/${list[0].profile_img}" width="50px;" height="50px;">&nbsp;${list[0].nickname} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>작성일 :</strong> ${list[0].writeDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>조회수 :</strong> ${list[0].viewCnt}
						</div>
						<hr>
						<div class="form-group content-div"> 
							<div class="form-control readOnlyContent" style="height: auto;" readonly="readonly">${list[0].content}</div>
						</div>
						<br> 
						<c:if test="${list[0].upload_file != '' }">
							<label for="File">File input : &nbsp;</label> <font style="font-size: 2.5vmin"><a href="../freeboardDetail/download.do?fidx=${list[0].upload_file}&idx=${list[0].num}&sidx=${list[0].store_upload_file}">${list[0].upload_file}</a> (${list[0].upload_file_size}kb)</font>
						</c:if>
						
						<br>
						<div align="center"> 
							<c:if test="${sessionScope.dto.nickname != null }"> 
								<input type="button" class="btn btn-outline-primary" id="replyPre" onclick="location.href='../faqReply/faqReplyPre.do?num=${list[0].num}&lev=${list[0].lev}&groupNum=${list[0].groupNum}&title=${list[0].title}';" value="답글달기">&nbsp;&nbsp;
							</c:if>
							<c:if test="${sessionScope.dto.nickname == list[0].nickname}">
								<input type="button" class="btn btn-outline-success" id="save" onclick="location.href='../faqDetail/faqEditPre.do?num=${list[0].num}';" value="수정하기">&nbsp;&nbsp;
								<input type="reset" class="btn btn-outline-danger" onclick="detail_Del(${list[0].num});" value="삭제하기">&nbsp;&nbsp;
							</c:if>
								<input type="button" class="btn btn-outline-secondary" value="뒤로가기" onclick="history.back(1)">
						</div> 
						<br>
						<hr>
						<br>
						
					</div> 
				</div> 
			</div>
			<br><br><br>
			<c:if test="${list.size() > 1}">
				<div class="title_label_div" style="background-color: #ff8000;">
					<span class="fab fa-replyd"></span>
					<font class="title_label" >답글</font>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th class="th-s">글쓴이</th>
							<th class="th-l" style="width:50%;">내용</th>
							<th class="th-s">작성일</th>
							<th class="th-xs">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${list}" begin="0" end="${list.size()}" varStatus="index">
						<c:if test="${index.index != 0}">
							<tr>
								<td style="vertical-align:middle" class="th-s"><img src="${pageContext.request.contextPath}/resources/upload/${list.profile_img}" width="30px;" height="30px;"> &nbsp;${list.nickname}</td>
								<td class="th-l" style="padding-left: 10px; width:50%; position: relative;" >
									<span style="text-align: center;">
										<c:choose>
											<c:when test="${list.title.length() > 20 }">
												<a href="../faqDetail/faqDetail.do?num=${list.num}">${fn:substring(list.title, 0, 19)}...</a>
												<c:if test="${list.childCnt != 0 }"><span style="color:red;">[${list.childCnt}]</span></c:if>
											</c:when>
											<c:otherwise>
												<a href="../faqDetail/faqDetail.do?num=${list.num}">${list.title}</a>
												<c:if test="${list.childCnt != 0 }"><span style="color:red;">[${list.childCnt}]</span></c:if>
											</c:otherwise>
										</c:choose>
									</span>
									<c:if test="${list.upload_file != '' }">
										<i class="fas fa-file-download" style="font-size: 22px; position: absolute; right: 1%;"></i>
									</c:if>
								</td>
								<td style="vertical-align:middle" class="th-s"><i class="far fa-clock"></i>&nbsp;${list.writeDate}</td>
								<td class="th-xs" style="vertical-align:middle">
									<i class="far fa-eye"></i>&nbsp;${list.viewCnt}
								</td>
							</tr>
						</c:if>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	<jsp:include page="../common/chatBt.jsp"></jsp:include>
	<script type="text/javascript">
	function detail_Del(num) {
		swal({
			  title: "게시글 삭제",
			  text: "정말 게시글을 삭제하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
		 })
		 .then((willDelete) => {
			  if(willDelete) {
			      $.ajax({
						type:"post",
						url:"../faqDetail/faqDelete.do", 
						data: {"num" : num},
						success: function(){
							location.href='../faq/faq.do';
						},
						error: function() {
							swal('게시글 삭제','게시글 삭제에 오류가 발생했습니다.\n관리자에게 문의하세요.','error');
						}
				  });
			  } else {
				  
			  }
		  });

	}
	</script>
</body>
</html>
<jsp:include page="../common/footer.jsp"></jsp:include>