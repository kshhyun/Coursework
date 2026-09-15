package com.mavenproj.movie;

public interface MovieService {
	
	void insertMovie(MovieDo mdo);

    MovieDo selectMovie(int num);

    void playMovie(MovieDo mdo, int Age);
}
