--PL/SQL 복습노트

/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체에 내장되어있는 절차적 언어
    SQL 문장내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP,FOR,WHILE) 지원하여 SQL의 단점을 보완
    다수의 SQL문을 한번에 실행 가능(BLOCK 구조) + 예외처리도 가능
    
    * PL / SQL 구조
    - [선언부] : DECLARE로 시작, 변수나 상수를 선언 및 초기화 하는 부분
    - 실행부   : BEGIN으로 시작, 무조건 있어야함!! SQL문 또는 제어문(조건문, 반복문) 등의 로직을 기술하는 부분
    - [예외처리부] : EXCEPTION으로 시작, 예외 발생시 해결하기 위한 구문을 미리 기술해둘 수 있는 구문
*/
-- 간단하게 화면에 HELLO ORACLE 출력!


/*
    1. DECLARE 선언부
    변수 및 상수 선언하는 공간 (선언과 동시에 초기화도 가능)
    일반타입변수, 레퍼런스타입변수, ROW타입변수
    
    1_1. 일반타입변수 선언 및 초기화
         [표현식] 변수명[CONSTANT -> 상수가 됨] 자료형 [:= 값];
*/


-- 1_2) 레퍼런스 타입 변수 선언 및 초기화(어떤 테이블의 어떤 컬럼의 데이터 타입을 참조해서 그 타입으로 지정)
-- [표현식] 변수명 테이블명.컬럼명%TYPE;


----------------------------------실습문제------------------------------------------
/*
    레퍼런스타입 변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고 
    각 자료형이 EMPLOYEE, DEPARTMENT 테이블을 참조하도록
    
    사용자가 입력한 사번의 사원의 사번, 사원명, 직급코드, 급여, 부서명 조회 한후  각변수에 담아서 출력
*/
-- 일반 타입 변수 EID NUMBER; OR EID NUMBER := 201;
-- 레퍼런스타입 변수 선언 : EID EMPLOYEE.EMP_ID%TYPE;
-- 실행부에서 입력을 받고 싶으면 EID = &사번;


------------------------------------------------------------------------------
-- 1_3) ROW타입 변수 선언
-- 테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
-- [표현식] 변수명 테이블명%ROWTYPE
-- 무조건 * 로 전체행을 조회해야함.



----------------------------------------------------------------------------------
/*
    2. BEGIN 실행부
*/

-- < 조건문 > 쓸때 PL SQL을 많이쓴다.
-- 1) IF 조건식 THEN 실행내용 END IF; 단독 IF문

-- 사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스울(%) 출력
-- 단, 보너스를 받지 않는 사원은 보너스율을 출력하기 전에 '보너스를 지급받지 않는 사원입니다. '출력


-------------------------------실습문제-------------------------------------------
-- 레퍼런스타입 변수 EID, ENAME, DTITLE, NCODE
-- 참조할 테이블 EMPLOYEE, DEPARTMENT, LOCATION

-- 일반타입 변수 TEAM 문자형(10) <= 국내팀 또는 해외팀 담을 예정
-- 사용자가 입력한 사번의 사번, 이름, 부서명, 근무 국가 코드 조회 후 각 변수에 대입
-- NCODE값이 KO일 경우 TEAM에 국내팀 
-- 아닐 경우 해외팀을 넣기
-- 사번, 이름, 부서, 소속(국내팀, 해외팀)에 대해 출력

------------------------------------실습문제----------------------------------------
--1. 사원의 연봉을 구하는 PL/SQL 블럭을 작성 만약에 보너스가 있을 시 보너스도 포함하여 계산 : 사번 입력받음.
-- 보너스가 없으면 보너스 미포함 연봉을 구함
-- 보너스 있으면 보너스 포함 연봉
-- 출력 급여, 이름 원달러\999,999,999()
-- ROWTYPE


--------------------------------------------------------------------------------
-- 3. IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 ELSE ....END IF;(IF - ELSIF - ELSE)
-- 점수를 입력받아서 SCORE 변수에 저장
-- 90점 이상 'A', 80점이상 'B' 70이상 'C' 60점 이상 'D' 그미만은 F
-- GRADE에 저장하고 당신의 점수는 XX점이고, 학점은 X학점입니다.


-- 급여
-- 500만원 이상 '고급'
-- 300만원 이상 '중급'
-- 300 미만 '초급'
-- 해당 사원의 급여등급은 XX입니다.


--------------------------------------------------------------------------------
--4. CASE 비교대상자 WHEN 동등비교할값1 THEN 결과값1 WHEN 동등비교할값2 THEN 결과값2..... ELSE 결과값 END;
-- SWITCH CASE와 비슷한 역할을 한다.


---- < 반복문 > 
/*
    1. BASIC LOOP문 
    
    [표현식]
    LOOP
        반복적으로 실행할 구문
        * 반복문을 빠져나갈 수 있는 구문
    END LOOP;
    
    * 반복문 빠져나갈 수 있는 구문(2가지)
    1) IF 조건식 THEN EXIT;
    2) EXIT WHEN 조건식;
    종료조건 없으면 오류발생함.
*/


-- 1~5까지 순차적으로 1씩 증가해서 출력

--------------------------------------------------------------------------------
/*
    2) FOR LOOP문
    
    [표현식]
    FOR 변수 IN [REVERSE -> 값을 점점 작아지게 하고 싶으면] 초기값..최종값
    LOOP
        반복적으로 실행할 구문;
    END LOOP;
    
    REVERSE 해도 작은값..큰값
*/

--------------------------------------------------------------------------------
/*
    3) WHILE LOOP문
    [표현식]
    WHILE 반복문이 수행될 조건
    LOOP
        반복실행할 구문
    END LOOP;
*/

--------------------------------------------------------------------------------
/*
    3. 예외처리부
    
    예외(EXCEPTION) : 실행 중 발생하는 오류
    
    [표현식]
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문1;
        WHEN 예외명2 THEN 예외처리구문2;
        ......
        WHEN OTHERS THEN 예외처리구문N; 모든 예외를 받는것이 OTHERS
        
        * 예외명에 뭘 써야할까?
        * 시스템 예외 (오라클에서 미리 정의해둔 예외)
        - NO_DATA_FOUND : SELECT 했는데 결과가 한 행도 없을 경우
        - TOO_MANY_ROWS : SELECT 한 결과가 여러행일 경우
        - ZERO_DIVIDE : 0으로 나눌 때
        - DUP_VAL_ON_INDEX: UNIQUE제약조건에 위배 됐을 경우
        ...
*/
-- 사용자가 입력한 수로 나눗셈 연산한 결과 출력











