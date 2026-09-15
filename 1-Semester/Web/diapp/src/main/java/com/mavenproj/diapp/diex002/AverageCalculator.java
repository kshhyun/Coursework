package com.mavenproj.diapp.diex002;

import org.springframework.stereotype.Component;

//<bean id="avgCalc" class="com.mavenproj.diapp.diex001.AverageCalculator" />

//@Component("avgCalc") ->ProgramConfig.class에 객체 생성했기 때문에 중복 생성되어림 -> 주석처리
public class AverageCalculator implements ScoreCalculator{
	
	@Override
	public double calculate(StudentScore score) {
		int total = (score.getKorScore() + 
					 score.getEngScore() +
					 score.getMathScore());
		
		return (double)total/3;
	}

	@Override
	public String getCalcMethod() {		
		return "산술평균";
	}
	

	
}
