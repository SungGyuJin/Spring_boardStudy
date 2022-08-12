package com.myboard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myboard.mapper.BoardMapper;
import com.myboard.model.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;

	@Override
	public void boardEnroll(BoardVO board) {
		
		mapper.boardEnroll(board);
	}
	
}
