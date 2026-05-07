package com.mavenproj.jobSite.model;

import java.util.HashMap;
import java.util.Map;

//Data Access Object -> 데이터 저장, 삭제, 수정, 찾기 등의 메소드를 갖고있는 클래
public class jobDao {
	//DB 연동 대신 HashMap을 이용해 데이터 관리	
	private Map<String, jobDo> jobDb = new HashMap<>();
	
	//insert() : 데이터 저장
	public void insert(jobDo jdo) {
		jobDb.put(jdo.getId(), jdo);
	}
	
	//getJob() : DB로부터 getJob 전체 데이터 가져옴
	public Map<String, jobDo> getJobDb() {
		return jobDb;
	}
	
	//delete()
}
