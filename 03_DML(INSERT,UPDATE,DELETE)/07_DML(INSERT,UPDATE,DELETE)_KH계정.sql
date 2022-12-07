--먼저 저장
-- 폴더 만들고 파일 저장

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

INSERT INTO EMPLOYEE
VALUES(900,'차은우','900101-1234567','CHA_OO@KH.OR.KR','01011112222',
       'D1', 'J7','S3',4000000,0.2,200,SYSDATE,NULL,DEFAULT);
-- 뭐 가장 중요하다.
SELECT * FROM EMPLOYEE;

/*
    2) INSERT INTO 테이블명(컬럼1, 컬럼2,...) VALUES();
        테이블에 내가 선택한 컬럼에 대한 값만 INSERT 할 때 사용
        선택이 안된 컬럼은 기본적으로 NULL이 들어감 
        => NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값 제시해야됨!
        단, DEFAULT 값이 있는 경우는 NULL이 아닌 DEFAULT값 들어간다.
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE, SAL_LEVEL,HIRE_DATE)
VALUES(901,'주지훈','990101-1111111','J2','S2',SYSDATE);

SELECT * FROM EMPLOYEE;
-- ENT_YN은 디폴트값으로 들어가있음!!

INSERT 
 INTO EMPLOYEE
     (
          EMP_ID
        , EMP_NAME
        , EMP_NO
        ,JOB_CODE
        , SAL_LEVEL
        ,HIRE_DATE
    )
VALUES
    (
         901
        , '주지훈'
        , '990101-1111111'
        , 'J2'
        , 'S2'
        , SYSDATE
    );
-- 실무에서는 이런식으로 한다. 
-------------------------------------------------------------------------------
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
--전체 사원들의 사번, 이름, 부서명 조회

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 (
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

/*
    [표현식]
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명,...)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명,...)
    서브쿼리;
*/

-- 우선 테스트할 테이블 만들기
-- 구조만 배끼기

DROP TABLE EMP_DEPT;
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1=0;
SELECT * FROM EMP_DEPT;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1=0;
   
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

--부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE,HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

-- * 조건을 사용해서도 각 테이블에 값 INSERT 가능
--> 2000년도 이전 입사한 입사자들에 대한 정보 담을 테이블 
-- 테이블 구조만 배껴서 먼저 만들기
CREATE TABLE EMP_OLD 
AS (SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 2=1); 



CREATE TABLE EMP_NEW
AS (SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0);
    
SELECT * FROM EMP_OLD; --2000년도 이전 입사자
SELECT * FROM EMP_NEW; -- 2000년도 이후 입사자

/*
    [표현식]
    INSERT ALL
    WHEN 조건1 THEN
        INTO TABLE1 VALUES(컬럼명, 컬럼명,...)
    WHEN 조건2 THEN    
        INTO TALBE2 VALUES(컬럼명, 컬럼명,....)
    서브쿼리;
*/

INSERT ALL
WHEN HIRE_DATE <'2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >='2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD; --2000년도 이전 입사자
SELECT * FROM EMP_NEW; -- 2000년도 이후 입사자

---------------------------------------------------------------------------------
/*
    3. UPDATE
        테이블에 기록되어있는 기존의 데이터를 수정하는 구문
        
        [표현식]
        UPDATE 테이블명
        SET 컬럼명 = 바꿀값,
            컬럼명 = 바꿀값,
            컬럼명 = 바꿀값,
            ... -> 여러개의 컬럼값을 동시변경 가능하다.(,로 나열해야됨!! AND 아님)
        [WHERE 조건]; --> 생략하면 전체행의 모든 행의 데이터가 변경된다!! => 그래서 꼭 조건을 기술 해야됨!!
        
        -- 컬럼에 있는 데이터의 값을 변경한다. 
    CRUD
    C: CREATE 생성 => INSERT
    R: READ => SELECT
    U: UPDATE
    D: DELETE
    
    항상 데이터를 수정, 삭제시에는 확인을 하고 해야함.
*/

--복사본 테이블 만든 후 작업
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'; -- 총무부

ROLLBACK;
-- D9의 부서명을 전략기획팀으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9'; -- 총무부

--== DML같은경우 행수가 가장 중요함. 항상 행수를 확인하는 것을 봐야함.
SELECT * FROM DEPT_COPY;

--우선 복사본 떠서 진행 
-- 복사본 만들기전에 서브쿼리 부터 확인해봄
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- 노옹철 사원의 급여를 100만원으로 변경 -- 데이터 주석으로 백업을 해두기
-- UPDATE전에는 항상 업데이트 원하는 부분을 SELECT해서 조회해보자
SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '노옹철';


