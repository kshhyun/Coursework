package com.mavenproj.diapp.diex002;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

//<bean id="student1" class="com.mavenproj.diapp.diex001.StudentScore">
//	<property name="korScore" value="850" />
//	<property name="engScore" value="900" />   
//	<property name="mathScore" value="1000" />      
//</bean>
//컴포넌트 괄호 안에 빈칸 채우기 or 위 코드를 아래 코드로 혹은 아래 코드를 위 코드로 변환해 작성하는 문제 출제


//@Component("student1") --> xml로 객체설정을 하기 때문에, 여기서는 주석 처리 
public class StudentScore {
	//@Value("852")
	private int korScore;
	//@Value("910")
	private int engScore;
	//@Value("1100")
	private int mathScore;
	
	//생성자 이용하여 멤버변수값 설정
	public StudentScore() {
		
	}
		
	
	//생성자 이용하여 멤버변수값 설정
	public StudentScore(int korScore, int engScore, int mathScore) {
		super();
		this.korScore = korScore;
		this.engScore = engScore;
		this.mathScore = mathScore;
	}

	//셋터를 이용하여 멤버변수의 값을 설정. 
	//겟터를 이용하여 멤버변수의 값을 가져올수 있음
	public int getKorScore() {
		return korScore;
	}

	public void setKorScore(int korScore) {
		this.korScore = korScore;
	}

	public int getEngScore() {
		return engScore;
	}

	public void setEngScore(int engScore) {
		this.engScore = engScore;
	}

	public int getMathScore() {
		return mathScore;
	}

	public void setMathScore(int mathScore) {
		this.mathScore = mathScore;
	}
	
	//전체 멤버변수의 값을 한방에 출력하는 메소드 -> toString()
	@Override
	public String toString() {
		return "StudentScore [korScore=" + korScore + ", engScore=" + engScore + ", mathScore=" + mathScore + "]";
	}
	
	

}
