package com.mavenproj.diapp.couplingEx;

//약결합 구현..
//공통기능 인터페이스 구현
interface MessageService {
	void sendMessage(String message, String recipient);
}

//인터페이스 적용 EmailService 구현 
class EmailServiceLoose implements MessageService{
	@Override
	public void sendMessage(String message, String recipient) {
		System.out.println("이메일 전송 : " + message + " to " + recipient);		
	}	
}

//인터페이스 적용 SnsService 구현
class SnsServiceLoose implements MessageService{
	@Override
	public void sendMessage(String message, String recipient) {
		System.out.println("이메일 전송 : " + message + " to " + recipient);		
	}	
}

public class LooseCouplingEx {
	public static void main(String[] args) {
		//MessageService mservice = new EmailServiceLoose();
		MessageService mservice = new SnsServiceLoose();
		mservice.sendMessage("중요 공지사항", "전체 학생");
	}
}
