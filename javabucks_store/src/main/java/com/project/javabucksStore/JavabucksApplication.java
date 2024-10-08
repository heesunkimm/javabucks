package com.project.javabucksStore;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
public class JavabucksApplication {

	public static void main(String[] args) {
		SpringApplication.run(JavabucksApplication.class, args);
	}

	@SpringBootApplication
	@EnableScheduling public class SchedulerApplication {
	 public static void main(String[] args) {
		 SpringApplication.run(SchedulerApplication.class, args); }
	 }


}
