package com.mavenproj.movie;

public class SelectedMovieAdvice {

    public void selectedMovieAdvice(Object result) {
        MovieDo mdo = (MovieDo) result;
        System.out.println("[adviceSelectedMovie] 선택된 영화 이름은 [" + mdo.getMovieName() + "] 입니다.");
    }
}
