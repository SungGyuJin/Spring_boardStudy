package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.mapper.BoardMapper;
import com.board.model.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper bMapper;
	

	@Override
	public List<BoardVO> listBoard() {
		return bMapper.listBoard();
	}


	@Override
	public BoardVO detailBoard(int bno) {
		return bMapper.detailBoard(bno);
	}


	@Override
	public void regBoard(BoardVO bvo) {
		bMapper.regBoard(bvo);
	}



	
	
}
