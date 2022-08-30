package com.myboard.service;

import java.util.List;

import com.myboard.model.BoardVO;
import com.myboard.model.Criteria;

public interface BoardService {

	// 게시판 등록페이지
	public void boardEnroll(BoardVO board);
	
	// 게시판 목록페이지
	public List<BoardVO> boardList();
	
	// 상세목록기능
	public BoardVO boardDetailList(int bno);

	// 게시판 수정
	public int boardModify(BoardVO board);
	
	// 게시판 삭제
	public int boardDelete(int bno);
	
	// 페이징 처리
	public List<BoardVO> boardListPage(Criteria cri);

	// 게시글 총 갯수
	public int listTotal(Criteria cri);
	
}
