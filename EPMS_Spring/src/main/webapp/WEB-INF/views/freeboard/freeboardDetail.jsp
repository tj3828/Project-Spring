<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 - ${dto.title}</title>
	<link rel="stylesheet" href="../resources/css/freeboard.css">
</head>
<style>
	p {
		margin-bottom: 0 !important;
	}
	
	.like-content {
	    display: inline-block;
	    width: 100%;
	    font-size: 18px;
	    text-align: center;
	}
	.like-content span {
		color: #9d9da4;
		font-family: monospace;
	}
	.like-content .btn-secondary {
		display: block;
		margin-left: auto;
		margin-right: auto;
	    text-align: center;
	    background: #ed2553;
	    border-radius: 3px;
	    box-shadow: 0 10px 20px -8px rgb(240, 75, 113);
	    padding: 10px 17px;
	    font-size: 18px;
	    cursor: pointer;
	    border: none;
	    outline: none;
	    color: #ffffff;
	    text-decoration: none;
	    -webkit-transition: 0.3s ease;
	    transition: 0.3s ease;
	}
	.like-content .btn-secondary:hover {
		  background: #ed2553 !important;
		  transform: translateY(-3px);
	}
	.like-content .btn-secondary .fa {
		  margin-right: 5px;
	}
	.animate-like {
		animation-name: likeAnimation;
		animation-iteration-count: 1;
		animation-fill-mode: forwards;
		animation-duration: 0.65s;
	}
	@keyframes likeAnimation {
	  0%   { transform: scale(30); color:red; }
	  100% { transform: scale(1); color: white;}
	}
