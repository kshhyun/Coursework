package com.springboot.webapp.model;

public class BoardDo {
	//member 변수
	private int seq;        //글 순서
	private String title;   //제목
	private String writer;  //작성자
	private String content; //내용
	
	
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
	
	//member 변수에 저장되어 있는 값 확인하기 위한 메소드: toString()
	//source -> generate toString
	@Override
	public String toString() {
		return "BoardDo [seq=" + seq + ", title=" + title + ", writer=" + writer + ", content=" + content + "]";
	}
	
	
}
