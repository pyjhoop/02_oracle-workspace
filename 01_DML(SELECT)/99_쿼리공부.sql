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
--1. AND가 OR보다 우선순위가 높기에 잡코드가 잘못 나옴
--2. BONUS가 있는거면 IS NOT NULL
--3. EMAIL에서 _는 와일드 카드이기에 ___$_ ESCAPE '$'와 같이 나만의 와일드 카드를 사용해줘야함.
--4. 여자인 조건을 찾아주지 않음.
--5. SALARY를 2000000이상으로 바꿔줘야함.

--정답쿼리:
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND EMAIL LIKE '___$_%' ESCAPE '$'
AND SUBSTR(EMP_NO,8,1) = '2';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN('J7','J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND EMAIL LIKE '___$_%' ESCAPE '$'
AND SUBSTR(EMP_NO,8,1) = '2';




SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;





