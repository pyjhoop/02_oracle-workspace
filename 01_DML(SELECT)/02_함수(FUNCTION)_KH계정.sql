--먼저 저장
/*
    < 함수 FUNCTION >
    전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
    
    - 단일행 함수 : n개의 값을 읽어들여서 n개의 결과값을 리턴한다.(매 행마다 함수 실행 결과 반환)
    - 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴한다. (그룹을 지어 그룹별로 함수 실행 결과 반환)
    
    >> SELECT 절에 단일행 함수랑 그룹함수를 함께 사용 못함!!
        왜? : 결과행의 개수가 다르기 때문!!!
    >> 함수식을 기술 할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
*/


/*
    < 문자처리 함수 >
    
    *LENGHT / LENGHTB   => 결과값 NUMBER 타입
    
    LENGTH(컬럼|'문자열 값') : 해당 문자열 값의 글자수 반환
    
    LENGTHB(컬럼|'문자열 값') : 해당 문자열 값의 바이트 수 반환
    
    '김', '나','ㄱ' 한글자당 3BYTE => 박연준 9바이트
    영문자, 숫자, 특수문자 한글자당 1BYTE
*/

SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; --가상테이블! 데이블 쓸거 없을때 쓰는 것!

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- 매행마다 다 실행되고 있음 => 단일행 함수

/*
    * INSTR  => 많이쓰이기에 외워야 함.
    문자열로부터 특정 문자의 시작위치를 찾아서 반환 그냥 특정문자의 인덱스를 반환함.
    
    INSTR(컬럼|'문자열','찾고자하는 문자', ['찾을위치의 시작값', [순번]]) => 결과값은 NUMBER다.
    
    찾을 위치의 시작값
    1 : 앞에서부터 찾겠다.
    -1 : 뒤에서부터 찾겠다.
*/

SELECT INSTR('AABAACAABBAA','B') -- 인덱스 1부터 시작하네
FROM DUAL; -- 아무것도 안쓰면 찾을 위치의 시작값은 1이 기본값 => 앞에서부터 찾음 순번도 1이 기본값

SELECT INSTR('AABAACAABBAA','B',1)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',1,2)FROM DUAL; -- 몇번째 B를 찾을래? 가 순번이네
SELECT INSTR('AABAACAABBAA','B',-1,3)FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'_',1,1) AS "_의 위치" --_의 위치를 찾음.
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '@') AS "@의 위치"
FROM EMPLOYEE;
-- 특정 컬럼에서 문자의 위치를 알고싶을때는 INSTR를 사용
-- INSTR(컬럼|'리터럴', '찾을 문자', [찾을 위치의 시작값, [순번]]
--순번은 몇번째 문자를 찾을 것인가?
-- 찾을 위치의 시작값은 앞에서부터? 뒤에서부터>????

----------------------------------------------------------------------------
/*
    * SUBSTR
    문자열에서 특정 문자열을 추출해서 반환(자바와 유사)
    
    SUBSTR(STRING, POSITION,[LENGTH])        => 결과값이 CHARACTER타입
    - STRING : 문자타입컬럼 또는 '문자열값'
    - POSITON : 문자열을 추출할 시작 위치값
    - LENGTH : 추출할 문자 개수(생략시 끝까지 의미)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; --7번째부터 출력하네
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL; --5번째부터 2글자만 추출
SELECT SUBSTR('SHOWMETHEMONEY', 1,6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL; --뒤에서 8번째부터 3글자만 추출
SELECT SUBSTR('SHOWMETHEMONEY', -8,-3) FROM DUAL; -- 길이는 양수만 됨.

SELECT EMP_NAME, EMP_NO,SUBSTR(EMP_NO,8,1) AS "성별"
FROM EMPLOYEE;

--여자사원들만 조회하세요
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = '2' OR SUBSTR(EMP_NO,8,1) = '4';
WHERE SUBSTR(EMP_NO, 8,1) IN('2','4');

--남자사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8,1) = '1' OR SUBSTR(EMP_NO, 8,1) = '3';
WHERE SUBSTR(EMP_NO,8,1) IN(1,3) --원칙적으론 ''해야하지만 내부적으로 형변환이 되었기에 됬음.
ORDER BY EMP_NAME; -- 기본적으로 오름차순

--함수 중첩사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS "아이디"
FROM EMPLOYEE;
------------------------------------------------------------------------------------
/*
    * LPAD/RPAD
    문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
    
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자])
    
    문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열 반환
    
*/

--20만큼의 길이중 EMAIL 컬럼값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채워라
SELECT EMP_NAME, LPAD(EMAIL, 20) --덧붙이고자 하는 문자 생략시 기본값이 공백!!!
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20,'#')
FROM EMPLOYEE;
SELECT EMP_NAME, RPAD(EMAIL, 20,'#')
FROM EMPLOYEE;

