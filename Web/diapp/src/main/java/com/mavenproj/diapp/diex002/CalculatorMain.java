package com.mavenproj.diapp.diex002;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class CalculatorMain {
	public static void main(String[] args) {
		
		//xml 지시서(설정파일)을 이용해 실제객체 생성 or 조립 실행 
		ApplicationContext context = new ClassPathXmlApplicationContext("calcSettingsXmlAno.xml");
		
		//학생점수 설정 및 출력
		//StudentScore student1 = new StudentScore(85,90, 100);
		// 컨테이너에서 "student"라는 이름의 빈을 찾아 가져옴 -> 위 코드를 아래 코드로 수정
		StudentScore student1 = (StudentScore) context.getBean("student1");
		System.out.println(student1.toString());
		
		//1. 단순 산술 평균 계산
		//ScoreCalculator avgCalc = new AverageCalculator(); //객체 생성
		//ScoreCalculator avgCalc = (ScoreCalculator) context.getBean("avgCalc");
		
		//avgCalc와 student1 객체 ReportCard 주입(생성자 이용하여 주입)
		//ReportCard rCard = new ReportCard(avgCalc, student1);
		ReportCard rCard = (ReportCard) context.getBean("rCard");
		rCard.printReport();
	
		
		
		
		
	}

}
