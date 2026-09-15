package com.mavenproj.aopEx.ex002;

import org.springframework.stereotype.Service;

@Service("logAdvice")
public class LogAdvice {
	public void printLog() { //printLog : 게시판의 어떤 기능을 실행하든 공통으로 출력하고 싶은 로그 메시지 정의
		System.out.println("[공통로그] 비즈니스 수행 전 동작 Before");
	}
	public void printLogModify() {
		System.out.println("[공통로그] 비즈니스 수행 후 동작 After");
	}
}
