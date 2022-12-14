package com.myboard.model;

public class PageDTO {

	private int startPage;		// 시작페이지 번호
	private int endPage;		// 마지막페이지 번호
	private int total;			// 게시글 총 갯수
	private boolean prev, next;	// 이전, 다음 버튼
	private Criteria cri;		

	public Criteria getCri() {
		return cri;
	}

	/* 생성자 */
	public PageDTO(Criteria cri, int total) {

		this.cri = cri;
		this.total = total;

		/* 마지막 페이지 */
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		/* 시작 페이지 */
		this.startPage = this.endPage - 9;

		/* 전체 마지막 페이지 */
		int realEnd = (int) (Math.ceil(total * 1.0 / cri.getAmount()));

		/*
		 * 전체 마지막 페이지(realend)가 화면에 보이는 마지막페이지(endPage)보다 작은 경우, 보이는 페이지(endPage) 값 조정
		 */
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		/* 시작 페이지(startPage)값이 1보다 큰 경우 true */
		this.prev = this.startPage > 1;

		/* 마지막 페이지(endPage)값이 1보다 큰 경우 true */
		this.next = this.endPage < realEnd;

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

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
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

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	

}
