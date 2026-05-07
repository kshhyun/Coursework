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
			System.out.println("-->" + temp.toString());
		}
	}

}
