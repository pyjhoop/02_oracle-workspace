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
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE,'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2,SALARY*1.05) AS "인상된 급여" -- 디폴트는 그냥 마지막에 값만 쌔리면 됨
FROM EMPLOYEE;

--'21/09/28' 문자열을 '2021-09-28'로 바꾸는것.
-- '210908' 을 2021년 9월 8일 FM사용

-- 초급개발자 중급개발자 CASE WHEN THEN구문 보기
--SELECT CASE WHEN SALARY > 15000 THEN '고급개발자' 
SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, CASE WHEN SALARY >6000000 THEN '고급 개발자'
WHEN SALARY >4000000 THEN '중급개발자'
ELSE '초급 개발자'
END
FROM EMPLOYEE;


/*
    1. DBMS가 뭔지?
    - 데이터베이스를 관리하고 운영하는 시스템
    2. DDL문 종류? 그게 뭐냐?
    - CREATE 객체를 생성한다. ALTER 객체를 수정한다. DROP 객체를 삭제한다.
    3. NUMBER 자료형에 뭐 올 수 있는지? 정수, 실수  숫자 다가능.
    - 
    4. CHAR(10) 의미
    5. INNER JOIN : 두테이블에 전부 데이터가 있어야 나오는것.
    -연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회 -> 일치하는 값이 없는 행은 조회에서 제외
    6. OUTER JOIN: 데이터가 NULL이라도 나오는 것.
    -두 테이블간의 조인시 일치하지 않는 행도 포함시켜서 조회 가능
    단, 반드시 LEFT/RIGHT 지정 해야됨!!!(기준이 되는 테이블 지정)
    7. SUBSTR: 문자열 추출하는 것.
    8. 테이블? 데이터를 표의 형태로 표현한 것.
    9. RESULTSET? SELECT 한 결과를 표의 형태로 표현해서 보여주는 것.
    10. UPPER() 대문자로 바꾸는 것
    11. MINUS, INTERSECT 의미는? 
    12. INITCAP: 첫글자만 대문자로 바꾸주는 함수
    13. TRIM(): 양옆의 공백을 제거해줌 가운데는 삭제 안함.
    14. UNION, UNIONALL 차이? 유니온은 중복값이 안나오고 올은 중복값이 나온다.
     < 집합 연산자 == SET OPERATION >
    
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION     : (OR개념)합집합 (두 쿼리문을 수행한 결과값을 더한 후 중복되는 값은 한번만 더해지도록)
    - INTERSECT : (AND개념)교집합(두 쿼리문 수행한 결과 값에 중복된 결과값)
    - UNION ALL : 합집합 + 교집합(중복되는 부분이 2번 표현될 수 있음)
    - MINUS     : 차집합(선행 결과에서 후행 결과값을 뺀 나머지)

    15. DECODE : 동등비교 함수로  
    16. CONCAT() >=> ||
    17. ROLLUP()? 집계함수로 그룹함수로 집계된 데이터의 합계를 구하기 위한 함수
    18. RANK OVER(), DENSE_RANK OVER() 차이점
    * 순위 매기는 함수(WINDOW FUNCTION)
    RANK() OVER(정렬기준)  |  DENSE_RANK() OVER(정렬기준)
    
    - RANK() OVER(정렬기준): 동일한 순위 이후의 등수를 동일한 인원수 만큼 건너뛰고 순위 계산
                            EX) 공동 1위가 2명 그다음 순위 3위 
    
    - DENSE_RANK() OVER(정렬기준) : 동일한 순위가 있다고 해도 그 다음 등수를 무조건 1씩 증가시킴
                                  EX) 공동 1위가 2명이라도 그 다음 순위를 2위로 함
    >> 두 함수는 무조건 SELECT절에서만 사용 가능!!!
*/

































