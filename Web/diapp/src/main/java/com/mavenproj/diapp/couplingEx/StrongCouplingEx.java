package com.mavenproj.diapp.couplingEx;

//강결한 예제...
//EmailService 클래스 구현 
class EmailService{
	public void sendEmail(String message, String recipient) {
		//이메일 전송
		System.out.println("이메일 전송 : " + message + " to " + recipient);		
	}	
}

//SnsService 클래스 구현 
class SnsService {
	public void sendSns(String message, String recipient) {
		System.out.println("SNS 전송 : " + message + " to " + recipient );
	}
}

public class StrongCouplingEx {
	public static void main(String[] args) {
		//EmailService 하는 경우
		//EmailService eservice = new EmailService();
		//eservice.sendEmail("중요 공지사항 " , "전체 학생");
		
		//SnsSercie 하는 경우 
		SnsService sservice = new SnsService();
		sservice.sendSns("중요 공지 사항" , "전체 학생");
	}

}
