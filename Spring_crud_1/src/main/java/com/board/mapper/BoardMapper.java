package com.board.mapper;

import java.util.List;

import com.board.model.BoardVO;

public interface BoardMapper {

	
	// 게시판 등록
	public void regBoard(BoardVO bvo);
	
	// 게시판 조회
	public List<BoardVO> listBoard();
	
	// 게시판 상세조회
	public BoardVO detailBoard(int bno);
	
	// 게시판 수정
	public void modifyBoard(BoardVO bvo);
	
	// 게시판 삭제
	public void deleteBoard(int bno);
	
}
