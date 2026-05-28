package com.mavenproj.aopEx.hw;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class CalcMain {

	public static void main(String[] args) {
		//1.설정파일(지시서)를 읽어와, 실행해서 결과(객체)를 만드는 과정
		ApplicationContext context = 
				new ClassPathXmlApplicationContext("aopCalcSettings.xml");
		//서비스 객체 가져오기
		ICalc calcService = (ICalc) context.getBean("calcImpl");
		
		calcService.doAdd(10, 20);
		//나눗셈에서 에러 발생
		calcService.doDiv(10, 0);
	}

}
