package com.mavenproj.aopEx.ex002;

public class AfterReturningAdvice {
	public void afterReturningAdvice(Object result) {
		System.out.println("[AfterAdvice] 비즈니스 로직 실행 후 동작 -> 결과값" + result.toString());
	}
}
