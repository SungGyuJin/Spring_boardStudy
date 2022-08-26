package com.myboard.model;

public class Criteria {

	private int pageNum;	// 현재페이지
	
	private int amount;		// 한 페이지당 보여질 데이터 갯수
	
	private int limitValue;	// limit 첫 번째 값, 세팅
	
	// 초기 페이지 세팅
	public Criteria() {
		this.pageNum = 1;
		this.amount = 10;
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.limitValue = (pageNum - 1) * amount;
	}
	
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.limitValue = (pageNum - 1) * amount;
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		if(amount < 10) {
			amount = 10;
		}
		this.limitValue = (pageNum - 1) * amount;
		this.amount = amount;
	}

	public int getLimitValue() {
		return limitValue;
	}

	public void setLimitValue(int limitValue) {
		this.limitValue = limitValue;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", limitValue=" + limitValue + "]";
	}
	
	
}
