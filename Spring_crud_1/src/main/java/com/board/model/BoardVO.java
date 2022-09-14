package com.board.model;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardVO {

	private int bno;
	
	private String title;
	
	private String content;
	
	private String writer;
	
	private Date regDate;
	
	private Date updateDate;
}
