-- 먼저 저장
---------------------------------QUIZ 1------------------------------------------
-- ROWNUM을 활용해서 급여가 가장 높은 5명을 조회하고 싶었으나, 제대로 조회가 안됐음!!
-- 이때 작성된 SQL문이 아래와 같음.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 어떤 문제점이 있는지, 해결된 SQL문 작성
--1. ORDER BY 가 가장 마지막에 적용되기에 ROWNUM의 순서가 섞임
--2. 먼저 정렬을 진행하고 그다음 ROWNUM을 추출해야함.

SELECT ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY 2 DESC) E
WHERE ROWNUM <=5;
---------------------------------QUIZ 2------------------------------------------
-- 부서별 평균 급여가 270만원을 초과하는 부서들에 대해 (부서코드, 부서별 총급여합, 부서별 평균급여, 부서별 사원수)
-- 이때 작성된 SQL문이 아래와 같음.
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
WHERE SALARY >2700000
GROUP BY DEPT_CODE
ORDER BY 1;

--어떤 문제점이 있는지, 해결된 SQL문작성
-- 부서별 평균 급여가 270만원 초과인데 WHERE절로 사원의 급여가 270만원 초과라는 조건식을 사용함.
-- 조건식을 HAVING절에 넣어야함.

SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;

---------------------------------------------------------------------------------
-- 서술형 대비
-- JOIN 종류 (내부조인, 외부조인, 셀프조인, 네츄럴조인 )별 특징, 역할
-- 함수 종류(TRIM, SUBSTR...)별 각각의 역할

--직원의 급여를 조회시 직급별로 인상해서 조회
-- J7 10% 인상 SALARY*1.1하면 됨.
--J6인 사원 15%인상
--J5인 사원 20% 인상
-- 그외의 나머지 사원은 급여를 5%인상
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE,'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2,SALARY*1.05) AS "인상된 급여" -- 디폴트는 그냥 마지막에 값만 쌔리면 됨
FROM EMPLOYEE;
--DECODE가 어떻게 도아가는지 원리를 알면됨

--'21/09/28'와 같은 문자열을 가지고 '2021-09-28'로 표현해보시오
-- '210908'와 같은 문자열을 가지고 2021년 9월 8일 표현




























