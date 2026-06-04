package com.mavenproj.aopEx.ex002;

public class AfterAdvice {
	
	//method 하나를 받음
	public void afterAdvice() {
		System.out.println("[AfterAdvice] 비즈니스로직 수행 후 반드시 실행 됨!!");
	}

}
