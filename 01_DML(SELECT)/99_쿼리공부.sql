--저장 먼저 하기
----------------------------------QUIZ 1--------------------------------------
--보너스를 안받지만 부서배치는 된 사원 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
--NULL 값에 대한 정상적으로 비교 처리가 안된다.

--문제점 : NULL 값 비교할 때는 단순한 일반 비교연산자를 통해 비교 할 수 없음.
--해결방법: IS NULL / IS NOT NULL 연산자를 이용해서 비교해야한다.

--조치한 SQL문 
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;
--------------------------------------------------------------------------------
----------------------------------QUIZ 2--------------------------------------
--검색하고자 하는 내용
-- JOB_CODE가 J7이거나 J6이면서 SALARY값이 200만원 이상이고 
-- BONUS가 있고 여자이며 이메일 주소는 _앞이 3글자만 있는 사원의
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS를 조회하려 한다.
-- 정상적으로 조회가 잘 된다면 실행결과는 2행 이어야 한다.

--위의 내용을 실행시키고자 작성한 SQL문은 아래와 같다.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE'___%' AND BONUS IS NULL;
--위의 SQL문 시행시 원하는 결과가 제대로 조회되지 않는다.
--이때 어떤 문제점들이 있는지 모두 찾아서 서술하시오.
--그리고 조치한 완벽한 SQL문ㅇ르 작성해 볼것!

--문제점:
--1. AND 연산자가 우선순위가 높기에 OR보다 먼저 수행이 된다. 문제에서 요구한 대로 OR이 먼저 수행이 되어야함.
--2. BONUS가 있는거면 IS NOT NULL
--3. EMAIL에서 _는 와일드 카드이기에 ___$_ ESCAPE '$'와 같이 나만의 와일드 카드를 사용해줘야함.
--4. 여자인 조건을 찾아주지 않음.
--5. SALARY의 조건이 이상함 >= 바꿔야함.

--정답쿼리:
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN('J6','J7') AND SALARY >= 2000000
AND EMAIL LIKE'___$_%' ESCAPE '$' AND BONUS IS NOT NULL 
AND SUBSTR(EMP_NO,8,1) = '2';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN('J7','J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND EMAIL LIKE '___$_%' ESCAPE '$'
AND SUBSTR(EMP_NO,8,1) = '2';




SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;
------------------------------22.11.28 연습 -----------------------------
SELECT ROUND(12.43) FROM DUAL;
SELECT ROUND(12.3223,1) FROM DUAL;
SELECT ROUND(123.2343,2) FROM DUAL;

--CEIL(NUBER)
SELECT CEIL(12.323)FROM DUAL;
SELECT CEIL ( 124123.24433)FROM DUAL;

-- FLOOR(NUMBER)
SELECT FLOOR(123.323) FROM DUAL;
SELECT FLOOR(1233.34214) FROM DUAL;

-- TRUNC (NUMBER , [절삭 위치]) 
SELECT TRUNC(123.323) FROM DUAL;
SELECT TRUNC(123.434,1)FROM DUAL;
SELECT TRUNC (123.4324,-1) FROM DUAL;

--날짜 처리 함수
SELECT SYSDATE FROM DUAL;

--MONTHS_BETWEEN(DATE, DATE) : 두 날짜 사이의 개월수를 반환 => NUMBER 리턴
SELECT EMP_NAME, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "개월수"
FROM EMPLOYEE;

--ADD_MONTHS(DATE, NUMBER): 특정 날짜에 개월수를 더한 날짜 리턴
SELECT EMP_NAME, ADD_MONTHS(HIRE_DATE, 6) AS "6개월이 지난 시점"
FROM EMPLOYEE;

--NEXT_DAY(DATE, 요일(숫자)): 특정 날짜이후로 가장 가까운 요일의 날짜 반환
--1. 일요일 7. 토요일
SELECT NEXT_DAY(SYSDATE,6) FROM DUAL;
SELECT NEXT_DAY(HIRE_DATE,6)FROM EMPLOYEE;

--LAST_DAY(DATE) : 해당 DATE의 마지막 날짜를 반환해줌
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--EXTRACT(YEAR FROM DATE) : 특정 연도를 반환

SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) AS "년도"
, EXTRACT(MONTH FROM HIRE_DATE) AS "월",
EXTRACT(DAY FROM HIRE_DATE) AS "일"
FROM EMPLOYEE
ORDER BY 2 DESC;

