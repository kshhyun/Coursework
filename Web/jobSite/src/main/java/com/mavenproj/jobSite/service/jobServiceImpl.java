package com.mavenproj.jobSite.service;

import java.util.Map;

import com.mavenproj.jobSite.model.jobDao;
import com.mavenproj.jobSite.model.jobDo;

public class jobServiceImpl implements jobService{
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

	

}
