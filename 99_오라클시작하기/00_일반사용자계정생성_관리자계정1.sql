SELECT *
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM JOB;

SELECT JOB_NAME
FROM JOB;

SELECT *
FROM department;

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

--1. JOB 테이블의 직급명만 조회

--2. DEPARTMENT 테이블의 모든 컬럼 조회

--3. DEPARTMENT 테이블의 부서코드, 부서명만 조회

--4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회

--EMPLOYEE 테이블의 사원명, 사원의 연봉(급여*12) 조회

--EMPLOYEE 테이블의 사원명, 급여, 보너스 조회


--EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스가 포함된 연봉(급여+보너스*급여)*12 조회
-- > 산술연산 과정 중 NULL값이 존재할 경우 산술연산한 결과값 마저도 무조건 NULL로 나옴

-- EMPLOYEE 테이블의 사원명, 입사일 조회


--EMPLOYEE 테이블의 사원명, 입사일, 근무일수(오늘날짜 -입사일)
--오늘 날짜 : SYSDATE

--EMPLOYEE 테이블의 사원명, 급여, 연봉, 보너스가 포함된 연봉(급여+보너스*급여)*12 조회


--사번, 이름, 급여를 하나의 컬럼으로 조회

--컬럼값과 리터럴을 연결 
-- XXX의 월급은 XXX원 입니다. 별칭 : 급여정보