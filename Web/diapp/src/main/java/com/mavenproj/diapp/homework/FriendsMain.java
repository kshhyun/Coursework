package com.mavenproj.diapp.homework;

import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class FriendsMain {
	public static void main(String[] args) {
        // 1. XML 설정 파일을 읽어 컨테이너 생성
		ApplicationContext context = new ClassPathXmlApplicationContext("friendsSettings.xml");
        
        // 2. FriendsMap 빈 가져오기
        FriendsMap fMap = (FriendsMap) context.getBean("friendsMap");
        Map<String, String> friendsList = fMap.getFriendsInfo();
        
        // 3. 데이터 출력 (실습 코드의 Map 출력 방식 참고)
        System.out.println("========== 카카오 프렌즈 리스트 ==========");
        for(Map.Entry<String, String> entry : friendsList.entrySet()) {
            System.out.println(entry.getKey() + " : " + entry.getValue());
        }
        System.out.println("=====================================");
    }

}


