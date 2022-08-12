package com.myboard.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myboard.model.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest{
	
	@Autowired
	private BoardService service;
	
	@Test
	public void boarden() {

		BoardVO bvo = new BoardVO();
		
		bvo.setTitle("서비스 제목");
		bvo.setContent("서비스 내용");
		bvo.setWriter("서비스 작성자");
		
		service.boardEnroll(bvo);
		
	}
	
}
