-- 저장
-- 퀴즈 1
-- CREATE USER TEST IDENTIFIED BY 1234; TLFGOD
-- USER TEST이(가) 생성되었습니다.
-- 접속하려하는데 에러발생함.
-- 문제점 : 계정생성만 했고 접속 권한을 부여하지 않았기 때문임.
-- 조치된 쿼리 : GRANT CONNECT, RESOURCE TO TEST;

-- 퀴즈 2 조인
CREATE TABLE TB_JOB(
    JOB_CODE NUMBER PRIMARY KEY,
    JOB_NAME VARCHAR2(10) NOT NULL

);

CREATE TABLE TB_EMP(
    EMP_NO NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(10) NOT NULL,
    JOB_NO NUMBER REFERENCES TB_JOB(JOB_CODE)
);

-- 위의 두 테이블이 있다는 가정하에 
-- 두 테이블 조인해서 EMP_NO, EMP_NAME, JOB_NO, JOB_NAME 컬럼을 조회할꺼임
-- 이때 실행한 SQL문 
SELECT EMP_NO, EMP_NAME, JOB_NO, JOB_NAME
FROM TB_EMP
JOIN TB_JOB USING(JOB_NO); -- 에러발생함
-- 왜 발생했을까?
-- ON으로 바꾸면 됨.
-- 문제점: JOB_NO 컬럼이 TB_EMP에는 존재하지만 TB_JOB에는 존재하지 않기 때문에 USING구문 안된다.
-- 해결내용 : USING(JOB_NO) 를 ON(JOB_NO = JOB_CODE)로 바꾸면 된다.

--------------------------------------------------------------------------------
-- 테이블 생성관련해서 데이터 타입(CHAR, VARCHAR2)차이점
-- 오라클 객체(SEQUENCT, VIEW,...)뭔지 정의
-- 제약조건  -> 제약조건을 추가하려고 한다. 추가하는 ALTER문 작성해라.
-- DCL 뭐임? GRANT, REVOKE
-- 커밋 롤백 뭐임?













