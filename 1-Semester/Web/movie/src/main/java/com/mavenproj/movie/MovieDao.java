package com.mavenproj.movie;

import java.util.HashMap;
import java.util.Map;

public class MovieDao {
	// HashMap
    private Map<Integer, MovieDo> db = new HashMap<Integer, MovieDo>();

    // mdo 데이터 DB 저장
    public void insertMovie(MovieDo mdo) {
        System.out.println("-- insertMovie() 처리 !!");
        db.put(mdo.getMovieNum(), mdo);
        System.out.println("  -- insertMovie() 처리 완료 !! --");
    }

    // num에 해당되는 영화 정보
    // return 형 : MovieDO
    public MovieDo selectMovie(int num) {
        System.out.println("  -- selectMovie() 처리 !!");
        MovieDo mdo = db.get(num);
        System.out.println("-- 데이터베이스 처리 완료(selectMovie()) --");
        return mdo;
    }
}
