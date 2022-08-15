package com.myboard.mapper;

import java.util.List;

import com.myboard.model.BoardVO;

public interface BoardMapper {

	// 게시판 등록페이지
	public void boardEnroll(BoardVO board);
	
	// 게시판 목록페이지
	public List<BoardVO> boardList();
	
	// 상세목록기능
	public BoardVO boardDetailList(int bno);
	
	// 게시판 수정
	public int boardModify(BoardVO board);
	
}
