--저장
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
SET SERVEROUTPUT ON;

BEGIN 
-- System.out.prinln("hello oracle");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
-- /을 써서 블럭이 하나 끝났다는 것을 알려줌 PLSQL은 블럭단위로 시작함.

-------------------------------------------------------------------------------
/*
    1. DECLARE 선언부
    변수 및 상수 선언하는 공간 (선언과 동시에 초기화도 가능)
    일반타입변수, 레퍼런스타입변수, ROW타입변수
    
    1_1. 일반타입변수 선언 및 초기화
         [표현식] 변수명[CONSTANT -> 상수가 됨] 자료형 [:= 값];
*/

DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
   -- ENAME := '배장남';
    EID := &번호;
    ENAME :='&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID : '|| EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------
-- 1_2) 레퍼런스 타입 변수 선언 및 초기화(어떤 테이블의 어떤 컬럼의 데이터 타입을 참조해서 그 타입으로 지정)
-- [표현식] 변수명 테이블명.컬럼명%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
--    EID := '300';
--    ENAME := '박연준';
--    SAL := 3000000;

--  사번이 200번인 사원의 사번, 사원명, 급여 조회해서 각 변수에 대입
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 201;
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
END;
/

----------------------------------실습문제------------------------------------------
/*
    레퍼런스타입 변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고 
    각 자료형이 EMPLOYEE, DEPARTMENT 테이블을 참조하도록
    
    사용자가 입력한 사번의 사원의 사번, 사원명, 직급코드, 급여, 부서명 조회 한후  각변수에 담아서 출력
*/
-- 일반 타입 변수 EID NUMBER; OR EID NUMBER := 201;
-- 레퍼런스타입 변수 선언 : EID EMPLOYEE.EMP_ID%TYPE;
-- 실행부에서 입력을 받고 싶으면 EID = &사번;



DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('직급코드 : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
END;
/
------------------------------------------------------------------------------
-- 1_3) ROW타입 변수 선언
-- 테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
-- [표현식] 변수명 테이블명%ROWTYPE
-- 무조건 * 로 전체행을 조회해야함.

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *  -- 모든 컬럼에 해당하는 값을 넣어야함
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
--    DBMS_OUTPUT.PUT_LINE(E); 
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || NVL(E.BONUS,0));
END;
/
----------------------------------------------------------------------------------
/*
    2. BEGIN 실행부
*/

-- < 조건문 > 쓸때 PL SQL을 많이쓴다.
-- 1) IF 조건식 THEN 실행내용 END IF; 단독 IF문

-- 사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스울(%) 출력
-- 단, 보너스를 받지 않는 사원은 보너스율을 출력하기 전에 '보너스를 지급받지 않는 사원입니다. '출력
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SAL);

    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율(%) : ' || BONUS*100 ||'%');
    
END;
/

--2. IF 조건식 THEN 실행내용 ELSE 실행내용 END IF;(IF - ELSE문)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SAL);

    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스율(%) : ' || BONUS*100 ||'%');
    END IF;   
END;
/

-------------------------------실습문제-------------------------------------------
-- 레퍼런스타입 변수 EID, ENAME, DTITLE, NCODE
-- 참조할 테이블 EMPLOYEE, DEPARTMENT, LOCATION

-- 일반타입 변수 TEAM 문자형(10) <= 국내팀 또는 해외팀 담을 예정
-- 사용자가 입력한 사번의 사번, 이름, 부서명, 근무 국가 코드 조회 후 각 변수에 대입
-- NCODE값이 KO일 경우 TEAM에 국내팀 
-- 아닐 경우 해외팀을 넣기
-- 사번, 이름, 부서, 소속(국내팀, 해외팀)에 대해 출력

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
    JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID)
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO'
        THEN TEAM:= '국내팀';
    ELSE
        TEAM:='해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 :'|| DTITLE );
    DBMS_OUTPUT.PUT_LINE('소속 : '|| TEAM);
    
END;
/

------------------------------------실습문제----------------------------------------
--1. 사원의 연봉을 구하는 PL/SQL 블럭을 작성 만약에 보너스가 있을 시 보너스도 포함하여 계산 : 사번 입력받음.
-- 보너스가 없으면 보너스 미포함 연봉을 구함
-- 보너스 있으면 보너스 포함 연봉
-- 출력 급여, 이름 원달러\999,999,999()
-- ROWTYPE

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    IF E.BONUS IS NOT NULL
        THEN DBMS_OUTPUT.PUT_LINE('급여 : '||E.SALARY||'  이름 : '||E.EMP_NAME||'  연봉 : '||LTRIM(TO_CHAR((E.SALARY +E.SALARY * E.BONUS)*12,'L999,999,999')));
    ELSE
         DBMS_OUTPUT.PUT_LINE('급여 : '||E.SALARY||'  이름 : '||E.EMP_NAME||'  연봉 : '||LTRIM(TO_CHAR(E.SALARY *12,'L999,999,999')));
    END IF;
    -- 이방법 말고 연봉 변수를 만들어서 출력문 하나로 처리해보자
END;
/

--------------------------------------------------------------------------------
-- 3. IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 ELSE ....END IF;(IF - ELSIF - ELSE)
-- 점수를 입력받아서 SCORE 변수에 저장
-- 90점 이상 'A', 80점이상 'B' 70이상 'C' 60점 이상 'D' 그미만은 F
-- GRADE에 저장하고 당신의 점수는 XX점이고, 학점은 X학점입니다.

DECLARE
    GRADE VARCHAR2(1);
    SCORE NUMBER;
BEGIN
    SCORE := &점수;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 '||SCORE||'점이고, 학점은 '||GRADE||'학점입니다.');
    
END;
/


-- 급여
-- 500만원 이상 '고급'
-- 300만원 이상 '중급'
-- 300 미만 '초급'
-- 해당 사원의 급여등급은 XX입니다.

DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY 
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    IF SAL> 5000000 THEN GRADE := '고급';
    ELSIF SAL> 3000000 THEN GRADE:= '중급';
    ELSE GRADE:= '초급';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여등급은 '||GRADE||'입니다.');

END;
/
--------------------------------------------------------------------------------
--4. CASE 비교대상자 WHEN 동등비교할값1 THEN 결과값1 WHEN 동등비교할값2 THEN 결과값2..... ELSE 결과값 END;
-- SWITCH CASE와 비슷한 역할을 한다.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); -- 부서명 보관하는 변수
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DNAME := CASE EMP.DEPT_CODE 
                WHEN 'D1' THEN '인사팀'
                WHEN 'D2' THEN '회계팀'
                WHEN 'D3' THEN '마케팅팀'
                WHEN 'D4' THEN '국내영업팀'
                WHEN 'D9' THEN '총무팀'
                ELSE '해외영업팀'
                END;
                
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME||'은(는) '||DNAME||'입니다.');

END;
/






















