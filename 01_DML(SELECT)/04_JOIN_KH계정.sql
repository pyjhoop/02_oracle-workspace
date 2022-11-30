--먼저 저장
/*
    < JOIN > 
    두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물(RESULT SET)로 나옴
    
    관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 데이터를 담고 있음.
    
    --어떤 사원이 어떤 부서에 속해있는지 궁금함!! 코드말고.. 이름으로
    
    => 관계형 데이터 베이스에서 SQL문을 이용한 테이블간에 "관계"를 맺는방법
    (무작정 다 조회를 해온게 아니라 각 테이블간 연결고리로써의 데이터를 매칭해서 조회해야됨!!)
    
                            JOIN은 크게 "오라클 전용구문"과 "ANSI 구문"(ANSI == 미국국립표준협회) => 아스키코드표 만드는 곳!
    
*/

SELECT EMP_NAME, DEPT_CODE 
FROM EMPLOYEE; -- DEPT_CODE가 연결고리

SELECT *
FROM DEPARTMENT;-- DEPT_ID

--전체 사원들의 사번, 사원명, 부서코드, 부서명 조회하고자 할때
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--전체 사원들의 사번, 사원명, 직급코드, 직급명 조회하고자 할때
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE; -- JOB_CODE

SELECT *
FROM JOB;--JOB_CODE

/*
    1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
        연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회 -> 일치하는 값이 없는 행은 조회에서 제외
*/

-- >> 오라클 전용 구문
-- FROM 절에 조회하고자 하는 테이블들 싹다 나열(A,B,...)
-- WHERE절에 매칭시킬 컬럼(연결고리)에 대한 조건을 제시함.

--1. 연결할 두 컬럼명이 다른 경우 (EMP : DEPT_CODE, DEP : DEPT_ID)
-- 같기에 어떤곳의 컬럼인지 알려줘야함
--구분이 가능하기에 그냥 사용함
-- 사번 , 사원명, 부서코드, 부서명을 같이 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE,DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; -- 이 연결고리가 같은 것만 출력하겠다.
-- 일치하는 값이 없는 행은 조회에서 제외된거 확인 가능, DEPT_CODE가 NULL인 애들은 안나옴
--DEPT_ID D3,D4,D7 조회안됨, => 둘다 있어야 조회 가능하다.


--2. 연결할 두 컬럼명이 같은 경우(EMP: JOB_CODE, JOB: JOB_CODE)
-- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
--column ambiguously defined : 애매하다, 모호하다 어디꺼의 JOB_CODE인지 알수가 없다.

--해결방법1: 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

--해결방법2: 테이블에 별칭을 부여해서 이용하는 방법
-- 별칭 사용을 추천함.
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- >> ANSI 구문 
-- FROM 절에기준이 되는 테이블을 하나만 기술 한 후
-- JOIN 절에 같이 조회하고자 하는 테이블 기술 + 매칭시킬 컬럼에 대한 조건도 같이 기술
-- JOIN USING, JOIN ON

--1. 연결할 두 컬럼명이 다른 경우 (EMP: DEPT_CODE, DEP: DEPT_ID)
-- 오로지 JOIN ON 구문으로만 가능!!!
-- 사번, 사원명, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--2. 연결할 두 컬럼명이 같은 경우 (EMP: JOB_CODE, JOB: JOB_CODE)
-- JOIN ON, JOIN USING둘다 사용가능
-- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON JOB_CODE =JOB_CODE;

--해결방법 1 테이블명 또는 별칭을 이용해서 하는 방법
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE =J.JOB_CODE);

--해결방법2 JOIN USING 사용하는 방법 (**두 컬럼명이 일치할 때만 사용가능)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--참고사항-----
-- 자연조인(NATURAL JOIN) : 각 테이블마다 동일한 컬럼이 단 한개만 존재할 경우 => ANSI
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

--직급이 대리인 사원의 이름, 직급명, 급여 조회
-->> 오라클 전용구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '대리';

-->> ANSI전용 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리';

----------------------------------실습문제-----------------------------------------
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

--1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
--> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, NVL2(BONUS,BONUS,'0')
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '인사관리부';

SELECT EMP_ID, EMP_NAME, NVL(BONUS,'0')
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND DEPT_TITLE = '인사관리부';
--> ANSI구문

SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

--2. DEPARTMENT와 LOCATION을 참고해서 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
--> 오라클 전용구문
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT , LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;

SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

--> ANSI구문
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회

--> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
AND BONUS IS NOT NULL;

--> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE BONUS IS NOT NULL;


--4. 부서가 총무부가 아닌 사원들의 사원명, 급여, 부서명 조회
--> 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
AND DEPT_TITLE != '총무부';

--> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE <> '총무부';

