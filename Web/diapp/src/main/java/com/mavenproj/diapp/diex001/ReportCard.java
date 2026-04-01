package com.mavenproj.diapp.diex001;

public class ReportCard {
	private ScoreCalculator calc;
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
