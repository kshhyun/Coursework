package com.mavenproj.jobSite.model;

//DataObject 
public class jobDo {
	private String id;       //primary key
	private String cname;    //회사
	private String cpayment; //연봉
	private String cfields;  //직무분야
	
	@Override
	public String toString() {
		return "jobDao [id=" + id + ", cname=" + cname + ", cpayment=" + cpayment + ", cfields=" + cfields + "]";
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCpayment() {
		return cpayment;
	}
	public void setCpayment(String cpayment) {
		this.cpayment = cpayment;
	}
	public String getCfields() {
		return cfields;
	}
	public void setCfields(String cfields) {
		this.cfields = cfields;
	}
}