</style>
<body>
	<div class="wrap">
		<jsp:include page="../common/top.jsp"></jsp:include>
		<div class="container" >
			<div class="title_label_div">
				<span class="fas fa-file-alt"></span>
				<font class="title_label" >${dto.title}</font>
			</div>
			<div class="panel panel-default"> 
				<div class="panel-body">
					<div class="container container-out">  
						<div class="form-group" style="font-size: 2.5vmin;">
							<strong>작성자 :</strong> <img src="${pageContext.request.contextPath}/resources/upload/${dto.profile_img}" width="50px;" height="50px;">&nbsp;${dto.nickname} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>작성일 :</strong> ${dto.writeDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>조회수 :</strong> ${dto.viewCnt}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong >좋아요 :</strong> <font class="detailLikeCnt">${dto.likeCnt}</font>
						</div>
						<hr>
						<div class="form-group content-div"> 
							<div class="form-control readOnlyContent" style="height: auto;" readonly="readonly">${dto.content}</div>
						</div>
						<br> 
						<c:if test="${dto.upload_file != '' }">
							<label for="File">File input : &nbsp;</label><font style="font-size: 2.5vmin"> <a href="../freeboardDetail/download.do?fidx=${dto.upload_file}&idx=${dto.num}&sidx=${dto.store_upload_file}">${dto.upload_file}</a> (${dto.upload_file_size}kb)</font>
						</c:if>
						<br>
						
						<div class="like-content"> 
						  
						  <button class="btn-secondary likebt">
						    <i class="fa fa-heart" aria-hidden="true"></i> 
						    <font class="likeMsg">
							    <c:if test="${checkLike != 1 || sessionScope.dto.id == null}">Like</c:if>
								<c:if test="${checkLike == 1 && sessionScope.dto.id != null}">You liked this</c:if>
						  	</font>
						  </button>
						  <input type="hidden" id="checkLike" class="checkLike" value="${checkLike}">
						</div>
						<%-- <div style="border: 1px; text-align: center;">
							<button type="button" class="likebt" style="display: inline-block; border: 2px solid red; padding:0.7vmin; border-radius: 15px; background-color: white; cursor: pointer; outline: none;">
								<span style="display: inline-flex ; height: auto;">
									<i class="fas <c:if test="${checkLike == 1 && id != null}">fa-heart-broken</c:if><c:if test="${checkLike != 1 || id == null}">fa-heart</c:if> likeicon" style="color: red;"></i>&nbsp;
									<font class="likeMsg" style="font-size: 3vmin; display: inline-block;">
										<c:if test="${checkLike != 1 || id == null}">좋아요</c:if>
										<c:if test="${checkLike == 1 && id != null}">좋아요 취소</c:if>
									</font>
								</span>
								<font style="font-size: 2.5vmin; ">&nbsp;[<span class="likecnt">${dto.likeCnt}</span>]</font>
							</button>
							<input type="hidden" id="checkLike" class="checkLike" value="${checkLike}">
						</div>  --%>
						<br>
						<br>
						<div align="center"> 
							<c:if test="${sessionScope.dto.id == 'admin'}">
								<input type="button" class="btn btn-outline-success" id="save" onclick="location.href='../freeboardDetail/editPre.do?num=${dto.num}';" value="수정하기">&nbsp;&nbsp;
								<input type="reset" class="btn btn-outline-danger" onclick="detail_Del(${dto.num});" value="삭제하기">&nbsp;&nbsp;
							</c:if>
								<input type="button" class="btn btn-outline-secondary" value="뒤로가기" onclick="history.back(1)">
						</div> 
						<br>
						<hr>
						<br>
						<div class="reply-div">
							<div class="reply_label_div">
								<span class="fas fa-file-alt"></span>
								<font class="title_label" >댓글</font>
							</div>
							<form role="form" >
								<div class="form-group content-div">
									<!-- 세션 히든값 --> 
									<input type="hidden" id="nickname" name="nickname" value="${sessionScope.dto.nickname}">
									<input type="hidden" id="fr_idx" name="fr_idx" value="${dto.num}" >
									<textarea class="form-control" rows="3" name="content" id="content" placeholder="- 100글자까지 입력가능합니다.&#13;&#10;- 비방,욕설,음란내용이 포함된 경우 강제로 삭제될 수 있습니다." maxlength="100"></textarea> 
									<span class="counter" id="counter">###</span>
								</div>
								<div class="form-group content-div" style="text-align: right;">
								<input type="button" class="btn btn-success replySave" value="댓글 저장">
								</div>
							</form>
							<br><br>
							<c:if test="${list.size() != 0}">
								<hr>
								<br>
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<th class="th-s">글쓴이</th>
											<th class="th-l">내용</th>
											<th class="th-s">작성일</th>
											<th class="th-xs">수정</th>
											<th class="th-xs">삭제</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${list}" begin="0" end="${list.size()}">
										<tr>
											<td style="vertical-align:middle" class="th-s"><img src="${pageContext.request.contextPath}/resources/upload/${list.profile_img}" width="30px;" height="30px;"> &nbsp;${list.nickname}</td>
											<td class="th-l" style="padding-left: 10px;">
												<div class="text${list.num}">${list.content}</div>
											</td>
											<td style="vertical-align:middle" class="th-s"><i class="far fa-clock"></i>&nbsp;${list.writeDate}</td>
											<td style="vertical-align:middle">
												<c:if test="${sessionScope.dto.nickname == list.nickname}">
													<input type="button" class="btn btn-primary replyEdit${list.num}" onclick="changeBt(${list.num},'${list.content}');" value="댓글 수정"> 
													<input type="button" class="btn btn-primary replyEditComplete${list.num}" onclick="changeReply(${list.num},${list.fr_idx});" style="display: none;" value="수정 완료">
												</c:if>
											</td>
											<td style="vertical-align:middle">
												<c:if test="${sessionScope.dto.nickname == list.nickname}">
													<input type="button" class="btn btn-danger replyDelete${list.num}" onclick="replyDelete(${list.num},${list.fr_idx});" value="댓글 삭제">
													<input type="button" class="btn btn-danger replyCancel${list.num}" onclick="changeBtCancel(${list.num},'${list.content}');" style="display: none;" value="수정 취소">
												</c:if>
											</td>
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
																<li class='page-item'><a href='../freeboardDetail/detail.do?pageNum=1&num=${dto.num}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;&lt;</span></a></li>
															</c:when>
															<c:otherwise>
																<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;&lt;</span></a></li>
															</c:otherwise>
														</c:choose>
														<c:choose>
													 		<c:when test="${paging.startPage != 1 }">
																<li class='page-item'><a href='../freeboardDetail/detail.do?pageNum=${paging.startPage-1}&num=${dto.num}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;</span></a></li>
															</c:when>
															<c:otherwise>
																<li class='page-item disabled'><a href='#' class="page-link" aria-label='Previous'><span aria-hidden='true'>&lt;</span></a></li>
															</c:otherwise>
														</c:choose>
														<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" step="1">
															<c:choose>
																<c:when test="${paging.pageNum ==i }">
																	<li class='page-item active'><a href='../freeboardDetail/detail.do?pageNum=${i}&num=${dto.num}' class="page-link"><span>${i}</span><span class='sr-only'>${i}</span></a></li>
																</c:when>
																<c:otherwise>
																	<li class='page-item'><a href='../freeboardDetail/detail.do?pageNum=${i}&num=${dto.num}' class="page-link"><span>${i}</span><span class='sr-only'>${i}</span></a></li>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														<c:choose>
															<c:when test="${paging.endPage == paging.pageCount }">
																<li class='page-item disabled'><a href='#' class="page-link" aria-label='Next'><span aria-hidden='true'>&gt;</span></a></li>
															</c:when>
															<c:otherwise>
																<li class='page-item'><a href='../freeboardDetail/detail.do?pageNum=${paging.endPage+1}&num=${dto.num}' class="page-link" aria-label='Next'><span aria-hidden='true'>&gt;</span></a></li>
															</c:otherwise>
														</c:choose>
														<c:choose>
													 		<c:when test="${paging.next}">
																<li class='page-item'><a href='../freeboardDetail/detail.do?pageNum=${paging.pageCount}&num=${dto.num}' class="page-link" aria-label='Previous'><span aria-hidden='true'>&gt;&gt;</span></a></li>
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
							</c:if>
						</div>
					</div> 
				</div> 
			</div>
		</div>
	</div>
	<jsp:include page="../common/chatBt.jsp"></jsp:include>
	<script>	
		$('.replySave').on('click',function(){
			if($('#content').val() == null || $('#content').val().trim() == "") {
				swal('댓글 입력','댓글을 입력해주세요.','error');
				$('#content').focus();
				return false;
			}
			 
			var session_id = "${sessionScope.dto.id}";
			if(session_id == undefined || session_id == "null" || session_id == "") {
				swal('댓글 입력','로그인을 먼저 해주세요.','error');
				return false;
			}
			
			var form = $('form')[0];
	        var formData = new FormData(form);
	        var fr_idx = "${dto.num}";
	        
			$.ajax({
				url: "../freeboardReply/replySave.do",
				type: "POST",
				data: JSON.stringify($('form').serializeObject()),	
				processData: false,
				contentType: "application/json;", 
				success: function() {
					location.href="../freeboardDetail/detail.do?num=" + fr_idx;
				},
				error: function (request) {
					swal('댓글 작성 오류',request.responseText+"\n관리자에게 문의하세요.",'error');
				}
			});
			
		});
	
		$('#content').keyup(function (e){
		    var content = $(this).val();
		    $('#counter').html(content.length + '/100');
		});
		$('#content').keyup();
		
		$('.replyEdit').on('click', function() {
			$('.replyEdit').hide();
			$('.replyEdit').hide();
		});
			
		function checkLength(num) {
			$('#content'+num).keyup(function (e){
			    var content = $(this).val();
			    $('#counter'+num).html(content.length + '/100');
			});
		}
		
		function changeBt(num, content) {
			$('.replyEdit'+num).hide();
			$('.replyDelete'+num).hide();
			$('.text'+num).html('');
			$('.text'+num).html('<div class="form-group content-div"><textarea class="form-control" rows="3" name="content" id="content'+num+'" placeholder="- 100글자까지 입력가능합니다.&#13;&#10;- 비방,욕설,음란내용이 포함된 경우 강제로 삭제될 수 있습니다." onkeyup="checkLength('+num+');" maxlength="100">'+content+'</textarea><span class="counter" id="counter'+num+'">###</span></div>');
			$('#counter'+num).html(content.length + '/100');
			$('.replyEditComplete'+num).show();
			$('.replyCancel'+num).show();
		}
		
		function changeBtCancel(num, content) {
			$('.replyEdit'+num).show();
			$('.replyDelete'+num).show();
			$('.text'+num).html('');
			$('.text'+num).html(content);
			$('.replyEditComplete'+num).hide();
			$('.replyCancel'+num).hide();
		}
		
		function replyDelete(num, fr_idx) {
			$.ajax({
				url: "../freeboardReply/replyDelete.do",
				type: "POST",
				data: {"num":num, "fr_idx":fr_idx},	
				success: function(){
					swal({
						title:"댓글 삭제",
						text : "댓글이 삭제되었습니다.",
						icon : "success"
					}).then((willDelete) => {
						if(willDelete) {
							window.location.reload();
						}
					})

				},
				error: function(request,status,error) {
					swal('댓글 삭제','댓글 삭제에 오류가 발생했습니다.\n관리자에게 문의하세요.','error');
				}
			});
		}
		
		function changeReply(num, fr_idx) {
			var content = $('#content'+num).val();
			var nickname = "${sessionScope.dto.nickname}";
			$.ajax({
				type: "POST",
				url: "../freeboardReply/replyEdit.do",
				data: JSON.stringify({"num":num, "fr_idx":fr_idx, "content": content, "nickname": nickname}),
				contentType: "application/json;",
				success: function() {
					swal({
						title:"댓글 수정",
						text : "댓글이 수정되었습니다.",
						icon : "success"
					}).then((willDelete) => {
						if(willDelete) {
							window.location.reload();
						}
					});
				},
				error: function (request) {
					swal('댓글 수정',request.responseText + '\n관리자에게 문의하세요.','error');
				}
			});
		}
		
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
							url:"../freeboardDetail/delete.do", 
							data: {"num" : num},
							success: function(){
								location.href='../freeboard/freeboard.do';
							},
							error: function() {
								swal('게시글 삭제','게시글 삭제에 오류가 발생했습니다.\n관리자에게 문의하세요.','error');
							}
					  });
				  } else {
					  
				  }
			  });

		}
		
		/* $('.likebt').mouseover(function() {
			$('.likebt').css('background-color','rgba(255, 0, 0, 0.11)');
		});
		
		$('.likebt').mouseout(function() {
			$('.likebt').css('background-color','white');
		});
		
		$('.likebt').mousedown(function() {
			$('.likebt').css('background-color','rgba(255, 0, 0, 0.5)');
		});
		
		$('.likebt').mouseup(function() {
			$('.likebt').css('background-color','rgba(255, 0, 0, 0.11)');
		}); */
		
		$('.likebt').click(function() {
			var id = "${sessionScope.dto.id}";
			if(id == "" || id == null) {
				swal('로그인','로그인을 해주세요.','error');
				return false;
			}
			else {
				var fr_idx = $('#fr_idx').val();
				var like = $('#checkLike').val();
				$.ajax({
					url:"../like/change.do",
					data:{"fr_idx":fr_idx, "id":id,"Like":like},
					type: "post",
					success:function(data){
						$('.likecnt').html(data.likeCnt);
						$('#checkLike').val(data.checkLike).trigger('change');
					},
					error:function(){
						swal('좋아요 오류','관리자에게 문의하세요.','error');
					}
				});
			}
		});
		
		$('.checkLike').change(function(){
			var checkLike = $('#checkLike').val();
			var cnt = $('.detailLikeCnt').html()*1;

			if(checkLike == 1) {
				$('.likeMsg').html('You liked this');
				$('.likebt').children('.fa-heart').addClass('animate-like');
				$('.detailLikeCnt').html(cnt+1);
				setTimeout(function() {
					$('.likebt').children('.fa-heart').removeClass('animate-like');
					}, 650);
			} else {
				$('.likeMsg').html('Like');
				$('.likebt').children('.fa-heart').addClass('animate-like');
				$('.detailLikeCnt').html(cnt-1);
				setTimeout(function() {
					$('.likebt').children('.fa-heart').removeClass('animate-like');
					}, 650);
			}
		});
	</script>
</body>
</html>
<jsp:include page="../common/footer.jsp"></jsp:include>