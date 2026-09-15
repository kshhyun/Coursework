package com.mavenproj.diapp.diex001;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class CalculatorMainXml {
	public static void main(String[] args) {
		//학생점수 설정 및 출력 -->xml 기반 지시서로 대체 코드 작성 했음
		//StudentScore student1 = new StudentScore(85,90, 100);
		
		ApplicationContext context = new ClassPathXmlApplicationContext("calcSettings.xml");
		//StudentScore student1 = (StudentScore) context.getBean(StudentScore.class);
		StudentScore student5 = (StudentScore) context.getBean("student5");
		
		// 생성자 이용 객체 초기치 설정에서, index 이용 값 설정 결과 확인 		
		System.out.println(student5.toString());
		
		//1. 단순 산술 평균 계산
		//ScoreCalculator avgCalc = new AverageCalculator(); //객체 생성
		ScoreCalculator avgCalc = (ScoreCalculator) context.getBean("avgCalc");
		
		//avgCalc와 student1 객체 ReportCard 주입(생성자 이용하여 주입)
		//ReportCard rCard = new ReportCard(avgCalc, student1);
		ReportCard rCard = (ReportCard) context.getBean("rCard");
		rCard.printReport();
		
		//2. 가중치 산술 평균 계산
		//ScoreCalculator weightedCalc = new WeightedAvgCalculator(0.3, 0.3,0.4);
		//xml로부터 생성된 weightedCalc 객체를 가져와서 weightedCalc 객체 변수에 저장
		ScoreCalculator weightedCalc = (ScoreCalculator)context.getBean("weightedCalc");
		
		//셋터이용 객체 설정
		//rCard.setCalc(weightedCalc);
		ReportCard rCardWeight = (ReportCard) context.getBean("rCardWeight");
		
		//학생 점수는 위의 설정되어 있는 값을 활용
		rCard.printReport(); 
	
	
		
		
		
	}

}
