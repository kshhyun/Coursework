package com.mavenproj.jobSite.service;

import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.mavenproj.jobSite.model.jobDo;

public class jobMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//xml 지시서를 해석해 객체 생성
		ApplicationContext context = new ClassPathXmlApplicationContext("jobSettings.xml");
		
		//jobService 객체 가져오기
		jobService jService = (jobService) context.getBean("jobService");
		
		//001 데이터 저장
		jobDo jdo = (jobDo)context.getBean("job001");
		jService.insertJob(jdo);
		//002 데이터 저장
		jdo = (jobDo)context.getBean("job002");
		jService.insertJob(jdo);
		
		//출력
		Map<String, jobDo> jList = jService.getJobDb();
		for(Map.Entry<String, jobDo> job:jList.entrySet()) {
			jobDo temp = job.getValue()	;
			System.out.println("Origin ->" + temp.toString());
		}
		
		//하나의 데이터(채용정보) 가져오기
		System.out.println("\n[job002의 데이터 가져오기]");
		jobDo temp = jService.getJob("job002");
		System.out.println("-> 한개의 데이터 읽어오기 : " + temp.toString());
		
		//job001 -> '현대'로 업데이트
		System.out.println("\n[데이터 업데이트: job001의 cname, dfields 수정]");
		jobDo newjob = new jobDo();
		newjob.setId("job001");
		newjob.setCname("현대");
		newjob.setCpayment("5000");
		newjob.setCfields("FullStack Engineer");
		
		//수정한 데이터 업데이트 -> 이 코드 안 쓰면 업데이트 전 데이터로 출력됨
		jService.updateJob(newjob);
		
		//업데이트 후 출력
		Map<String, jobDo> jList2 = jService.getJobDb();
		for(Map.Entry<String, jobDo> job:jList2.entrySet()) {
			jobDo temp2 = job.getValue()	;
			System.out.println("-> 수정한 데이터 가져오기 : " + temp2.toString());
		}
		
		//job001 -> 삭제
		System.out.println("\n[데이터 삭제: job001 삭제]");
		//jobDo newjob = new jobDo();
		newjob.setId("job001");
		jService.deleteJob(newjob);
		
		//삭제 후 출력
		Map<String, jobDo> jList3 = jService.getJobDb();
		for(Map.Entry<String, jobDo> job:jList3.entrySet()) {
			jobDo temp3 = job.getValue()	;
			System.out.println("-> 삭제한 데이터 가져오기 : " + temp3.toString());
		}
		
	}

}
