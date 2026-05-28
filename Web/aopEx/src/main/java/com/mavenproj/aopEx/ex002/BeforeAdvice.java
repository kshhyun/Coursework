package com.mavenproj.aopEx.ex002;

public class BeforeAdvice {
	public void beforeLog() {
		System.out.println("[BeforeAdvice] 비즈니스 로직 수행 전에 동작");
	}
}
