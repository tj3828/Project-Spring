package common;

import lombok.Data;

@Data
public class Paging {
	private int totalCount;	// 전체 리스트 갯수
	private int startPage;  // 시작 페이지
	private int endPage;	// 끝 페이지
	private boolean prev;	// 맨 처음으로
	private boolean next;	// 맨 끝으로
	private int searchCount;// 검색 리스트 갯수
	private int start;		// 페이지에서 게시물 시작 번호
	private int end;		// 페이지에서 게시물 끝 번호
	private int pageNum = 1;// 선택한 페이지 넘버
	private int rowPageNum; // 페이징 갯수
	private int colPageNum; // 페이징에 나타날 게시물 갯수
	private int pageCount;	// 총 페이지 
	private String keyfield = "title";	// 검색 유형
	private String keyword = "";		// 검색어
	private String returnPage;			// 검색어 기억
	
	public void calulate() {
		pageCount = (searchCount % colPageNum == 0) ? searchCount/colPageNum : searchCount/colPageNum +1; 
		
		startPage = (pageNum -1) / rowPageNum * rowPageNum +1;
		endPage = startPage + rowPageNum -1;
		
		if(endPage>pageCount) { endPage=pageCount; }
		
		start = (searchCount - ((pageNum  -1) * colPageNum));
		end = start - colPageNum +1;
		
		prev = (startPage != 1) ? true : false;
		next = (endPage != pageCount) ? true : false;	
		
		returnPage = "&keyfield="+keyfield+"&keyword="+keyword;
	}
	
}
