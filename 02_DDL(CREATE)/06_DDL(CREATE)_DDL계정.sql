-- 우선저장
-- DDL 비번도 동일하게 만들고, 커넥션 리소스 권한 부여할 것!!
-- CREATE USER DDL IDENTIFIED BY DDL;
-- GRANT CONNECT, RESOURCE TO DDL;
-- DB이름은 Oracle_수업용계정_ddl 로 만들기

/*
    * DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    CREATE, ALTER, DROP
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조를 변경(ALTER)하고, 구조 자체를 삭제(DROP)하는 언어
    즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어
    주로 DB관리자, 설계자가 사용함.
    
    오라클에서 제공하는 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
                                인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGER),
                                프로시져(PROCEDURE), 함수(FUNCTION),동의어(SYNONYM), 사용자(USER)
                                
    < CREATE >
    객체를 새로이 생성하는 구문
*/

/*
    1. 테이블 생성
    - 테이블이란? 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                모든 데이터들은 테이블을 통해서 저장됨!!
                (DBMS 용어 중 하나로, 데이터를 일종의 표 형태로 표현한 것!)
    
    [ 표현식 ]
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형,
        ...
    );
    
    * 자료형
    - 문자 (CHAR(바이트 크기) | VARCHAR2(바이트크기)) => 반드시 크기 지정 해야함!!!
    > CHAR : 최대 2000바이트 까지 지정 가능. 지정한 범위 안에서만 써야함/ 고정길이
    - 지정한 크기보다 더 적은 크기의 값이 들어가면 나머지 크기는 공백으로 채워짐
    - * 고정된 글자수의 데이터만이 담길 경우 사용(GENDER, 주민번호, 전화번호 ...) 예상되는 글자수가 올때
    
    > VARCHAR2 : 최대 4000바이트까지 지정 가능, 가변길이 (담기는 값에 따라서 공간의 크기가 맞춰짐)
                 몇 글자의 데이터가 들어올지 모르는 경우 사용함
    
    - 숫자 (NUMBER)
    
    - 날짜 (DATE)
*/
-- 회원에 대한 데이터를 담기 위한 MEMBER 생성하기
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);
-- 테이블 삭제하고자 할 때 : DROP TABLE 테이블명;
DROP TABLE MEMBER;

SELECT * FROM MEMBER;
-- 만약 컬럼명에 오타가 발생했다면 DROP을 하고 다시 만들거나, ALTER로 수정을 해야한다.
-- 다시 덮어쓰기가 안된다.
-- [참고] 이계정에 무슨 테이블이 있는지 궁금할 때 사용
-- USER_TABLES : 현재 이 계정이 가지고 있는 테이블 구조 볼 수 있음
SELECT * FROM USER_TABLES;
-- [참고] USER_TAB_COLUMNS : 이 사용자가 가지고 있는 테이블 상의 모든 컬럼 볼 수 있다.
SELECT * FROM USER_TAB_COLUMNS;

-------------------------------------------------------------------------------
/*
    2. 컬럼에 주석을 달기(컬럼에 대한 설명 같은거)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
    테이블 생성후에만 가능하다.
    
    >> 잘못 작성해서 실행했을 경우 수정 후 다시 실행하면 됨!!
*/
-- ~멤버의 컬럼에 커멘트를 할거임
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원버노';
-- 커멘트는 수정하고 싶을시 다시 실행하면 됨
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';

COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

-- 테이블에 데이터를 추가시키는 구문 (DML : INSERT)
-- INSERT INTO 테이블명 VALUES(값1, 값2,.....);
SELECT * FROM MEMBER;

--INSERT INTO MEMBER VALUES(1,'user01','pass01','손흥민'); => 다입력 안하면 에러남!!
INSERT INTO MEMBER VALUES(1,'user01','pass01','손흥민','남','010-1111-2222','aaa@naver.com','20/12/30');
INSERT INTO MEMBER VALUES(2,'user02','pass02','황희찬','여',null,NULL,SYSDATE);
INSERT INTO MEMBER VALUES(null,null,null,null,null,null,null,null);
-- 유효하지 않은 데이터가 들어가고 있음....뭔가 조건을 걸어줘야함
---------------------------------------------------------------------------------
/*
    < 제약조건 CONSTRAINTS >
    - 원하는 데이터값 (유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 설정하는 제약조건
    - 데이터 무결성 보장을 목적으로 한다!!!
    
    * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야 할 경우 (즉, 해당 컬럼에 절대 NULL이 들어와서는 안되는 경우)
    삽입/ 수정시 NULL값을 허용하지 않도록 제한
    
    제약 조건을 부여하는 방식은 크게 2가지가 있음(컬럼레벨방식 / 테이블레벨방식)
    * NOT NULL 제약조건은 오로지 컬럼레벨방식 밖에 안됨!!
    
*/

-- 컬럼레벨방식 : 컬럼명 자료형 제약조건  - 테이블 만들때
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01','손흥민','남',null,null);
INSERT INTO MEM_NOTNULL VALUES(2,'user02',null,'황희찬','여',null,'aaa@naver.com');
--ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- 의도했던대로 오류남!! (not null 제약조건에 위배되어 오류발생!!)
INSERT INTO MEM_NOTNULL VALUES(2,'user01','pass02','황희찬',null,null,null);
-- 아이디가 중복되어 있음에도 불구하고 잘 추가됨...ㅠ_ㅠ
---------------------------------------------------------------------------------
/*
    * UNIQUE 제약조건
    해당 컬럼에 중복된 값이 들어가서는 안될 경우
    컬럼값에 중복값을 제한하는 제약조건
    삽입 / 수정시 기존에 있는 데이터값 중 중복값이 있을 경우 오류 발생!!
    
*/
-- 컬럼레벨 방식
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- 테이블 레벨 방식 : 모든 컬럼 다 나열 한 후 마지막에 기술
            --      제약조건(컬럼명)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- 테이블 레벨 방식.
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','손흥민',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','황희찬',null,null,null);
--unique constraint (DDL.SYS_C007064) violated
--유니크 제약조건에 위배되었음!! insert 실패!!
-- 오류 구문을 제약조건명으로 알려줌!!(특정 컬럼에 어떤 문제가 있는지 상세히 알려주지는 않음!!)
--> 쉽게 파악하기가 어려움!!
--> 제약 조건 부여시 제약조건명 지정해주지 않으면 시스템에서 임의의 제약조건명을 부여해버린다.

