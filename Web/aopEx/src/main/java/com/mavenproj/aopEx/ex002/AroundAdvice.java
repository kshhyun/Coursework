package com.mavenproj.aopEx.ex002;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint;

import com.mavenproj.aopEx.hw.ThrowingAdvice;

public class AroundAdvice {
	public Object aroundAdvice (ProceedingJoinPoint pjp) throws Throwable {
		System.out.println("[AroundAdvice] 비즈니스 로직 전 수행");
		
		Object retObj = pjp.proceed();		
		System.out.println("[Around After] 비즈니스 로직 후 수행");
		
		return retObj;
	}
}
