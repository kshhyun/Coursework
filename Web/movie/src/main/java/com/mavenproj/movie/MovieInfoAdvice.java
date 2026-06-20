package com.mavenproj.movie;

import org.aspectj.lang.ProceedingJoinPoint;

public class MovieInfoAdvice {
	// playMovie() 영화 실행 전/후
    public Object movieInfoAdvice(ProceedingJoinPoint pjp) throws Throwable {
        System.out.println("[adviceMovieInfo]  영화를 시작합니다.");

        Object result = pjp.proceed();

        System.out.println("[adviceMovieInfo]  영화를 마칩니다.");
        return result;
    }
}
