package com.mavenproj.aopEx.hw;

public class ThrowingAdvice {
	public void throwingAdvice(Exception ex) {
		System.out.println("[Throwing Advice] 에러 발생시에 동작 -> 에러 메세지 : "
				+ ex.getMessage());
	}
}
