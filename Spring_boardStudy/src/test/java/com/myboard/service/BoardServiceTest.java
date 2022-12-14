package com.myboard.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myboard.model.BoardVO;
import com.myboard.model.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest{
	
	@Autowired
	private BoardService service;
	
//	@Test
//	public void serviceBoardEnroll() {
//
//		BoardVO bvo = new BoardVO();
//		
//		bvo.setTitle("서비스 제목");
//		bvo.setContent("서비스 내용");
//		bvo.setWriter("서비스 작성자");
//		
//		service.boardEnroll(bvo);
//		
//	}
	
	
//	@Test
//	public void serviceBoardList(){
//		
//		service.boardList();
//		
//		service.boardList().forEach(board -> log.info("" + board));
//		
//	}
	
//	@Test
//	public void detailLIst() {
//		
//		int bno = 2;
//		
//		log.info("상세리스트: " + service.boardDetailList(bno));
//	}
	
//	@Test
//	public void serviceModify() {
//		
//		BoardVO bvo = new BoardVO();
//
//		bvo.setBno(1);
//		bvo.setTitle("service 수정제목");
//		bvo.setContent("service 수정내용");
//		bvo.setWriter("service 수정글쓴");
//		
//		service.boardModify(bvo);
//		
//	}
	
//	@Test
//	public void delete() {
//		int bno = 3;
//		
//		service.boardDelete(bno);
//	}
	
	
//	@Test
//	public void total() {
//		
//		service.listTotal();
//	}
	
	@Test
	public void testListPage() {
		
		Criteria cri = new Criteria();
		
		List list = service.boardListPage(cri);
		
		list.forEach(board -> log.info("" + board));
		
		System.out.println("Service Tests");
	}
}