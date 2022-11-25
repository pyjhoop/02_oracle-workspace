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

SELECT ROUND(123.466)FROM DUAL;





