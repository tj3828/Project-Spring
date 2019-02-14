package common;

public class Paging {
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int searchCount;
	private int start;
	private int end;
	private int pageNum = 1;
	private int rowPageNum;
	private int colPageNum;
	private int pageCount;
	private String keyfield = "title";
	private String keyword = "";
	private String returnPage;
	
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
		
	public String getReturnPage() {
		return returnPage;
	}

	public void setReturnPage(String returnPage) {
		this.returnPage = returnPage;
	}

	public String getReutrnPage() {
		return returnPage;
	}

	public void setReutrnPage(String returnPage) {
		this.returnPage = returnPage;
	}

	public String getKeyfield() {
		return keyfield;
	}

	public void setKeyfield(String keyfield) {
		this.keyfield = keyfield;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}



	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getSearchCount() {
		return searchCount;
	}

	public void setSearchCount(int searchCount) {
		this.searchCount = searchCount;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getRowPageNum() {
		return rowPageNum;
	}

	public void setRowPageNum(int rowPageNum) {
		this.rowPageNum = rowPageNum;
	}

	public int getColPageNum() {
		return colPageNum;
	}

	public void setColPageNum(int colPageNum) {
		this.colPageNum = colPageNum;
	}
	
}
