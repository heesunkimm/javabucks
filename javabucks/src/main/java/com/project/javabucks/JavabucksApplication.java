package com.project.javabucks;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class JavabucksApplication {

	public static void main(String[] args) {
		SpringApplication.run(JavabucksApplication.class, args);
	}

}
