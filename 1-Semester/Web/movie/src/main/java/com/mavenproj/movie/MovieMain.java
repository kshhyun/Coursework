package com.mavenproj.movie;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class MovieMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
        ApplicationContext container =
                new GenericXmlApplicationContext("MovieSettings.xml");

        MovieService movieService = (MovieService) container.getBean("movieService");

        MovieDo movieInfo1 = (MovieDo) container.getBean("movieInfo1");
        MovieDo movieInfo2 = (MovieDo) container.getBean("movieInfo2");

        movieService.insertMovie(movieInfo1);
        movieService.insertMovie(movieInfo2);

        MovieDo movieInfo = movieService.selectMovie(1);

        movieService.playMovie(movieInfo, 12);
	}

}
