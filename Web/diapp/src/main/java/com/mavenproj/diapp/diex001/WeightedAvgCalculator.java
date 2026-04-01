package com.mavenproj.diapp.diex001;

public class WeightedAvgCalculator implements ScoreCalculator{
	private double korWeight;
	private double engWeight;
	private double mathWeight;
	
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

	
}
