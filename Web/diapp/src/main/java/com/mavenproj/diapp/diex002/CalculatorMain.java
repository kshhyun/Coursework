package com.mavenproj.diapp.diex002;

public class CalculatorMain {
	public static void main(String[] args) {
		//학생점수 설정 및 출력
		StudentScore student1 = new StudentScore(85,90, 100);
		System.out.println(student1.toString());
		
		//1. 단순 산술 평균 계산
		ScoreCalculator avgCalc = new AverageCalculator(); //객체 생성
		//avgCalc와 student1 객체 ReportCard 주입(생성자 이용하여 주입)
		ReportCard rCard = new ReportCard(avgCalc, student1); 
		rCard.printReport();
		
		//2. 가중치 산술 평균 계산
		ScoreCalculator weightedCalc = new WeightedAvgCalculator(0.3, 0.3,0.4);
		//셋터이용 객체 설정
		rCard.setCalc(weightedCalc);
		//학생 점수는 위의 설정되어 있는 값을 활용
		rCard.printReport(); 
	
		
		
		
		
	}

}
