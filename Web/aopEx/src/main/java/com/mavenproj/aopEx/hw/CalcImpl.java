package com.mavenproj.aopEx.hw;

import org.springframework.stereotype.Service;

@Service("calcImpl")
public class CalcImpl implements ICalc {
	@Override
	public int doAdd(int a, int b) {
		int value = a + b;
		return value;
	}
	
	@Override
	public int doDiv(int a, int b) {
		if ( b == 0) {
			throw new IllegalArgumentException("나눗셈은 0으로 나누면 에러입니다. @@");
		}
		
		int value = a / b;
		return value;
	}

}
