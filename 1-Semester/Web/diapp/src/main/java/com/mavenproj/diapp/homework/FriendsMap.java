package com.mavenproj.diapp.homework;

import java.util.Map;

public class FriendsMap {
    // 멤버 변수 설정
    private Map<String, String> friendsInfo;

    // XML의 <property> 태그를 통해 주입받기 위한 Setter
    public void setFriendsInfo(Map<String, String> friendsInfo) {
        this.friendsInfo = friendsInfo;
    }

    // Getter
    public Map<String, String> getFriendsInfo() {
        return friendsInfo;
    }
}