--850101-2******나오게 조회 => 총 14글자.
SELECT RPAD('850101-2',14,'*')
FROM DUAL;

-- 헷갈리니깐 글로 써보고 함수적용하자
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS "주민번호"
FROM EMPLOYEE;
---------------------------------------------------------------------------------
/*
    LTRIM/ RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    LTRIM/RTRIM(STRING, ['제거할 문자들']) => 제거할 문자 생략하면 공백을 제거해줌
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거 후 문자열 반환
*/

SELECT LTRIM('   K H ') FROM DUAL; --공백 찾아서 제거하고 공백아닌 문자나오면 그냥 끝남.
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- 문자열에서 특정 "문자"를 찾아서 제거하기에 순서 상관없이 ABC인것들은 다 제거.

SELECT RTRIM('5782KH123','0123456789') FROM DUAL;

/*
    * TRIM
    문자열의 앞/ 뒤 / 양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    TRIM([[LEADING |TRAILING| BOTH]제거하고자 하는 문자들 FROM]STRING
*/

SELECT TRIM('   K H   ') FROM DUAL;
--SELECT TRIM('ZZZKHZZZ','Z') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --LEADING : 앞 => LTRIM과 유사

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;-- TRAILING: 뒤 => RTRIM과 유사

SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --기본값이 BOTH라는 거임. 양쪽이 제거가 된다.생략시 기본값.

------------------------------------------------------------------------------------
/*
    * LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP(STRING)   =>결과값은 CHARACTER 타입
    
    LOWER : 다 소문자로 변경한 문자열 반환 (자바에서의 TOLOWERCASE와 유사)
    UPPER : 다 대문자로 변경한 문자열 반환 (자바에서의 TOUPPERCASE와 유사)
    INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
*/

SELECT LOWER('Welcom To My World!') FROM DUAL;
SELECT UPPER('Welcom To My World!') FROM DUAL;
SELECT INITCAP('welcom to my world!') FROM DUAL;
---------------------------------------------------------------------------------
/*
    CONCAT
    문자열 두개 전달받아서 하나로 합친후 결과 반환
    
    CONCAT(STRING, STRING)          => 결과값 CHARACTER 타입
    
*/

SELECT CONCAT('ABC','초콜릿') FROM DUAL;
SELECT 'ABC'||'초콜릿' FROM DUAL;

SELECT CONCAT('ABC','초콜릿','먹고싶다') FROM DUAL; -- 오류 발생!! : 2개만 받을 수 있음
SELECT 'ABC' || '초콜릿' || '먹고싶다' FROM DUAL;

--------------------------------------------------------------------------------
/*
    *REPLACE
    REPALCE(STRING, STR1, STR2)         => 결과값은 CHARACTER 타입
    
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

------------------------------------------------------------------------------------
/*
    <숫자처리 함수>
    
    *ABS
    숫자의 절대값을 구해주는 함수
    
    ABS(NUMBER)         => 결과값은 NUMBER 타입!!
*/

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;

--------------------------------------------------------------------------------
/*
    * MOD
    두 수를 나눈 나머지값을 반환해주는 함수
    
    MOD(NUMBER,NUMBER)          =>결과값 NUMBER 타입!!
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9,3) FROM DUAL;

---------------------------------------------------------------------------------
/*  
    * ROUND
    반올림한 결과를 반환하는 함수
    ROUND(NUMBER, [위치])           =>결과값은 NUMBER 타입
    위치생략하면 0번째 자리에서 반올림한다.
    소숫점 1번째 자리에서 반올림한다.
*/

