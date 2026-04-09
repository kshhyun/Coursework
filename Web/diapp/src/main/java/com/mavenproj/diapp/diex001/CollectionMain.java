package com.mavenproj.diapp.diex001;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class CollectionMain {
	public static void main(String[] args) {
		
//		아래 코드는 xml 에서 진행
//		StudentScore sScore = new StudentScore(800,900,1000);
//		
//		ArrayList<StudentScore> studentScores = new ArrayList<>();
//		studentScores.add(new StudentScore (80,90,100));
//		studentScores.add(sScore);
		
	//xml 설정을 이용해 실제 객체 생성 및 조합
		ApplicationContext context = new ClassPathXmlApplicationContext("collectionSettings.xml");
		
		ArrayList<StudentScore> studentScores = 
				(ArrayList<StudentScore>) context.getBean("studentScores");
		
		for(StudentScore student : studentScores ) {
			System.out.println("-->" + student.toString());
		}
		
		System.out.println("----------------------------------------------");
//		Map<String, String> addrList = new HashMap<>();
//		addrList.put("hong1", "서울시 성동구 행정동");
//		addrList.put("hong2", "서울시 성동구 사동");
		
		CollectionMap cMap = (CollectionMap) context.getBean("collectionMap");
		Map<String, String> addrList = cMap.getAddrList();
		
		for(Map.Entry<String, String> address: addrList.entrySet()) {
			System.out.println("name : " + address.getKey() + " , address : " + address.getValue());
		}
		
		System.out.println("----------------------------------------------");
		//collectionSettings.xml에서 해줌
//		Set<String> jobList = new HashSet<>();
//		jobList.add("프론트 엔지니어");
//		jobList.add("백엔 엔지니어");
//		jobList.add("프론트 엔지니어");
		
		CollectionSet cSet = (CollectionSet) context.getBean("collectionSet");
		Set<String> jobList = cSet.getJobList();
				
		for(String job: jobList) {
			System.out.println("job :" + job);
		}
	}
}
