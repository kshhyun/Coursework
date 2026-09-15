package com.mavenproj.aopEx.ex002;

public class BoardDo {
	private int seq; //주키
	private String title;
	private String writer;
	private String content;
	
	//Generate toString()
	@Override
	public String toString() {
		return "BoardDo [seq=" + seq + ", title=" + title + ", writer=" + writer + ", content=" + content + "]";
	}
	//Generate Getters and Setters
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
