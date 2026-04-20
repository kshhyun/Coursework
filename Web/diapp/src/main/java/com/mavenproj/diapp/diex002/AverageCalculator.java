package com.mavenproj.diapp.diex002;

import org.springframework.stereotype.Component;

//<bean id="avgCalc" class="com.mavenproj.diapp.diex001.AverageCalculator" />

@Component("avgCalc")
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
