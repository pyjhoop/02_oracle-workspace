--저장
----------------------------------QUIZ 1--------------------------------------
--보너스를 안받지만 부서배치는 된 사원 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
--NULL 값에 대한 정상적으로 비교 처리가 안된다.

--NULL 값을 비교할 땐 일반 비교연산자로 처리가 안된다
-- IS NULL/ IS NOT NULL을 사용해야함.

SELECT *
FROM EMPLOYEE
WHERE BONUS IS NOT NULL AND DEPT_CODE IS NOT NULL;



--------------------------------------------------------------------------------
----------------------------------QUIZ 2--------------------------------------
--검색하고자 하는 내용
-- JOB_CODE가 J7이거나 J6이면서 SALARY값이 200만원 이상이고 
-- BONUS가 있고 여자이며 이메일 주소는 _앞이 3글자만 있는 사원의
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS를 조회하려 한다.
-- 정상적으로 조회가 잘 된다면 실행결과는 2행 이어야 한다.

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN('J7','J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND SUBSTR(EMP_NO,8,1) = '2'
AND EMAIL LIKE '___$_%' ESCAPE '$';



--위의 내용을 실행시키고자 작성한 SQL문은 아래와 같다.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE'___%' AND BONUS IS NULL;
--위의 SQL문 시행시 원하는 결과가 제대로 조회되지 않는다.
--이때 어떤 문제점들이 있는지 모두 찾아서 서술하시오.
--그리고 조치한 완벽한 SQL문ㅇ르 작성해 볼것!


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
-- 조치내용1. GRANT CONNECT, RESOURCE TO SCOTT;
--시험에 나올 수 있다.

---------------------------------QUIZ 1------------------------------------------
-- ROWNUM을 활용해서 급여가 가장 높은 5명을 조회하고 싶었으나, 제대로 조회가 안됐음!!
-- 이때 작성된 SQL문이 아래와 같음.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 어떤 문제점이 있는지, 해결된 SQL문 작성
-- 정렬이 가장 마지막에 실행되기에 ROWNUM이 순서대로 안나올수 잇다.

SELECT ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY 2 DESC) E
WHERE ROWNUM<=5;

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
DECODE(JOB_CODE,'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2,SALARY*1.05)
FROM EMPLOYEE;

--DECODE가 어떻게 도아가는지 원리를 알면됨

--'21/09/28'와 같은 문자열을 가지고 '2021-09-28'로 표현해보시오
--TO_DATE로 만들고 근데 포멧에 -은 없어 그러면 문자열로 다시 바꿔야함
-- TO_CHAR
-- 날짜를 내가 원하는 포멧으로 만들고 싶으면 날짜 타입을 문자열 타입으로 변경해서 포멧설정하면 됨.
SELECT TO_CHAR(TO_DATE('21/09/28'),'YYYY-MM-DD') FROM DUAL;

-- '210908'와 같은 문자열을 가지고 2021년 9월 8일 표현
-- 날짜를 표현하고 싶은데 0을 없애고 싶을 때 FM을 쓰면됨.
-- FM은 한번만 인식되고 맨앞에 쓰면 뒤에도 다 적용됨
-- DATE로 바꾼뒤 다시 문자열로 바꾸면 되네

SELECT TO_CHAR(TO_DATE('210908'),'YYYY"년" FMMM"월" DD"일"') FROM DUAL;


















