<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 - 수정</title>
	<link rel="stylesheet" href="../resources/css/freeboard.css">
</head>
<body>
	<div class="wrap">
		<jsp:include page="../common/top.jsp"></jsp:include>
		<div class="container">
			<div class="title_label_div">
				<span class="fas fa-edit"></span>
				<font class="title_label" >자유게시판 - 수정</font>
			</div>
			<div class="panel panel-default"> 
				<div class="panel-body">
					<div class="container"> 
						<form id="writeForm" enctype="multipart/form-data" method="post">  
							<div class="row"> 
								<div class="col-md-12">
									<div class="form-group"> 
										<label for="name">NAME</label> 
										<input type="hidden" name="num" value="${dto.num}">
										<input type="text" class="form-control" name="nickname" id="nickname" value="${dto.nickname}" readonly="readonly" placeholder="Enter name"> 
									</div> 
								</div>
							</div>
							<div class="form-group content-div"> 
								<label for="subject">Title</label> 
								<input type="text" class="form-control" name ="title" id="title" value="${dto.title}" placeholder="30글자까지 입력가능합니다." maxlength="30"> 
								<span class="counter" id="counter1">###</span>
							</div> 
							<div class="form-group content-div"> 
								<label for="content">Comment:</label> 
								<textarea class="form-control" rows="10" name="content" id="content" placeholder="- 300글자까지 입력가능합니다.&#13;&#10;- 비방,욕설,음란내용이 포함된 경우 강제로 삭제될 수 있습니다." maxlength="300">${dto.content}</textarea> 
								<span class="counter" id="counter">###</span>
							</div>
							<br>
							<div class="form-group"> 
								<label for="File">File input : &nbsp;</label> 
								<input type="file" name="multipartFile"> 
							</div>
							<br>
							<hr>
							<br>
							<div align="center"> 
								<input type="button" class="btn btn-outline-success" id="save" value="저장하기">&nbsp;&nbsp;<input type="reset" class="btn btn-outline-danger" value="다시쓰기">&nbsp;&nbsp;<input type="button" class="btn btn-outline-secondary" value="뒤로가기" onclick="history.back(1)">
							</div> 
						</form>
					</div> 
				</div> 
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$('#save').on('click',function(){
			var title =  $('#title').val();
			var content = $('#content').val();
			
			if( title == null || title.trim() == "" ) {
				swal('글쓰기 오류','제목을 입력해주세요.','error');
				return false;
			}
			
			if( content == null || content.trim() == "") {
				swal('글쓰기 오류','내용을 입력해주세요.','error');
				return false;
			}
			
			var form = $('form')[0];
	        var formData = new FormData(form);
	        var num = "${dto.num}";
	        $.ajax({
				type:"POST",
				url:"../freeboardDetail/edit.do",
				processData: false,
	            contentType: false,
				data: formData,
				success: function() {
					location.href="../freeboardDetail/detail.do?num=" + num;
				},
				error: function () {
					swal('글수정 오류','관리자에게 문의하세요.','error');
				}
			});
			
		});
		
		$('#counter').html($('#content').val().length + '/300');
		$('#content').keyup(function (e){
		    var content = $(this).val();
		    $('#counter').html(content.length + '/300');
		});
		$('#content').keyup();
		
		$('#counter1').html($('#title').val().length + '/300');
		$('#title').keyup(function (e){
		    var title = $(this).val();
		    $('#counter1').html(title.length + '/30');
		});
		$('#title').keyup();
	</script>
</body>
</html>