SELECT ROUND(123.466)FROM DUAL; -- 위치 생략시 0
SELECT ROUND(123.456,1) FROM DUAL;
SELECT ROUND(123.456,5) FROM DUAL; -- 자리수보다 크면 그대로 나옴.
SELECT ROUND(123.456,-1) FROM DUAL;
SELECT ROUND(123.456,-2) FROM DUAL;
--------------------------------------------------------------------------------
/*
    *CEIL
    올림처리 해주는 함수
    CEIL(NUMBER)
*/
SELECT CEIL(123.156)FROM DUAL; -- 올림이닌 무조건 올림 위치지정 불가.
-------------------------------------------------------------------------------
/*
    *FLOOR
    소수점 아래 버림 처리하는 함수
    FLOOR(NUMBER)
*/
SELECT FLOOR(3.141528) FROM DUAL;
SELECT FLOOR(123.973) FROM DUAL; -- 소수점 무조건 버림, 위치지정 불가하다.
--------------------------------------------------------------------------------
/*
    *TRUNC(절삭하다)  중요 
    위치 지정 가능한 버림처리해주는 함수
    TRUNC(NUMBER, [위치])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(123.456,2) FROM DUAL;
SELECT TRUNC(123.456,-1) FROM DUAL;
-- 소숫점은 절삭되고 실수 영역은 값이 내림으로 바뀐다.

--------------------------------------------------------------------------------
/*
    <날짜 처리 함수>
*/
--* SYSDATE : 시스템 날짜 및 시간 반환(현재 날짜 및 시간)
SELECT SYSDATE FROM DUAL; -- 연필 클릭하면 시간도 확인 가능하다.

-- *MONTHS_BETWEEN (DATE1, DATE2) : 두 날짜 사이의 개월 수 => 내부적으로 DATE 1 - DATE2 후 나누기 30,31 이 진행됨.
-- 결과값은 NUMBER 타입
-- EMPLOYEE에서 사원명, 근무 일수, 근무 개월 수
SELECT EMP_NAME, LPAD(TRUNC(SYSDATE - HIRE_DATE),10) ||' 일' AS "근무일수"
,FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))||' 개월' AS "근무개월 수"
FROM EMPLOYEE;

--* ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월수를 더해서 날짜를 리턴
-- 결과값 : DATE 타입
SELECT ADD_MONTHS(SYSDATE,6) FROM DUAL;

--EMPLOYEE 에서 사원명, 입사일, 입사 후 6개월이 된 날짜
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) AS "수습이 끝난 날짜"
FROM EMPLOYEE;

-- NEXT_DAY (DATE, 요일(문자|숫자) : 특정날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수.
-- 결과값 : DATE 타입
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금') FROM DUAL;
-- 1. 일요일, 2. 월요일 ,...... 7. 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE,6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL; -- 언어가 한국어여서 이건 안먹힘.

-- 언어 변경
SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--* LAST_DAY(DATE): 해당 월의 마지막 날짜를 반환해줌.
-- => 결과값 : DATE 타입
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--EMPLOYEE에서 사원명, 입사일, 입사한달의 마지막 날짜, 입사한 달에 근무한 일수 
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE AS "근무일수"
FROM EMPLOYEE;

/*
    * EXTRACT : 특정날짜로부터 년도| 월 | 일 값을 추출해서 반환하는 함수.
    
    EXTRACT(YEAR FROM DATE) :연도만 추출
    EXTRACT(MONTH FROM DATE) : 월만 추출
    EXTRACT(DAY FROM DATE) : 일만 추출
*/

--사원명, 입사년도, 입사워, 입사일 입사년도순으로 정렬
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도", EXTRACT(MONTH FROM HIRE_DATE) AS "입사월"
, EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
--ORDER BY EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE);
--ORDER BY "입사년도", "입사월", "입사일"; --ASC, DESC
ORDER BY 2,3,4;
-- 순서는 FROM -> WHERE -> SELECT -> ORDER BY 이기에 ORDER BY에서는 별칭사용 가능.
-- 또한 WHERE 과 ORDER BY에서는 컬럼의 순번을 입력해서 사용도 가능하다. 


-----------------------------------------------------------------------------------
/*
    < 형변환 함수 >
    무조건 외워야함.
    
    *TO_CHAR() : 숫자 타입 또는 날짜 타입의 값을 문자타입으로 변환시켜주는 함수
    
    TO_CHAR(숫자|날짜, [포멧])        => 결과값은 CHARATER 타입!!
*/

-- 숫자타입 => 문자타입
SELECT TO_CHAR(1234) FROM DUAL; --'1234'로 바뀌어있음

SELECT TO_CHAR(12345,'99999') FROM DUAL; --'99999' 5칸짜리 공간확보 오른쪽 정렬도됨, 빈칸 공백 
SELECT TO_CHAR(1234,'0000') FROM DUAL; -- 9또는 0만 가능. 0일경우 빈공간을 0으로 채움.
--LPAD와 비슷하네
SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- 현재 설정된 나라(L: LOCAL)의 화폐단위
SELECT TO_CHAR(1234,'$99999') FROM DUAL;
SELECT TO_CHAR(12345,'L999,999') FROM DUAL; -- 이렇게 포멧을 지정할 수 있다.

SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999') AS "SALARY"
FROM EMPLOYEE;
-- 결국 숫자를 포멧팅 할려면 문자열로 바꿔줘야함.

--날짜 타입 => 문자타입
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE)FROM DUAL; -- 클랙해보면 다름! 날짜 타입은 시간 나옴 얘는 안나옴
SELECT TO_CHAR(SYSDATE,'AM HH:MI:SS')FROM DUAL; --HH: 12시간 형식
SELECT TO_CHAR(SYSDATE,'PM HH24:MI:SS')FROM DUAL; --HH24: 24시간 형식
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD DAY DY')FROM DUAL;
-- 날짜는 자바보단 DB에서 많이 다룬다. 자바는 좀 이상해서
SELECT TO_CHAR(SYSDATE,'MON, YYYY')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YEAR MM-DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY.MM.DD AM HH:MI:SS DAY')FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY-MM-DD DAY HH:MI:SS')
FROM EMPLOYEE;

--EX) 1990년 02월 06일 형식으로
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE,'YYYY"년" MM"월" DD"일"') -- 포멧에 없는 것은 쌍따옴표로 감싸면 됨.
FROM EMPLOYEE;

--년도와 관련된 포멧
SELECT TO_CHAR(SYSDATE,'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE,'RRRR'),
       TO_CHAR(SYSDATE,'RR'),
       TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

--월과 관련된 포멧
SELECT TO_CHAR(SYSDATE,'MM'),
       TO_CHAR(SYSDATE,'MON'),
       TO_CHAR(SYSDATE,'MONTH'),
       TO_CHAR(SYSDATE,'RM')
FROM DUAL;

--일과 관련된 포멧
SELECT TO_CHAR(SYSDATE,'DDD'), --올해 기준으로 오늘이 며칠째인지
       TO_CHAR(SYSDATE,'DD'), --월 기준으로 오늘이 몇일째 인지.
        TO_CHAR(SYSDATE,'D') --주 기준으로 몇일째 인지 1. 일요일 2. 월요일,..
FROM DUAL;

--요일에 대한 포멧
SELECT TO_CHAR(SYSDATE,'DAY'),
       TO_CHAR(SYSDATE,'DY') 
FROM DUAL;
-----------------------------------------------------------------------------
/*
    * TO_DATE : 숫자타입 또는 문자타입 데이터를 날짜 타입으로 변환시켜주는 함수
    
    TO_DATE(숫자|문자,[포멧])         => 결과값 : DATE 타입
*/
SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL; -- 에러발생
SELECT TO_DATE('070101') FROM DUAL; --첫글자가 0인 경우에는 문자타입으로 변경후 해야한다.

SELECT TO_DATE('041030 143000') FROM DUAL; --에러발생
SELECT TO_DATE('041030 143000','YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630','YYMMDD') FROM DUAL; --2014년
SELECT TO_DATE('980630','YYMMDD') FROM DUAL; -- 2098년으로 나옴 => 무조건 현재 세기로 반영

SELECT TO_DATE('140630','RRMMDD') FROM DUAL; --2014
SELECT TO_DATE('980630','RRMMDD') FROM DUAL; --1998
--RR: 해당 두자리 년도 값이 50 미만일 경우 현재 세기를 반영, 50 이상일 경우 이전세기를 반영
-- 주민 번호를 RR로 다룬다.
--웹브라우저에서 날짜를 입력하면 자바로 넘어갈때 문자열 타입으로 넘어감. 또한 DB에도 문자열 타입으로 넘어감
--실제 데이터는 DATE 타입이기에 이런 형변환을 해줘야함.

----------------------------------------------------------------------------------------
/*
    *TO_NUMBER : 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    TO_NUMBER(문자,[포멧])      => 결과값 : NUMBER 타입
*/

SELECT TO_NUMBER('013234320') FROM DUAL; --0이 빠져서 숫자타입으로 저장됨.

SELECT '100000000' + '5500000' FROM DUAL; --오라클에서는 자동형변환이 잘 돼있음
SELECT '100,000,000' + '5,500,000' FROM DUAL; -- 오류남 안에 숫자만 있어야 자동 형변환이 된다.
SELECT TO_NUMBER('100,000,000','999,999,999')+ TO_NUMBER('55,000','99,999') FROM DUAL; -- 강제형변환
--------------------------------------------------------------------------------
/*
    < NULL 처리 함수 > 중요 꼭 외워야함.
*/
--NVL(컬럼, 해당 컬럼값이 NULL일경우 반환할 값)
SELECT EMP_NAME, BONUS,NVL(BONUS,0)
FROM EMPLOYEE;

--전체 사원의 이름과 보너스 포함 연봉을 해보겠다.
SELECT EMP_NAME, TO_CHAR((SALARY+SALARY*NVL(BONUS,0))*12, 'L999,999,999' ) || '원' AS "연봉"
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE,'부서없음')
FROM EMPLOYEE;

