package com.mavenproj.diapp.diex002;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

//<context:component-scan base-package="com.mavenproj.diapp.diex002" /> 아래 코드처럼 구현 가능
@ComponentScan("com.mavenproj.diapp.diex002")
@Configuration // @ 기반 지시서 생성
public class ProgramConfig {
	
//	<bean id="student1" class="com.mavenproj.diapp.diex002.StudentScore">
//	<property name="korScore" value="850" />
//	<property name="engScore" value="900" />   
//	<property name="mathScore" value="1000" />
	@Bean
	public StudentScore sutdent1() {
		return new StudentScore(850, 900, 1000);
	}
//	<bean id="student3" class="com.mavenproj.diapp.diex002.StudentScore">
//		<constructor-arg value="85"/>
//		<constructor-arg value="90"/>
//		<constructor-arg value="100"/>
//	</bean>	
	@Bean
	public StudentScore sutdent3() {
		return new StudentScore(85, 90, 100);
	}
	
//	<bean id="avgCalc" class="com.mavenproj.diapp.diex001.AverageCalculator" />
	@Bean
	public AverageCalculator avgCalc() {
		return new AverageCalculator();	
	}
	
//	<bean id="rCard" class="com.mavenproj.diapp.diex002.ReportCard">
	//	<property name="calc" ref="avgCalc" />
	//	<property name="score" ref="student1" />
//	</bean>
	@Bean
	public ReportCard rCard() {
		//avgCalc, student1 객체의 주입에 대한 구현은 @Autowired를 이용하려 구현이 되기 때문에
		//여기서는 구현 코드가 필요 없음
		return new ReportCard();
	}
}
