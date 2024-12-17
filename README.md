# SPRING BOOT를 이용하여 카페 관리 시스템 만들기

## 프로젝트 목적
 - 목표: 스타벅스를 모티브로 한 커피 전문점 관리 시스템으로, 사용자가 유저, 매장, 본사의 다양한 역할을 맡아 카페 운영의 모든 과정을 체험할 수 있는 자바 기반 프로그램입니다. 이 프로그램은 실제 스타벅스 애플리케이션을 참고하여 메뉴 조회와 주문 기능을 구현했으며, 지점 및 본사의 매장 관리, 주문 처리, 재고 관리 등 카페 운영에 필요한 주요 기능은 팀원들과 협의하여 새롭게 기획되었습니다.
 - 주요 기능: 스프링 시큐리티를 이용한 로그인 회원관리, 출퇴근 및 일정 알람봇
 - 개발 기간 : 2024.07.29 ~ 2024.09.06 (총 40일)
 - 개발 인원: 5명 (김민영, 김희선, 진주경, 채성진, 최진영)

## 프로젝트 결과
 - 3개의 프로젝트로 분리해서 관리(유저, 스토어, 어드민)
   
 - 유저는 이메일 인증을 통해 회원가입 후 주문 및 결제 기능을 이용
   - 메뉴 결제 후 메뉴 준비 진행과정을 스케줄링으로 알림 처리
   - 메뉴별 커스텀 주문 가능
   - 코드를 이용하여 카드 등록 및 충전 가능
   - 결제시 등록된 카드 또는 카카오페이 결제 가능
   - 매장 영업시간 이외의 주문 불가
   - 지점 재고 소진시 메뉴 주문 불가
  
 - 매장은 메뉴 등록과 주문 처리를 통해 실시간 재고 관리가 가능
   - 본사에서 등록한 메뉴 지점에 추가 및 삭제 가능
   - 주문 내역 실시간 확인 및 주문 처리 가능
   - 지점 매출 확인 가능
   - 재고 소진 시 주문 가능

 - 본사는 고객 및 매장 계정 관리, 메뉴 수정 및 신메뉴 추가, 발주 내역 승인, 재고 관리, 정산 관리 등의 기능을 수행
   - 신메뉴 등록과 삭제, 주문막기 가능
   - 스케줄링을 이용하여 유저의 생일 일주일 전 생일 쿠폰 전송 및 신규 쿠폰 발급 및 특정 유저에게 전송
   - 지점 발주 내역 승인 및 재고 관리
   - 전 지점 매출 관리

## 파일구조 (javabucks, javabucks_admin, javabucks_store 동일)
    javabucks/
    ├── src/
    │ ├── main/
    │ │ ├── java/
    │ │ │  └── com/
    │ │ │    └── project/
    │ │ │      └── javabucks/
    │ │ │        ├── controller/
    │ │ │        ├── dto/
    │ │ │        └── mapper/
    │ │ ├── resources/
    │ │ │  ├── mybatis/
    │ │ │  ├── static/
    │ │ │  └── application.properties
    │ │ └── webapp/
    │ │   ├── upload_menuImages/
    │ │   └── WEB-INF/
    │ │     └── views/
    │ └── test/
    ├── .gitignore
    ├── mvnw
    ├── mvnw.cmd
    ├── pom.xml
    └── README.md

## 기술 스택
 - Environment
   - Framework: Spring STS4
   - Database: Oracle
   - Version Control: Git, GitHub
 
 - Development
   - Front-end: HTML, CSS, JavaScript, jQuery, JSP, Ajax
   - Back-end: Spring boot, MyBatis
   - Payment API: import
