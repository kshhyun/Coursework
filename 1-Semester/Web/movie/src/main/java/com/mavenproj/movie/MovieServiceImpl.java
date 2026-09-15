package com.mavenproj.movie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("movieService")
public class MovieServiceImpl implements MovieService {

    @Autowired
    private MovieDao movieDao;

    // mdo -> HashMap 저장
    @Override
    public void insertMovie(MovieDo mdo) {
        movieDao.insertMovie(mdo);
    }

    // HashMap -> MovieDo 리턴
    @Override
    public MovieDo selectMovie(int num) {
        return movieDao.selectMovie(num);
    }

    // 나이 예외 처리
    @Override
    public void playMovie(MovieDo mdo, int Age) {
        if (Age >= mdo.getGrade()) {
            System.out.println("영화 재생중입니다...");
        } else {
            System.out.println(Age + "세는 이 영화를 볼 수 없습니다.");
            throw new IllegalArgumentException("해당 영화는 등급연령보다 작으면 영화를 시청할 수 없습니다.");
        }
    }
}
