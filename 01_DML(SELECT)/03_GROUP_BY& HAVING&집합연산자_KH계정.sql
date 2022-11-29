-- 우선 저장
/*
    < GROUP BY 절 >
    그룹기준을 제시할 수 있는 구문 (해당 그룹기준별로 여러 그룹을 묶을 수 있음)
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
    해당 컬럼에 중복된 값들이 있으면 하나의 그룹으로 취급해서 사용
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; -- 전체 사원ㅇ르 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 사원수
SELECT DEPT_CODE,SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- DEPT_CODE로 묶으면 돌일한 값들을 하나로 묶어서 여러개의 그룹을 만들어줌

--실행순선
SELECT DEPT_CODE, SUM(SALARY) --3
FROM EMPLOYEE --1
GROUP BY DEPT_CODE --2
ORDER BY DEPT_CODE; --4 정렬이 가장 마지막

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 각 직급별로 총 사원수, 보너스를 받는 사원수, 급여 합, 평균 급여, 최저급여, 최대급여
-- GROUP BY 하고 SELECT 하면 그 그룹에서~~~ EX) 그 그룹에서 총사원수, 그 그룹에서 보너스 받는 사원수, 그 그룹에서 급여의 총합계, 그 그룹에서 최소급여...
SELECT JOB_CODE, COUNT(*) AS "사원수", COUNT(BONUS) AS "보너스 받는 사원수", SUM(SALARY) AS "급여합"
, MIN(SALARY)AS "최소 급여", MAX(SALARY) AS "최대급여", TO_CHAR(TRUNC(AVG(SALARY)),'999,999,999')||'원' AS "평균급여"
FROM EMPLOYEE 
GROUP BY JOB_CODE
ORDER BY 1;

SELECT DEPT_CODE, COUNT(*) AS "사원수", COUNT(BONUS) AS "보너스 받는 사원수", SUM(SALARY) AS "급여합"
, MIN(SALARY)AS "최소 급여", MAX(SALARY) AS "최대급여", TO_CHAR(TRUNC(AVG(SALARY)),'999,999,999')||'원' AS "평균급여"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
ORDER BY 1;


-- GROUP BY 절에 함수식 기술 가능!!!
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1); -- 1또는 2를 가진 테이블 이 만들어짐.

-- GROUP BY 절에 여러 컬럼 기술 가능!!!
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE --두개의 코드가 같은 것 끼리 묶임
ORDER BY DEPT_CODE;

-------------------------------------------------------------------------------
/*
    < HAVING 절 >
    그룹에 대한 조건을 제시할 때 사용되는 구문(주로 그룹함수식을 가지고 조건을 제시할 때 사용)
*/

-- 각 부서별 평균 급여 조회(부서코드, 평균급여)
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- 부서별로 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
--WHERE FLOOR(AVG(SALARY))>= 3000000 오류 발생 그룹 함수가지고 조건을 제시하면 WHERE절에서는 안된다.
GROUP BY DEPT_CODE
ORDER BY 1;

SELECT DEPT_CODE, FLOOR(AVG(SALARY)) -- 4
FROM EMPLOYEE --1
GROUP BY DEPT_CODE --2
HAVING AVG(SALARY) >= 3000000; --3
-- HAVING이 그룹함수의 조건(WHERE)역할을 함.

-- 직급별 총급여합 단, 직급별 급여의 합이 1000만원 이상인 직급만 조회 => 직급코드, 급여합 조회
SELECT JOB_CODE AS "직급코드", TO_CHAR(SUM(SALARY),'L999,999,999') AS "급여합"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별로 보너스를 받는 사원이 없는 부서만을 조회 부서코드만 나오게 해보셈
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

----------------------------------------------------------------------------------
/*
    < SELECT 문 실행순서 >
    5. SELECT *|조회하고자 하는 컬럼 별칭 | 산술식 "별칭" | 함수식 AS "별칭"
    1. FROM 조회하고자 하는 테이블 명
    2. WHERE 조건식(연산자를 가지고 기술)
    3. GROUP BY 그룹기준으로 삼을 컬럼 | 함수식
    4. HAVING 조건식 (그룹함수를 가지고 기술)
    6. ORDER BY 컬럼명| 별칭 | 순번[ASC|DESC] [NULLS FIRST| NULLS LAST]
*/
---------------------------------------------------------------------------------
/*
    < 집계함수 >
    그룹별 산출된 결과값에 중간집계를 계산해주는 함수
    
    ROLL UP
    => GROP BY 절에 기술하는 함수 마지막 행에 집계한 것을 추가해줌
*/
--각 직급별 급여합
-- 마지막 행으로 전체 총 급여합까지 같이 조회하고 싶을 때
SELECT JOB_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;
--ROLLUP(): GROUP BY를 통해 묶은 그룹의 중간 집계를 계산해주는 함수
----------------------------------------------------------------------------------
/*
    < 집합 연산자 == SET OPERATION >
    
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION     : (OR개념)합집합 (두 쿼리문을 수행한 결과값을 더한 후 중복되는 값은 한번만 더해지도록)
    - INTERSECT : (AND개념)교집합(두 쿼리문 수행한 결과 값에 중복된 결과값)
    - UNION ALL : 합집합 + 교집합(중복되는 부분이 2번 표현될 수 있음)
    - MINUS     : 차집합(선행 결과에서 후행 결과값을 뺀 나머지)
*/

--1. UNION
-- 부서코드가 D5인 사원 또는 급여가 300만원 초가인 사원들 조회(사번, 이름, 부서코드, 급여)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6개행(박나라, 하이유, 김해술, 심봉선 ,윤은해, 대북혼)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;-- 8개행(선동일, 송중기, 노옹철, 유재식, 정중하, *심봉선,*대북혼, 전지연)

-- 위의 커리문 대신 아래처럼 WHERE절에 OR를 써도 해결 가능!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;


--2. INTERSECT(교집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6개행(박나라, 하이유, 김해술, 심봉선 ,윤은해, 대북혼)
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;-- 8개행(선동일, 송중기, 노옹철, 유재식, 정중하, *심봉선,*대북혼, 전지연)

-- 아래처럼도 해결 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;
------------------------------------------------------------------------------
--집합 연산자 유의사항
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6개행(박나라, 하이유, 김해술, 심봉선 ,윤은해, 대북혼)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 각쿼리문의 SELECT절에 작성되어있는 컬럼개수가 동일해야됨.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6개행(박나라, 하이유, 김해술, 심봉선 ,윤은해, 대북혼)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- 컬럼 개수 뿐만 아니라 컬럼자리마다 동일한 타입으로 기술해야됨!!

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6개행(박나라, 하이유, 김해술, 심봉선 ,윤은해, 대북혼)
--ORDER BY EMP_NAME
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;
-- ORDER BY절을 사용하고자 한다면 마지막에 기술해야됨
-------------------------------------------------------------------------------
--3. UNION ALL: 여러개의 쿼리 결과를 무조건 다 더하는 연산자(중복값 나옴)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6개행(박나라, 하이유, 김해술, 심봉선 ,윤은해, 대북혼)
--ORDER BY EMP_NAME
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;

-------------------------------------------------------------------------------
--4. MUNUS : 선행 SELECT 결과에서 후행 SELECT 결과를 뺀 나머지(차집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6개행(박나라, 하이유, 김해술, 심봉선 ,윤은해, 대북혼)
--ORDER BY EMP_NAME
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;

-- 아래처럼도 가능하긴 함!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;













