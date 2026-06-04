package com.mavenproj.aopEx.ex002;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class BoardMain {

	public static void main(String[] args) {
		//1.설정파일(지시서)를 읽어와, 실행해서 결과(객체)를 만드는 과정
		ApplicationContext context = new ClassPathXmlApplicationContext("aopSettingsXml2.xml");
		
		//2.BoardService 객체 가져오기 -> (BoardService) context 왜 붙이는지 찾아보
		BoardService bService = (BoardService) context.getBean("boardService");
		
		//3.가져온 객체 실행
		bService.insertBoard();
		bService.updateBoard();
		bService.deleteBoard();
	}

}
