package com.myboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.mapper.BoardMapper;
import com.myboard.model.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	
	// 게시판 등록페이지
	@Override
	public void boardEnroll(BoardVO board) {
		
		mapper.boardEnroll(board);
	}

	// 게시판 목록페이지
	@Override
	public List<BoardVO> boardList() {

		return mapper.boardList();
	}
	
}
