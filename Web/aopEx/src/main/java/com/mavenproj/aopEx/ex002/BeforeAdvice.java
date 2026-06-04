package com.mavenproj.aopEx.ex002;

import org.aspectj.lang.JoinPoint;

public class BeforeAdvice {
	public void beforeLog() {
		System.out.println("[BeforeAdvice] 비즈니스 로직 수행 전에 동작");
	}
	
	public void beforeAdviceJp (JoinPoint jp) {
		String method = jp.getSignature().getName(); //포인트컷의 이름을 가져옴
		Object[] args = jp.getArgs();
		
		System.out.println("[BeforeAdvice using JP] method : " + method + " ,args : " + args[0].toString());
	}
}
