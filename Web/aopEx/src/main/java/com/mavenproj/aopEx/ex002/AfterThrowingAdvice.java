package com.mavenproj.aopEx.ex002;

public class AfterThrowingAdvice {
	
	public void afterThrowingAdvice(Exception ex) {
		System.out.println("[AfterThrowingAdvice] 비즈니스 로직 실행 중에 예외 처리 발생 시 동작! err Message"
	+ ex.getMessage());
	}

}
