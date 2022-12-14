-- 저장
-- 퀴즈 1
-- CREATE USER TEST IDENTIFIED BY 1234; TLFGOD
-- USER TEST이(가) 생성되었습니다.
-- 접속하려하는데 에러발생함.
-- 문제점 : 계정생성만 했고 접속 권한을 부여하지 않았기 때문임.
-- 조치된 쿼리 : GRANT CONNECT, RESOURCE TO TEST;

-- 퀴즈 2 조인
CREATE TABLE TB_JOB(
    JOB_CODE NUMBER PRIMARY KEY,
    JOB_NAME VARCHAR2(10) NOT NULL

);

CREATE TABLE TB_EMP(
    EMP_NO NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(10) NOT NULL,
    JOB_NO NUMBER REFERENCES TB_JOB(JOB_CODE)
);

-- 위의 두 테이블이 있다는 가정하에 
-- 두 테이블 조인해서 EMP_NO, EMP_NAME, JOB_NO, JOB_NAME 컬럼을 조회할꺼임
-- 이때 실행한 SQL문 
SELECT EMP_NO, EMP_NAME, JOB_NO, JOB_NAME
FROM TB_EMP
JOIN TB_JOB USING(JOB_NO); -- 에러발생함
-- 왜 발생했을까?
-- ON으로 바꾸면 됨.
-- 문제점: JOB_NO 컬럼이 TB_EMP에는 존재하지만 TB_JOB에는 존재하지 않기 때문에 USING구문 안된다.
-- 해결내용 : USING(JOB_NO) 를 ON(JOB_NO = JOB_CODE)로 바꾸면 된다.

--------------------------------------------------------------------------------
-- 테이블 생성관련해서 데이터 타입(CHAR, VARCHAR2)차이점
-- 오라클 객체(SEQUENCT, VIEW,...)뭔지 정의
-- 제약조건  -> 제약조건을 추가하려고 한다. 추가하는 ALTER문 작성해라.
-- DCL 뭐임? GRANT, REVOKE
-- 커밋 롤백 뭐임?

-- 퀴즈 3(JOIN 복습)

-- 아래의 SQL구문은 부서별 월급합계가 15000000을 초과하는 부서를 조회한 것이다.
-- 그 결과가 올바르지 않다고 할 때 그원인과 조치사항
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY>2800000
GROUP BY DEPT_CODE; -- WHERE 삭제하고 HAVING에 1500만원 초과하는 조건 넣어라


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;

-- 퀴즈 4 제약조건 관련
CREATE TABLE QUIZE4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZE4 VALUES(1,'퀴즈1번',30);
INSERT INTO QUIZE4 VALUES(1,'퀴즈2번',50); -- 에러가 발생함 왜 에러가 났는지? PRIMARY KEY제약조건임

-- JOIN => DECODE
-- J7인 사원은 급여를 10% 
-- J6인 사원은 급여를 15% 인상한다.

--'21/09/28' 문자열을 '2021-09-28'로 바꾸는것.
-- '210908' 을 2021년 9월 8일 FM사용

-- 초급개발자 중급개발자 CASE WHEN THEN구문 보기
--SELECT CASE WHEN SALARY > 15000 THEN '고급개발자' 

/*
    1. DBMS가 뭔지?
    2. DDL문 종류? 그게 뭐냐?
    3. NUMBER 자료형에 뭐 올 수 있는지? 정수, 실수  숫자 다가능.
    4. CHAR(10) 의미
    5. INNER JOIN : 두테이블에 전부 데이터가 있어야 나오는것.
    6. OUTER JOIN: 데이터가 NULL이라도 나오는 것.
    7. SUBSTR: 문자열 추출하는 것.
    8. 테이블? 데이터를 표의 형태로 표현한 것.
    9. RESULTSET? SELECT 한 결과를 표의 형태로 표현해서 보여주는 것.
    10. UPPER() 대문자로 바꾸는 것
    11. MINUS, INTERSECT 의미는? 
    12. INITCAP: 첫글자만 대문자로 바꾸주는 함수
    13. TRIM(): 양옆의 공백을 제거해줌 가운데는 삭제 안함.
    14. UNION, UNIONALL 차이? 유니온은 중복값이 안나오고 올은 중복값이 나온다.
    15. DECODE : 동등비교 함수로  
    16. CONCAT() >=> ||
    17. ROLLUP()? 집계함수
    18. RANK OVER(), DENSE_RANK OVER() 차이점
*/

