SELECT NVL(NULL, 'NULL임') FROM DUAL;

--NVL2(컬럼, 반환값1, 반환값2) : NULL이 아니면 반환값1이 출력되고 NULL이면 반환값2가 출력됨.
--컬럼값이 존재할 경우 반환값 1을 반환
-- 컬럼값이 NULL일 경우 반호나값 2를 반환
SELECT EMP_NAME, NVL2(DEPT_CODE, '부서있음', '"부서없음"')
FROM EMPLOYEE;

-- 보너스가 있는: 0.7/ 없는 : 0.1
SELECT EMP_NAME, NVL2(BONUS,0.7,0.1)
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2)
-- 두 개의 값이 일치하면 NULL 반환
-- 두 개의 값이 일치하지 않으면 비교대상1 값을 반환
SELECT NULLIF('123','123')FROM DUAL;
SELECT NULLIF('123','456')FROM DUAL;

--------------------------------------------------------------------------------
/*
    <선택 함수>  외우면 됨
    *DECODE(비교하고자하는 대상(컬럼|산술연산|함수식), 비교값1, 결과값1, 비교값2, 결과값2)
    
    SWITCH(동등비교 대상){
    CASE 비교값1:BREAK;
    CASE 비교값2:BREAK;
    ...
    DEFAULT: BREAK;
*/

--사번, 사원명, 주민번호
SELECT
EMP_ID, EMP_NAME, EMP_NO,SUBSTR(EMP_NO, 8,1),
DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여') AS "성별"
FROM EMPLOYEE;

--직원의 급여를 조회시 직급별로 인상해서 조회
-- J7 10% 인상 SALARY*1.1하면 됨.
--J6인 사원 15%인상
--J5인 사원 20% 인상
-- 그외의 나머지 사원은 급여를 5%인상
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE,'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2,SALARY*1.05) AS "인상된 급여" -- 디폴트는 그냥 마지막에 값만 쌔리면 됨
FROM EMPLOYEE;

/*
    *CASE WHEN THEN
    
    CASE WHEN 조건식1 THEN 결과값1
        WHEN 조건식2 THEN 결과값2
        ...
        ELSE 결과값
    END
*/

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '고급개발자'
            WHEN SALARY >=3500000 THEN '중급개발자'
            ELSE '초급개발자'
        END AS "레벨"
FROM EMPLOYEE;

---------------------------------------< 그룹 함수 >-----------------------------
--1. SUM(NUMBER) : 해당 컬럼 값들의 총합계를 구해서 반환해주는 함수

-- EMPLOYEE 테이블의 전 사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE; --전체 사원이 한 그룹으로 묶임

-- 남자 사원들의 총 급여 합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('1','3'); --남자 사원들이 한 그룹으로 묶임

-- 부서코드가 D5인 사원들의 총 연봉 합
SELECT TO_CHAR(SUM(SALARY*12),'999,999,999')||'원' AS "연봉 합"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2. AVG(NUMBER) : 해당 컬럼값의 평균값을 구해서 반환한다.
-- 전체사원의 평균 급여 조회
SELECT TRUNC(AVG(SALARY))
FROM EMPLOYEE;

--3. MIN(여러타입) : 해당 컬럼값들 중에 가장 작은 값 구해서 반환
SELECT MIN(EMP_NAME),MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(여러타입) : 해당 컬럼값들 중에 가장 큰 값 구해서 반환
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|컬럼|DISTINCT 컬럼) : 조회된 행 개수를 세서 반환
-- COUNT(*): 조회된 결과의 모든 행 개수를 세서 반환
-- COUNT(컬럼) : 제시한 해당 컬럼값이 NULL이 아닌 것만 행 개수 세서 반환
-- COUNT(DISTINCT 컬럼) : 해당 컬럼값 중복을 제거한 후 행 개수 세서 반환

-- 전체 사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자 사원수 
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('2','4');

-- 부서가 없는사람수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

-- 보너스를 받는 사원 수
SELECT COUNT(BONUS) -- 컬럼이 NULL이 아닌거만 카운팅 한다.
FROM EMPLOYEE;

--부서배치를 받은 사원수 
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;















