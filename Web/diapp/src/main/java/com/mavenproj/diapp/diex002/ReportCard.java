package com.mavenproj.diapp.diex002;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

//<bean id="rCard" class="com.mavenproj.diapp.diex001.ReportCard">
//	<property name="calc" ref="avgCalc" />
//	<property name="score" ref="student1" />
//</bean>

@Component("rCard")
public class ReportCard {
	@Autowired
	@Qualifier("avgCalc") //weightedCalc도 있어서 에러 발생 -> avgCalc로 지정하면 에러 없이 실행 됨 
	private ScoreCalculator calc;
	@Autowired
	@Qualifier("student3")
	private StudentScore score;
	
	//생성자 이용하여 주입
	public ReportCard() {	
		
	}		
	
	//생성자 이용하여 주입
	public ReportCard(ScoreCalculator calc, StudentScore score) {		
		this.calc = calc;
		this.score = score;
	}
	//셋터 이용하여 주입
	public void setCalc(ScoreCalculator calc) {
		this.calc = calc;
	}
	public void setScore(StudentScore score) {
		this.score = score;
	}	
	//평균 출력 메소드 생성
	public void printReport() {
		System.out.println("===== 성적표 ======");
		System.out.println(score.toString());
		
		System.out.println("계산방식 : " + calc.getCalcMethod());
		
		double result = calc.calculate(score);	
		System.out.println("평균: " + result);
	}
	
	
	

}
