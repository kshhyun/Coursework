package com.mavenproj.diapp.diex001;

public interface ScoreCalculator {
	//학생의 국영수 점수를 받아서 산술또는 가중치 산술 평균 계산하는 메소드 선언.. 
	double calculate(StudentScore score);
	//계산 방식 출력
	String getCalcMethod();
	
}
