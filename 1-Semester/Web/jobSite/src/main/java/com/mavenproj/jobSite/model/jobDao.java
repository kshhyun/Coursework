package com.mavenproj.jobSite.model;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//Data Access Object -> 데이터 저장, 삭제, 수정, 찾기 등의 메소드를 갖고있는 클래스
//<bean id="jobDao" class="com.mavenproj.jobSite.model.jobDao">
//</bean>
//@Component("jDao") 아래와 같이 사용 가능 
@Repository("jDao")
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
	
	//getJob(id) : 하나의 데이터 가져오기
	//Dao에서 만들었으면 jobService + jobServiceImpl 에도 추가해주기
	public jobDo selectJob(String id) {
		if(jobDb.containsKey(id)) {
			return jobDb.get(id);
		}
		else {
			System.out.println("해당 ID의 채용정보는 없습니다." + id);
		}
		return null;
	}
	
	//updateJob(jobDo jdo) : 새로운 jdo로 기존 데이터 업데이트하기
	public void update(jobDo jdo) {
		if(jobDb.containsKey(jdo.getId())) {
			jobDb.put(jdo.getId(), jdo);
		}
		else {
			System.out.println("업데이터할 ID가 존재하지 않습니다." + jdo.getId());
		}
	}
	
	//delete() : ID 삭제
	public void deleteJob(jobDo jdo) {
		if(jobDb.containsKey(jdo.getId())) {
			jobDb.remove(jdo.getId(), jdo);
		}
		else {
			System.out.println("삭제할 ID가 없습니다." + jdo.getId());
		}
	}
}