SELECT CEIL(12.32)FROM DUAL;
SELECT FLOOR(123.64) FROM DUAL;

SELECT EMP_NAME, EXTRACT(MONTH FROM HIRE_DATE)
FROM EMPLOYEE;

SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT NEXT_DAY(SYSDATE, '금') FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE
ORDER BY 3 DESC NULLS LAST;

-- 형변환 함수 매우 중요 
-- 문자열로 바꾸는 함수 : TO_CHAR(숫자|날짜,[형식])

SELECT TO_CHAR(123445) FROM DUAL;
SELECT TO_CHAR(12345,'999999')FROM DUAL;
SELECT TO_CHAR(12345,'000000')FROM DUAL;
SELECT TO_CHAR(12345,'L999999')FROM DUAL;
SELECT TO_CHAR(12345,'$000000')FROM DUAL;
SELECT TO_CHAR(12345,'L999,999') FROM DUAL;
SELECT TO_CHAR(12345,LTRIM('L999,999')) FROM DUAL;
SELECT SALARY, TO_CHAR(SALARY,'L999,999,999') 
FROM EMPLOYEE;
SELECT TO_CHAR(SYSDATE) FROM DUAL;
--날짜 타입 => 문자타입
SELECT TO_CHAR(SYSDATE,'AM YY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MONTH YY-MM-DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM DUAL;

--연도와 관련된 포멧
--YYYY, YY, RR, RRRR, YEAR
--월과 관련된 포멧
-- MM, MON, MONTH, RM
--일과 관련된 포멧
-- DD,DDD(올해 지난 일수) , D(이번주 몇번째 요일인지 1.일요일)
--요일에 대한 포멧
-- DAY, DY

-- TO_DATE: 문자 또는 숫자를 데이트 타입으로 형변환

SELECT TO_DATE(100101) FROM DUAL;
SELECT TO_DATE(20101010) FROM DUAL;

SELECT TO_DATE(071010) FROM DUAL;-- 에러 발생 07은 7로 인식이 됨.
SELECT TO_DATE('071010')FROM DUAL;

SELECT TO_DATE('140630','YYMMDD') FROM DUAL;
SELECT TO_DATE('140630 153015','YYMMDD HH24:MI:SS') FROM DUAL;

SELECT TO_DATE('140630','YYMMDD') FROM DUAL; -- 현재 세기를 나타냄
SELECT TO_DATE(971013,'RRMMDD') FROM DUAL;-- 50 이상이면 이전 세대
-- 50 미만이면 현재 세대


-------------------------------------------퀴즈 3--------------------------------
-- [계정생성구문] CREATE USER 계정명 IDENTIFIED BY 비밀번호;

-- 계정명 : SCOTT, 비번: TIGER 계정을 생성하고 싶다!
-- 이때 일반사용자 계정인 KH계정에 접속해서 CREATE USER SCOTT;로 실행하니 문제 발생!!!

--문제점1. 사용자 계정생성은 무조건 관리자 계정에서만 가능
--문제점2. SQL문이 잘못되어있음. 비번까지 입력해야함!!

-- 조치내용1. 관리자 계정에 접속해야됨!!
-- 조치내용2. CREATE USER SCOTT IDENTIFIED BY TIGER;
--위의 SQL(CREATE)만 실행 후 접속을 만들어서 접속을 하려고 했으나 실패함
-- 뿐만 아니라 해당 게정에 테이블 생성 같은 것도 안됨! 왜 그럴까? 권한이 없음.

-- 문제점1. 사용자 계정 생성 후 최소한의 권한 부여가 안됐다.
-- 시스템 권한 및 객체접근 권한이 부여가 안되었기 때문에
-- 조치내용1. GRANT CONNECT, RESOURCE TO SCOTT;
--시험에 나올 수 있다.