UPDATE EMP_SALARY
SET SALARY = 1000000 --3700000
WHERE EMP_NAME = '노옹철'; 
ROLLBACK;

-- 선동일 사원의 급여를 700만원으로 변경하고, 보너스도 0.2로 변경

SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '선동일';

UPDATE EMP_SALARY
SET SALARY = 7000000,-- 8000000
    BONUS = '0.2'  -- 0.3
WHERE EMP_NAME = '선동일';

--전체 사원의 급여를 기존의 급여의 10% 인상한 금액(기존금액*1.1)
SELECT * FROM EMP_SALARY;

UPDATE EMP_SALARY
SET SALARY = SALARY*1.1;
-- 몇개행이 업데이트 되었는지 확인해보자.

-- * UPDATE시 서브쿼리 사용가능

/*
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    WHERE 조건;
*/
--방명수 사원의 급여, 보너스값을 유재식 사원의 급여와 보너스 값으로 변경
SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '방명수'; --1518000	, NULL

-- 단일행 서브쿼리
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '유재식'),--1518000	
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')-- NULL
WHERE EMP_NAME = '방명수';

-- 다중열 서브쿼리
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

-- ASIA지역에서 근무하는 사원들의 보너스 값을 0.3으로 변경
-- ASIA 지역에서 근무하는 사원들 조회
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID)
WHERE LOCAL_NAME LIKE 'ASIA%';

SELECT * FROM EMP_SALARY;

UPDATE EMP_SALARY
SET BONUS = '0.3'
WHERE EMP_NAME IN (SELECT EMP_NAME
                   FROM EMP_SALARY
                   JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                   JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID)
                   WHERE LOCAL_NAME LIKE 'ASIA%');
-- EMP_NAME이라는 다중행 비교해야하니 IN

---------------------------------------------------------------------------------
-- UPDATE시에도 해당 컬럼에 대한 제약조건 위배하면 안됨!!!
-- 사번이 200번인 사원의 이름을 NULL로 변경하겠다.

SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE
SET EMP_NAME = NULL -- 선동일
WHERE EMP_ID = '200';
--ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL 제약조건 위반

--노옹철 사원의 직급코드를 J9로 변경
-- 외래키변경인데 부모 컬럼의 데이터가 아닌경우 오류가 난다.
UPDATE EMPLOYEE
SET JOB_CODE = 'J9'
WHERE EMP_NAME = '노옹철';
--ORA-02291: integrity constraint (KH.SYS_C007159) violated - parent key not found
-- FOREIGN KEY 제약조건 위배!!
-- INSERT 할때도 제약조건 지켜줘야 한다.
----------------------------------------------------------------------------------
COMMIT;

/*
    4. DELETE
        테이블에 기록된 데이터를 삭제하는 구문(한행 단위로 삭제됨)
        
        [표현식]
        DELETE FROM 테이블명
        [WHERE 조건];
        -- 조건은 무조건 써야함. 
        -- 조건을 안쓰면 테이블에 있는 모든 데이터가 삭제됨
        --조건에 맞는 행이 삭제됨
*/
-- 차은우 사원의 데이터 지우기
SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '주지훈';

UPDATE EMPLOYEE
SET EMP_NAME = '선동일'
WHERE EMP_NAME = 'NULL';

SELECT * FROM EMPLOYEE;
COMMIT;
ROLLBACK;
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '차은우';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '주지훈';

COMMIT;

--DEPT_ID가 D1인 부서를 삭제하겠다.
SELECT * FROM DEPARTMENT
WHERE DEPT_ID = 'D1';

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--ORA-02292: integrity constraint (KH.SYS_C007158) violated - child record found
-- 외래키 제약 조건 위반!
-- D1의 값을 가져다 쓰는 자식 데이터가 있기 때문에 삭제가 안됨!!
-- 테이블 만들때 ON DELETE  제약조건을 넣었어야 헀다. 삭제하고 싶으면


SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';
SELECT * FROM DEPARTMENT;

ROLLBACK;

------- * TRUNCATE: 테이블의 전체 행을 삭제할 때 상요되는 구문
--                  특징이 DELTE보다 수행 속도가 빠름.
            --      별도의 조건제시 불가, 절대로 ROLLBACK불가하다.
-- [표현식] TRUNCATE TABLE 테이블명;

SELECT * FROM EMPLOYEE_COPY3;

TRUNCATE TABLE EMPLOYEE_COPY3;







