package com.mavenproj.jobSite.service;

import java.util.Map;

import com.mavenproj.jobSite.model.jobDo;

public interface jobService {
	
	//데이터 저장 메소드 정의
	void insertJob(jobDo jdo);	
	
	//전체 데이터 가져오기
	Map<String, jobDo> getJobDb();
	
	//하나의 채용정보 가져오기
	jobDo getJob(String id);
	
	//하나의 채용정보 update
	void updateJob(jobDo jdo);
	
	void deleteJob(jobDo jdo);
}
