package com.mavenproj.diapp.diex001;

public class StudentScore {
	private int korScore;
	private int engScore;
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
