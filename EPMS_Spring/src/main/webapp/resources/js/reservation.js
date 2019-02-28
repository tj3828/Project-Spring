var selectedArea = -1;
var pageNum = 1;

$(function(){
	
	fe_mapSelectSeoul(); //메인화면 지도 화면 효과
	mainSearchAjax(1);	 //메인화면 검색 ajax
	
	$('#searchAreaText').keyup(function() {
		mainSearchAjax(1);
	});
	
});

function mainSearchAjax(pageNUM) {
	pageNum = pageNUM;
	var selectArea = $(".kr_Seoul").find("li").eq(selectedArea).find("img").attr("alt");
	if(selectedArea == -1) {
		selectArea = "";
	}
	
	$.ajax({
		url: '../reservationPage/searchList.do',
		data: {"keyfield": selectArea, "keyword": $('#searchAreaText').val(), "pageNum" : pageNum },
		dataType: "json",
		success: function(data) {
			if(data.list.length == 0) {
				$('tbody').empty();
				$('.pagination').empty();
				$('tfoot').empty();
				$('tbody').append('<tr>' +
				   		'<td>"' + $('#searchAreaText').val() + '"에 대한 장소가 없습니다.</td>' +
				   '</tr>');
				return false;
			}
			setSearchList(data.list);
			setSearchListPaging(data.paging);
		}
	});
}

function setSearchListPaging(paging) {
	$('.pagination').empty();
	$('tfoot').empty();
	$('table').append('<tfoot>' +
					  	'<tr>' +
							'<td>' +
								'<nav aria-label="..." >' +
									'<ul class="pagination justify-content-center">' +
									'</ul>' +
								'</nav>' +
							'</td>' +
						'</tr>' +
					   '</tfoot>');
	if(paging.prev) {
		$('.pagination').append('<li class="page-item"><a href="javascript:mainSearchAjax(1);" class="page-link" aria-label="Previous"><span aria-hidden="true">&lt;&lt;</span></a></li>');
	} else {
		$('.pagination').append('<li class="page-item disabled"><a href="#" class="page-link" aria-label="Previous"><span aria-hidden="true">&lt;&lt;</span></a></li>');
	}
	
	if(paging.startPage != 1) {
		$('.pagination').append('<li class="page-item"><a href="javascript:mainSearchAjax(' + (paging.startPage -1) + ')" class="page-link" aria-label="Previous"><span aria-hidden="true">&lt;</span></a></li>');
	} else {
		$('.pagination').append('<li class="page-item disabled"><a href="#" class="page-link" aria-label="Previous"><span aria-hidden="true">&lt;</span></a></li>');
	}
	 
	for(var i=paging.startPage; i<=paging.endPage; i++) {
		if(paging.pageNum == i) {
			$('.pagination').append('<li class="page-item active"><a href="#" class="page-link"><span>' + i + '</span><span class="sr-only">' + i + '</span></a></li>');
		} else {
			$('.pagination').append('<li class="page-item"><a href="javascript:mainSearchAjax(' + i + ');" class="page-link"><span>' + i + '</span><span class="sr-only">' + i + '</span></a></li>');
		}
    }
	
	if(paging.endPage == paging.pageCount) {
		$('.pagination').append('<li class="page-item disabled"><a href="#" class="page-link" aria-label="Next"><span aria-hidden="true">&gt;</span></a></li>');
	} else {
		$('.pagination').append('<li class="page-item"><a href="javascript:mainSearchAjax(' + (paging.endPage +1) + ')" class="page-link" aria-label="Next"><span aria-hidden="true">&gt;</span></a></li>');
	}
	
	if(paging.next) {
		$('.pagination').append('<li class="page-item"><a href="javascript:mainSearchAjax(' + paging.pageCount + ')" class="page-link" aria-label="Previous"><span aria-hidden="true">&gt;&gt;</span></a></li>');
	} else {
		$('.pagination').append('<li class="page-item disabled"><a href="#" class="page-link" aria-label="Previous"><span aria-hidden="true">&gt;&gt;</span></a></li>');
	}
}

function setSearchList(list) {
	$('tbody').empty();
	jQuery.each(list, function(index, entry) {
		lat.push(entry["pa_lat"]);lon.push(entry["pa_lon"]);add.push(entry["pa_address"]);
		$('tbody').append('<tr>' +
						   		'<td>' + 
						   			'<a href="javascript:modalMap(' + entry["pa_lat"] + ', ' + entry["pa_lon"] + ', \'' +  entry["pa_address"] + '\' )">' +  
						   				entry["pa_address"] +
						   			'</a>' +
						   		'</td>' +
						   '</tr>');
	});
}

function fe_mapSelectSeoul(){
	var $container = $(".kr_Seoul");
	var $overImage = $container.find("li");
	var $trigger = $container.find("area");
	
	$trigger.each(function(i){
		$(this).mouseover(function() {
			$overImage.hide();
			$overImage.eq(i).show();
			if(selectedArea != -1) {
				$overImage.eq(selectedArea).show();
			}
		});
		
		$(this).mouseleave(function(){
			$overImage.hide();
			if(selectedArea != -1) {
				$overImage.eq(selectedArea).show();
			}
		});
		
		$(this).click(function() {
			if(selectedArea == i) {
				$overImage.hide();
				selectedArea = -1;
				mainSearchAjax(1);
				$('#searchAreaText').attr("placeholder","전체 지역에서 검색합니다.");
				return;
			}
			$overImage.hide();
			$overImage.eq(i).show();
			selectedArea = i;
			mainSearchAjax(1);
			var selectArea = $(".kr_Seoul").find("li").eq(selectedArea).find("img").attr("alt");
			$('#searchAreaText').attr("placeholder",'"' + selectArea + "\" 내에서 검색합니다.");
		});
	});
}
		
		