package com.springboot.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springboot.webapp.model.BoardDao;
import com.springboot.webapp.model.BoardDo;


@Controller
public class BoardController {
	
	@RequestMapping(value="/insertBoard.do")
	public String insertBoard() {
		
		System.out.println(" --> BoardController:insertBoard()");
		
		return "insertBoardView";
	}
	
	@RequestMapping(value = "/insertProcBoard.do")
	public String insetProcBoard(BoardDo bdo) {
		System.out.println(" --> BoardController:insertProcBoard()");
		
		// dao 이용해서 전달된 데이터를 DB에 저장하는 코드
		System.out.println("title: " + bdo.getTitle());
		System.out.println("writer: " + bdo.getWriter());
		System.out.println("content: " + bdo.getContent());
		
		//Dao를 이용해 bdo에 저장되어있는 데이터를 DB에 저장
		BoardDao bdao = new BoardDao();
		bdao.insertBoard(bdo);
		
		//redirect가 붙으면, 단순히 뷰리볼버에 의해 뷰어를 호출하는 것이 X
		//getBoardList.do의 requestMapping의 value(url 호출)을 찾아감
		return "redirect:getBoardList.do";
	}
	
	@RequestMapping(value="/getBoardList.do")
	public String getBoardList() {
		System.out.println(" --> getBoardList()");
		
		return "getBoardListView";
	}
	
	@RequestMapping(value="/jstlex")
	public String jstlEx() {
		
		//http://localhost:8080/jstles --> jstles.jsp 연결..
		return "jstl";
	}
	
	
	
	
	
}
