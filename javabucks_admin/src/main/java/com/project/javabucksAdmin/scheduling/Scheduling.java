package com.project.javabucksAdmin.scheduling;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

//스프링 스케쥴러 어노테이션 추가
@SpringBootApplication
@EnableScheduling // 스프링 스케쥴러 활성화
public class Scheduling {
	public static void main(String[] args) {
        SpringApplication.run(Scheduling.class, args);
    }
}
