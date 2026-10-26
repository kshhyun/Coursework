package com.springboot.webapp.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.webapp.model.BoardDao;
import com.springboot.webapp.model.BoardDo;

import org.springframework.ui.Model;


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
	//public String getBoardList(BoardDao bdao, ModelAndView mav) {
	public ModelAndView getBoardList(BoardDo bdo, BoardDao bdao, ModelAndView mav) {
		System.out.println(" --> getBoardList()");
		
		ArrayList<BoardDo> bList = bdao.getBoardList();
		mav.addObject("bData", bList); //뷰어에게 bData 이름으로 bList 데이터 전달
		mav.setViewName("getBoardListView"); //뷰어 호출
		
		//return "getBoardListView";
		return mav;
	}
	
	@RequestMapping(value="/modifyBoard.do")
	public ModelAndView modifyBoard(BoardDo bdo, BoardDao bdao, ModelAndView mav) {
		System.out.println("modifyBoard() --> ");
		System.out.println("seq: " + bdo.getSeq());
		
		BoardDo board = bdao.getOneBoard(bdo);
		System.out.println("board.content() : " + board.getContent());
		
		mav.addObject("board", board);
		mav.setViewName("modifyBoardView");
		
		return mav;
	}
	
	@RequestMapping(value="/modifyProcBoard.do")
	public ModelAndView modifyProcBoard(BoardDo bdo, BoardDao bdao, ModelAndView mav) {
		System.out.println("modifyProcBoard() --> ");
		System.out.println("seq: " + bdo.getSeq() + " ,title: " + bdo.getTitle()
		+ " ,content: " + bdo.getContent());
		
		//Dao 이용해 수정 데이터를 DB에 저장.. --> updateBoard(bdo)
		bdao.updateBoard(bdo);
		mav.setViewName("redirect:getBoardList.do");
		
		return mav;
	}
	
	@RequestMapping(value = "/deleteBoard.do")
	public ModelAndView deleteBoard(BoardDo bdo, BoardDao bdao, ModelAndView mav) {
		System.out.println("deleteBoard() --> ");
		System.out.println("seq: " + bdo.getSeq());
		
		//Dao 이용해 수정 데이터를 DB에 저장.. --> updateBoard(bdo)
		bdao.deleteBoard(bdo);
		mav.setViewName("redirect:getBoardList.do");
		
		return mav;
	}
	
	@RequestMapping(value = "/searchBoardList.do")
	public String searhchBoardList(
			@RequestParam(value = "searchCon") String searchCon,
			@RequestParam(value = "searchKey") String searchKey,
			BoardDao bdao, Model model) {
		
		System.out.println("searchBoard() --> ");
		System.out.println("searchCon: " + searchCon + ", searchKey: " + searchKey);
		
		ArrayList<BoardDo> bList = bdao.searchBoardList(searchCon, searchKey);
		model.addAttribute("bData", bList);
		
		return "getBoardListView";
	}
	
	@RequestMapping(value="/jstlex")
 	public String jstlEx() {
		
		//http://localhost:8080/jstles --> jstles.jsp 연결..
		return "jstl";
	}
	
	
	
	
}
