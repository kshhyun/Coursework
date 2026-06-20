package com.mavenproj.movie;

import org.aspectj.lang.JoinPoint;

public class AgeCheckAdvice {
	
    public void ageCheckAdvice(JoinPoint jp, Exception ex) {
        Object[] args = jp.getArgs();
        // args[1] : int Age (playMovie의 두 번째 인자)
        int age = (int) args[1];
        System.out.println("[adviceAgeViolation] 비즈니스 메소드 시의 예외 사항 : " + ex.getMessage());
    }
}
