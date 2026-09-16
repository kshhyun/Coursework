package com.springboot.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class BoardController {
	
	@RequestMapping(value="/insertBoard.do")
	public String insertBoard() {
		
		System.out.println(" --> BoardController:insertBoard()");
		
		return "insertBoardView";
	}
	
}