--3 개 연결도 가능하네
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_CODE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;
-----------------------------------------------------------------------------
/*
    2. 포괄조인/ 외부조인 (OUTER JOIN)
    두 테이블간의 조인시 일치하지 않는 행도 포함시켜서 조회 가능
    단, 반드시 LEFT/RIGHT 지정 해야됨!!!(기준이 되는 테이블 지정)
*/

--외부조인과 비교할 만한 INNER JOIN 조회해두기
-- 월급 주기
-- 사원명, 부서명, 급여, 연봉
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 21명만나옴 2명이 안나옴
-- 부서배치가 아직 안된 사원 2명에 대한 정보는 조회 안됨
-- 부서에 배정된 사원이 없는 부서같은 경우도 조회가 안됨 EX 마케팅부

--1. LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블 기준으로 JOIN 왼쪽에 있는 테이블의 데이터는 NULL신경안쓰고 싹다 나와라
--> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE -- 여기에 있는건 다 나오는 거임
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- EMPLOYEE에 대한 데이터는 모두 다 나와라 의미
-- 부서 배치를 받지 않았던 2명의 사원 정보도 조회됨

--> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 내가 다나오게 하고싶은 테이블의 반대 테이블에+를 붙여주면됨.

--2. RIGHT [OUTER] JOIN: 두 테이블 중 오른편에 기술된 테이블 기준으로 JOIN 오른쪽에 있는 데이터는 다 나옴.
--> ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 하동훈이 안나옴

-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; --즉 다나오게 하고싶은 테이블의 반대 컬럼에 (+) 해주면됨

--3. FULL [OUTER] JOIN: 두 테이블이 가진 모든 행을 조회할 수 있음 단 ANSI만 가능하다 오라클은 불가
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-------------------------------------------------------------------------------
/*
    3. 자체 조인(SELF JOIN)
    같은 테이블을 다시 한번 조인하는 경우
*/

SELECT * FROM EMPLOYEE;
-- 전체 사원의 사번, 사원명, 사원의 부서코드 => EMPLOYEE E MANAGER_ID
--      사수의 사번, 사수명, 사수의 부서코드=> EMPLOYEE M EMP_ID

-- 오라클 전용 구문
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

--ANSI구문
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
----------------------------------------------------------------------------------
/*
    < 다중 조인 >
    2개 이상의 테이블을 가지고 JOIN할 때 
*/

-- 사번, 사원명, 부서명, 직급명
SELECT * FROM EMPLOYEE;  --DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID
SELECT * FROM JOB;  --JOB_CODE

--오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE =DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

--ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID
JOIN JOB J USING (JOB_CODE);

-- 사번, 사원명, 부서명, 지역명
SELECT * FROM EMPLOYEE;-- DEPT_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID , LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE
--오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- ANSI전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID);

---------------------------------------실습문제----------------------------------
--1. 사번, 사원명, 부서명, 지역명, 국가명 조회 
--오라클 구문
SELECT * FROM EMPLOYEE; -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION; --LOCAL_CODE,  NATIONAL_CODE
SELECT * FROM NATIONAL; -- NATIONAL_CODE

SELECT EMP_ID, EMP_NAME ,DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;

--ANSI 구문
SELECT EMP_ID, EMP_NAME ,DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE);


--2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 해당 급여등급에서 받을 수 있는 최대금액(모든 테이블 조인)
SELECT * FROM EMPLOYEE; -- DEPT_CODE                SLA_LEVEL
SELECT * FROM DEPARTMENT; -- DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION; --LOCAL_CODE,  NATIONAL_CODE
SELECT * FROM NATIONAL; -- NATIONAL_CODE
SELECT * FROM SAL_GRADE; --                         SAL_LEVEL
SELECT * FROM JOB;                         --JOB_CODE

-- 오라클 버전
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT D, JOB J1, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J1.JOB_CODE
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL;

-- ANSI 버전
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID)
JOIN JOB J1 ON (E.JOB_CODE = J1.JOB_CODE)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE)
JOIN SAL_GRADE S USING (SAL_LEVEL);

/*

    그냥 별칭 해주는게 좋고 SELECT 절에서도 별칭을 사용해주는 것이 복잡할 때 좋을 듯
    오늘 배운 것 JOIN 
    JOIN에는 INNER , OUTER 두가지가 존재
    INNER JOIN 하는 방법은 오라클과 ANSI방법 2가지 존재
    오라클 은 = 를 사용
    ANSI는 JOIN ON 또는 JOIN USING을 사용한다.
    컬럼이름이 다를 경우는 JOIN ON만 사용가능ㅎ다ㅏ.
    컬럼이름이 같을 경우 JOIN ON, JOIN USIG 둘다 사용가능.
    INNER JOIN은 없는 값은 출력이 안된다. => 방법은? OUTER JOIN을 쓰는것
    OUTER JOIN에는 LEFT/ RIGHT/ FULL3가지가 존재한다.
*/



