/*
    * 제약조건 부여시 제약조건명까지 지어주는 방법
    
    > 컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건,
        컬럼명 자료형
    );
    
    > 테이블레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
    
*/

-- ZJF
DROP TABLE MEM_UNIQUE;
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL, 
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) -- 테이블 레벨 방식.
);

SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','손흥민',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','황희찬',null,null,null);
--ORA-00001: unique constraint (DDL.MEMID_UQ) violated
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','황희찬',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(3,'user03','pass03','이강인','ㄴ',null,null);
-- 성별에 유효한 값이 아닌게 들어와도 잘 insert가 된다 --> 이러면 안됨
-------------------------------------------------------------------------------
/*
    * CHECK(조건식) 제약조건
    해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해줄 수 있음
    해당 조건에 만족하는 데이터값만 담길 수 있음.
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')), -- 컬럼레벨 방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
 -- CHECK(GENDER IN('남','여')) -- 테이블레벨 방식   
);
SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES (1,'user01','pass01','손흥민','남',null,null);

INSERT INTO MEM_CHECK
VALUES (2,'user02','pass02','황희찬','z',null,null);
--ORA-02290: check constraint (DDL.SYS_C007074) violated
-- check 제한조건에 위배되었기 때문에 오류 발생
-- 만일 gender라는 컬럼에 데이터 값을 넣고자 한다면 check 제약조건에 만족하는 값을 넣어야됨!!!
INSERT INTO MEM_CHECK
VALUES (2,'user02','pass02','황희찬',null,null,null);
-- NOT NULL이 아니면 NULL도 가능하긴 함!!!

INSERT INTO MEM_CHECK
VALUES (2,'user03','pass03','이강인',null,null,null);
-----------------------------------------------------------------------------------
/*
    * PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약 조건(식별자의 역할)
    EX) 학번, 회원번호, 사원번호(EMP_ID), 부서코드, 직급코드, 주문번호, 예약번호, 운송장번호,....
    
    PRIMARY KEY 제약조건을 부여하면 그 컬럼에 자동으로 NOT NULL + UNIQUE 제약조건을 가진다.
    * 유의사항 : 한테이블당 오로지 "한개"만 설정 가능
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- 컬럼레벨방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
--  CONSTRAINT MEMNO_PS PRIMARY KEY (MEM_NO)    
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI VALUES(1,'user01','pass01','손흥민','남','010-1111-2222',null);

INSERT INTO MEM_PRI VALUES(1,'user02','pass02','황희찬','남', null,null);
--ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- 기본키에 중복값을 담으려고 할 때 (unique)제약조건에 위배

INSERT INTO MEM_PRI VALUES(null,'user02','pass02','황희찬','남', null,null);
--ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- 기본키에 null을 담으려 할 때 not null 제약조건에 위배됨
INSERT INTO MEM_PRI VALUES(2,'user02','pass02','황희찬','남', null,null);


CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- 컬럼레벨방식
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
--  CONSTRAINT MEMNO_PS PRIMARY KEY (MEM_NO)    
);

--ORA-02260: table can have only one primary key
-- 기본키는 하나만 된다.

-- MEM_NO,MEM_ID 두개다 식별자로 쓰고싶다.
CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- 묶어서 PRIMARY KEY 제약조건 부여(복합키)    
);

--2개를 묶어서 primary key로 주면 둘다 같은 값이 안들어가는거지
-- 하나라도 다른 값이면 잘 들어감.

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2 
VALUES(1,'user01','pass01','손흥민',null,null,null);

INSERT INTO MEM_PRI2 
VALUES(1,'user02','pass02','황희찬',null,null,null);

INSERT INTO MEM_PRI2 
VALUES(1,'user01','pass01','이강인',null,null,null);

INSERT INTO MEM_PRI2 
VALUES(null,'user01','pass01','이강인',null,null,null);
--ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- primary key로 묶여있는 각 컬럼에는 절대!!! null을 허용하지 않음!!!

-- 복합키 사용 예시(찜하기, 좋아요, 구독)
-- 찜하기 : 한 상품은 조로지 한 번만 찜할 수 있음.
-- 어떤 회원이 어떤 상품을 찜하는지에 대한 데이터를 보관하는 테이블

CREATE TABLE TB_LIKE(
    MEM_ID VARCHAR2(20),
    PRODUCT_NAME VARCHAR2(40),
    LIKE_DATE DATE,
    PRIMARY KEY (MEM_ID, PRODUCT_NAME)
);
CREATE TABLE TB_LIKE(
    MEM_ID VARCHAR2(20),
    PRODUCT_NAME VARCHAR2(40),
    LIKE_DATE VARCHAR2(20),
    PRIMARY KEY (MEM_ID, PRODUCT_NAME)
);

drop table tb_like;

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE 
VALUES('user01','닭', TO_CHAR(sysdate,'PM hh:mm:ss'));

INSERT INTO TB_LIKE 
VALUES('user02','귤', sysdate);

INSERT INTO TB_LIKE 
VALUES('user01','귤', sysdate);

