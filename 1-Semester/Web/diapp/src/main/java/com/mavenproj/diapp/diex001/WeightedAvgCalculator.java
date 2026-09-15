package com.mavenproj.diapp.diex001;

public class WeightedAvgCalculator implements ScoreCalculator{
	private double korWeight;
	private double engWeight;
	private double mathWeight;
	
	//인자가 없는 디폴트 생성자 설정
	public WeightedAvgCalculator() {

	}
	
	//생성자를 이용하여 가중치 설정
		public WeightedAvgCalculator(double korWeight, double engWeight, double mathWeight) {
			this.korWeight = korWeight;
			this.engWeight = engWeight;
			this.mathWeight = mathWeight;
		}

	
	@Override
	public double calculate(StudentScore score) {
		double weightedAvg = (score.getKorScore()*korWeight + 
							  score.getEngScore()*engWeight +
							  score.getMathScore()*mathWeight);
		 
		return weightedAvg;
	}


	@Override
	public String getCalcMethod() {
		return "가중치 산술 평균";
	}
	
	//xml에서 property 태그를 실행하기 위해서는 setter() 메소드가 필요
	//Source -> Generate Getters and Setters
	public double getKorWeight() {
		return korWeight;
	}

	public void setKorWeight(double korWeight) {
		this.korWeight = korWeight;
	}

	public double getEngWeight() {
		return engWeight;
	}

	public void setEngWeight(double engWeight) {
		this.engWeight = engWeight;
	}

	public double getMathWeight() {
		return mathWeight;
	}

	public void setMathWeight(double mathWeight) {
		this.mathWeight = mathWeight;
	}

	
}
