package com.myboard.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myboard.model.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {

	@Autowired
	private BoardMapper mapper;
	
//	@Test
//	public void testenroll() {
//		
//		BoardVO bvo = new BoardVO();
//		
//		bvo.setTitle("등록제목");
//		bvo.setContent("등록내용");
//		bvo.setWriter("등록글쓴이");
//		
//		mapper.boardEnroll(bvo);
//		
//	}
	
//	@Test
//	public void boardList() {
//		
//		List list = mapper.boardList();
//		
//		for(int i = 0; i < list.size(); i++) {
//			log.info("" + list.get(i));
//		}
//	}
	
//	@Test
//	public void detailList() {
//		
//		int bno = 1;
//		
//		mapper.boardDetailList(bno);
//	}
	
//	@Test
//	public void modify() {
//		
//		BoardVO bvo = new BoardVO();
//		
//		bvo.setBno(1);
//		bvo.setTitle("mapper 수정제목");
//		bvo.setContent("mapper 수정내용");
//		bvo.setWriter("mapper 수정글쓴");
//		
//		mapper.boardModify(bvo);
//		
//	}
	
//	@Test
//	public void delete() {
//		
//		int bno = 4;
//		
//		mapper.boardDelete(bno);
//	}
	
	@Test
	public void testListPage() {
		
		Criteria cri = new Criteria();
		
		List list = mapper.boardListPage(cri);
		
		list.forEach(board -> log.info("" + board));
		
		System.out.println("Mapper Tests");
	}
}