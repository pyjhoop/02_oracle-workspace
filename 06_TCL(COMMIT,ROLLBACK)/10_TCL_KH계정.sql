--저장
/*
    <TCL : TRANSACTION CONTROL LANGUAGE>
    트랜젝션 제어 언어
    
    * 트랜젝션
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항(DML 추가, 수정, 삭제)들을 하나의 트랜젝션에 묶어서 처리
      DML문 한개를 수행할 때 트랜젝션이 존재하면 해당 트랜젝션에 같이 묶어서 처리
                          트랜젝션이 존재하지 않으면 트랜젝션을 만들어서 묶음
      COMMIT을 하기 전까지 변경사항들을 하나의 트랜젝션에 담게됨.
      COMMIT을 해야만 실제 디비에 반영이 된다고 생각하면 됨!
      - 트랜젝션에 대상이 되는 SQL: INSERT, UPDATE, DELETE(DML)
      - DML을 처리하면 트랜젝션이 만들어짐 COMMIT 하기 전까지 기존 트랜젝션에 수정사항이 추가됨.
      -- COMMIT하면 트랜젝션 삭제됨.
      
      COMMIT (트랜젝션 종료 처리 후 확정)
      ROLLBACK (트랜젝션 취소)
      SAVEPOINT(임시저장)
      
      COMMIT; 진행 : 한트랜젝션에 담겨있는 변경사항들을 실제 DB에 반영시키겠다는 의미(후에 트랜젝션은 사라짐)
      ROLLBACK; 진행 : 한트랜젝션에 담겨있는 변경사항들을 실제 DB에 반영하는게 아니라 취소를 한 후 마지막 COMMIT 시점으로 돌아감.
      SAVEPOINT 포인트명; 진행 : 현재 이 시점에 해당 포인트명으로 임시저장점을 정의해두는 것.
                              ROLLBACK 진행시 전체 변경사항들을 다 취소하는것이 아니라 일부만 롤백 가능!
*/

SELECT * FROM EMP_01;

--사번이 900번인 사원 지우기

DELETE FROM EMP_01
WHERE EMP_ID = 900;
--현재 트랜젝션이 만들어졌고 그 안에는 900이 삭제됨
-- 진짜 삭제된것 처럼 보임 그러나 COMMIT을 안했기에 실제 DB에는 적용이 안됨.

--사번이 901번인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 901;
-- 이러면 기존의 트랜젝션에 901번 삭제가 추가됨.
--즉, 트랜젝션에 DELTE 901이 담김.

ROLLBACK;
-- 롤백시 트랜젝션 자체가 삭제됨.
-- 변경사항이 취소되고, 트랜젝션도 없어짐. 데이터에 변경이 없어진다.
--COMMIT을 치면 실제 DB에 DELETE가 들어가서 삭제됨.
-------------------------------------------------------------------------------
-- 200번 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 200;

SELECT * FROM EMP_01;

-- 800번 황민현, 총무부 추가
INSERT INTO EMP_01 VALUES(800,'황민현','총무부');
--> 현재 트랜젝션이 생겨서 DELTE 200, INSERT 800이 존재한다.

COMMIT;
-- 트랜젝션에 있는 2개의 DML문이 실제 DB에 반영이 된다.
ROLLBACK; -- 이미 COMMIT을 해서 못 돌아간다.

------------------------------------------------------------------------------------
--217, 216,214 지워보자
DELETE FROM EMP_01
WHERE EMP_ID IN(214,216,217);

--임시저장점 잡기
SAVEPOINT SP;

--801, 안효섭, 인사관리부 사원 추가
INSERT INTO EMP_01 VALUES(801,'안효섭','인사관리부');
--218 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01;

ROLLBACK;
--여기서 롤백을 해버리면 중간저장 포함 전부다 취소됨
-- 그러나 나는 중간 저장 아래에 있는 것만 취소하고 싶음.

ROLLBACK TO SP;
--801추가랑 218 지우기만 롤백당함.

-----------------------------------------------------------------------------
--900, 901사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN(900,901);

--218번 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01;

-- DDL문
CREATE TABLE TEST(
    TID NUMBER
);
ROLLBACK;
-- DDL문을 수행하는 순간 트랜젝션이 실제 DB에 반영되고, COMMIT후에 DDL문이 수행됨.

-- DDL문 (CREATE, ALTER, DROP)을 수행하는 순간 기존에 트랜젝션에 있던 변경사항들을
-- 무조건 COMMIT을 함.
-- 즉, DDL문 수행 전 변경사항들이 있었다면 정확히 픽스(COMMIT, ROLLBACK)하고 하자!!

