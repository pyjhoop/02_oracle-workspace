--우선저장
/*
    DQL (QUERY 데이터 질의 언어) : SELECT
    
    
    DML (MANIPULATION 데이터 조작 언어) : [SELECT],INSERT,UPDATE,DELETE
    DDL (DEFINITION 데이터 정의 언어) : CREATE, ALTER, DROP
    DCL (CONTROL 데이터 제어 언어) : GRANT, REVOKE,[COMMIT, ROLLBACK]
    
    TCL (TRANSACTION 트랜젝션 제어 언어) : COMMIT, ROLLBACK
    
    *DML : DATA MANIPULATION LANGUAGE
    데이터 조작 언어
    
    테이블에 값을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 하는 구문
*/


/*
    1. INSERT
        테이블에 새로운 행을 추가하는 구문
        
        [표현식]
        1) INSERT INTO 테이블명 VALUES(값1,값2,....);
            테이블의 모든 컬럼에 대한 값을 직접 제시해서 한 행 INSERT 하고자 할 때 사용
            컬럼 순번을 지켜서 VALUES에 값을 나열해야됨!
            
            부족하게 값을 제시했을 경우=>NOT ENOUGH VALUE오류!!
            값을 더 많이 제시했을 경우 =>too many values 오류!!
*/
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE VALUES(900,'차은우','900101-1234567','CHA_OO@KH.OR.KR','01011112222',
       'D1', 'J7','S3',4000000,0.2,200,SYSDATE,NULL,DEFAULT);
-- 이렇게 전부다 INSERT 하는 방법이 있고

-- 가장중요한 부분
/*
    2) INSERT INTO 테이블명(컬럼1, 컬럼2,...) VALUES();
        테이블에 내가 선택한 컬럼에 대한 값만 INSERT 할 때 사용
        선택이 안된 컬럼은 기본적으로 NULL이 들어감 
        => NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값 제시해야됨!
        단, DEFAULT 값이 있는 경우는 NULL이 아닌 DEFAULT값 들어간다.
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME,EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(901,'주지훈','990101-1111111','J2','S2',SYSDATE);

SELECT * FROM EMPLOYEE;
-- ENT_YN은 디폴트값으로 N이 들어가있다.

/*
    3) INSERT INTO 테이블명 (서브쿼리)
        VALUES로 값을 직접 명시하는거 대신에
        서브쿼리로 조회된 결과값을 통째로 INSERT 가능!!(여러행 INSERT 가능!!)
*/

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);
SELECT * FROM EMP_01;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;
/*
    [표현식]
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명,...)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명,...)
    서브쿼리;
*/

-- 여러테이블의 값들을 서브쿼리로 한번에 대입해주는방법
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1=0;
SELECT * FROM EMP_DEPT;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1=0;
   
--부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회
SELECT EMP_NO, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_NO, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';



