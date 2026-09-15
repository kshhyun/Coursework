package com.mavenproj.jobSite.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mavenproj.jobSite.model.jobDao;
import com.mavenproj.jobSite.model.jobDo;
//<bean id="jobService" class="com.mavenproj.jobSite.service.jobServiceImpl">
//<constructor-arg ref="jobDao"></constructor-arg>  --> Autowired랑 같은???
//</bean>

@Service("jobService")
public class jobServiceImpl implements jobService{
	
	@Autowired
	private jobDao jdao;
	
	public jobServiceImpl(jobDao jdao) {
		super();
		this.jdao = jdao;
	}
	
	@Override
	public void insertJob(jobDo jdo) {
		jdao.insert(jdo);
	}

	@Override
	public Map<String, jobDo> getJobDb() {
		// TODO Auto-generated method stub
		return jdao.getJobDb();
	}

	@Override
	public jobDo getJob(String id) {
		// TODO Auto-generated method stub
		return jdao.selectJob(id);
	}

	@Override
	public void updateJob(jobDo jdo) {
		// TODO Auto-generated method stub
		jdao.update(jdo);
		
	}

	@Override
	public void deleteJob(jobDo jdo) {
		// TODO Auto-generated method stub
		jdao.deleteJob(jdo);
		
	}
	
	
	

}
