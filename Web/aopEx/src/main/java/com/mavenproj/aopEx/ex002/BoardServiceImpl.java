package com.mavenproj.aopEx.ex002;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	//로그를 출력하기 위한 LogAdvice 객체 연결(@Autowired 이용)
	@Autowired
	private LogAdvice log;
	
	@Override
	public void insertBoard() {
		//log.printLog();
		System.out.println("[핵심기능] insertBoard() 동작 수행");
		//log.printLogModify();
	}

	@Override
	public void updateBoard() {
		//log.printLog();
		System.out.println("[핵심기능] updateBoard() 동작 수행");
		//log.printLogModify();
	}

	@Override
	public String deleteBoard() {
		//log.printLog();
		System.out.println("[핵심기능] deleteBoard() 동작 수행");
		//log.printLogModify();
		
		return "Hello Spring AOP";
	}
	
	
}
